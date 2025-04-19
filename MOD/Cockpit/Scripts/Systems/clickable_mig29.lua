-- This handles behavior specific to the MiG-29 A/G/S

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

local self = GetSelf()
local sensor_data = get_base_data()

-- Timestep has to be fairly small, otherwise view adjustments will stutter
local update_time_step = 0.1  -- Update will be called 10 times per second
make_default_activity(update_time_step)

local mig29_start_mode = 2  -- 1 == Left, 2 == Both, 3 == Right
local mig29_master_mode = 2  -- 1 == A/G, 2 == Nav, 3 == BVR, 4 == Vert Scan, 5 == HMD Cue, 6 == Boresight Scan, 7 == Longitudinal
local mig29_commands_modes = {
  iCommands.MM_Ground,
  iCommands.MM_Nav,
  iCommands.MM_Air_BVR,
  iCommands.MM_Air_VerticalScan,
  iCommands.MM_Air_HelmetCue,
  iCommands.MM_Air_Boresight,
  iCommands.MM_FI0
}

self:listen_command(iCommands.MM_Nav)
self:listen_command(iCommands.MM_Air_BVR)
self:listen_command(iCommands.MM_Air_Boresight)
self:listen_command(iCommands.MM_Air_HelmetCue)
self:listen_command(iCommands.MM_Air_VerticalScan)
self:listen_command(iCommands.MM_FI0)
self:listen_command(iCommands.MM_Ground)

-- Debugging
self:listen_command(iCommands.AP_MIG29_MinAlt)

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.AP_MODE_ALT then
    dispatch_action(nil, iCommands.AP_AltMode)

  elseif command == device_commands.AP_MODE_ATT then
    dispatch_action(nil, iCommands.AP_AttitudeMode)

  elseif command == device_commands.AP_MODE_DAMPER then
    dispatch_action(nil, iCommands.AP_AltBankMode)

  elseif command == device_commands.AP_MODE_GCA then
    dispatch_action(nil, iCommands.AP_GroundAvoidance)

  -- Not working yet, might need to be sent to a specific device like the ADI commands in the F-86 and MiG-15
  -- elseif command == device_commands.ALT_SET_RADAR then
  --   if value > 0 then
  --     dispatch_action(nil, iCommands.AP_MIG29_MinAlt, 1)
  --   else
  --     dispatch_action(nil, iCommands.AP_MIG29_MinAlt, -1)
  --   end

  elseif command == device_commands.ENG_TGL then
    mig29_starter_switch(value)

  elseif command == device_commands.ENG_ON then
    mig29_engine_start()

  elseif command == device_commands.EOS_TGL then
    dispatch_action(nil, iCommands.TGT_EOSOnOff)

  elseif command == device_commands.MM_AA then
    mig29_master_mode_switch(value)

  elseif command == device_commands.RDR_TGL then
    dispatch_action(nil, iCommands.RADAR_Toggle)

  elseif command == device_commands.RDR_VERT then
    if value > 0 then
      dispatch_action(nil, iCommands.TGT_SelectorUp)
    elseif value < 0 then
      dispatch_action(nil, iCommands.TGT_SelectorDown)
    else
      dispatch_action(nil, iCommands.TGT_SelectorStop)
    end

  elseif command == device_commands.RDR_HORZ then
    if value > 0 then
      dispatch_action(nil, iCommands.TGT_SelectorLeft)
    elseif value < 0 then
      dispatch_action(nil, iCommands.TGT_SelectorRight)
    else
      dispatch_action(nil, iCommands.TGT_SelectorStop)
    end

  elseif command == device_commands.RDR_FREQ then
    dispatch_action(nil, iCommands.RADAR_PulseFreq)

  elseif command == device_commands.RDR_MODE then
    dispatch_action(nil, iCommands.RADAR_Mode)

  elseif command == device_commands.WEP_RIP_MODE then
    dispatch_action(nil, iCommands.W_SalvoOnOff)
    dispatch_action(nil, iCommands.W_CannonBurst)

  elseif command == device_commands.TGT_SIZE then
    if value > 0 then
      dispatch_action(nil, iCommands.TGT_WingspanInc)
    elseif value < 0 then
      dispatch_action(nil, iCommands.TGT_WingspanDec)
    else
      dispatch_action(nil, iCommands.TGT_WingspanStop)
  end

  -- Listen for user input that might change the current Master Mode
  elseif command == iCommands.MM_Ground then
    mig29_master_mode = 1

  elseif command == iCommands.MM_Nav then
    mig29_master_mode = 2
    
  elseif command == iCommands.MM_Air_BVR then
    mig29_master_mode = 3
    
  elseif command == iCommands.MM_Air_VerticalScan then
    mig29_master_mode = 4
    
  elseif command == iCommands.MM_Air_HelmetCue then
    mig29_master_mode = 5
    
  elseif command == iCommands.MM_Air_Boresight then
    mig29_master_mode = 6
    
  elseif command == iCommands.MM_FI0 then
    mig29_master_mode = 7

  end

end

function mig29_starter_switch(value)
  -- Make sure input value is an integer
  if value > 0 then
    value = 1
  else
    value = -1
  end

  mig29_start_mode = mig29_start_mode + value

  -- Clamp to range 1:3
  -- Return early, since the mode isn't actually changing
  if mig29_start_mode > 3 then
    mig29_start_mode = 3
    return
  elseif mig29_start_mode < 1 then
    mig29_start_mode = 1
    return

  -- Tell user which mode is selected
  elseif mig29_start_mode == 1 then
    print_message_to_user(_("Engine Starter: LEFT"))
  elseif mig29_start_mode == 2 then
    print_message_to_user(_("Engine Starter: BOTH"))
  elseif mig29_start_mode == 3 then
    print_message_to_user(_("Engine Starter: RIGHT"))
  end
end

function mig29_engine_start()
  if mig29_start_mode == 1 then
    dispatch_action(nil, iCommands.SYS_LeftEngineStart)
  elseif mig29_start_mode == 2 then
    dispatch_action(nil, iCommands.SYS_EnginesStart)
  elseif mig29_start_mode == 3 then
    dispatch_action(nil, iCommands.SYS_RightEngineStart)
  end
end

function mig29_master_mode_switch(value)
  -- Make sure input value is an integer
  if value > 0 then
    value = 1
  else
    value = -1
  end

  mig29_master_mode = mig29_master_mode + value
  -- Clamp 1:7, lua arrays are not 0-indexed
  if mig29_master_mode < 1 then
    mig29_master_mode = 1
  elseif mig29_master_mode > 7 then
    mig29_master_mode = 7
  end

  dispatch_action(nil, mig29_commands_modes[mig29_master_mode])
end

-- This gets called every update_time_step
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_mig29 INIT")
end

need_to_be_closed = false
