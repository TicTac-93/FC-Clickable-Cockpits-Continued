-- This handles behavior specific to the Su-27 / J-11A

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

-- Localization function
local gettext = require("i_18n")
_ = gettext.translate

local self = GetSelf()

local update_time_step = 0.1  -- Update will be called 10 times per second
make_default_activity(update_time_step)

local su27_mode_aa = 2  -- 1 == Longitudinal, 2 == Nav, 3 == BVR, 4 == Vert Scan, 5 == Boresight Scan, 6 == Helmet Cue
local su27_commands_aa = {
  iCommands.MM_FI0,
  iCommands.MM_Nav,
  iCommands.MM_Air_BVR,
  iCommands.MM_Air_VerticalScan,
  iCommands.MM_Air_Boresight,
  iCommands.MM_Air_HelmetCue
}

self:listen_command(iCommands.MM_Nav)
self:listen_command(iCommands.MM_Air_BVR)
self:listen_command(iCommands.MM_Air_Boresight)
self:listen_command(iCommands.MM_Air_HelmetCue)
self:listen_command(iCommands.MM_Air_VerticalScan)
self:listen_command(iCommands.MM_FI0)
self:listen_command(iCommands.MM_Ground)

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.AP_MODE_ATT then
    dispatch_action(nil, iCommands.AP_AttitudeMode)

  elseif command == device_commands.AP_MODE_ALT then
    dispatch_action(nil, iCommands.AP_AltBankMode)

  elseif command == device_commands.AP_MODE_NAV then
    dispatch_action(nil, iCommands.AP_RouteMode)

  elseif command == device_commands.AP_MODE_GCA then
    dispatch_action(nil, iCommands.AP_RadarMode)

  elseif command == device_commands.AP_MODE_RESET then
    dispatch_action(nil, iCommands.AP_Disengage)

  elseif command == device_commands.AP_MODE_LEVEL then
    dispatch_action(nil, iCommands.AP_LevelMode)

  elseif command == device_commands.AP_MODE_DAMPER then
    dispatch_action(nil, iCommands.SYS_DirectControl)

  elseif command == device_commands.EOS_TGL then
    dispatch_action(nil, iCommands.TGT_EOSOnOff)

  elseif command == device_commands.FLAPS_OFF then
    dispatch_action(nil, iCommands.SYS_FlapsOff)

  elseif command == device_commands.FLAPS_ON then
    dispatch_action(nil, iCommands.SYS_FlapsOn)

  elseif command == device_commands.HUD_SIGHT then
    dispatch_action(nil, iCommands.MM_Gunsight)

  elseif command == device_commands.HUD_MODE then
    dispatch_action(nil, iCommands.SYS_SU27_HUDonHDD)

  elseif command == device_commands.MM_AA then
    su27_master_mode_switch(value)

  elseif command == device_commands.MM_AG then
    if value > 0 then
      -- Enter last selected AA mode
      dispatch_action(nil, su27_commands_aa[su27_mode_aa])
    else
      dispatch_action(nil, iCommands.MM_Ground)
    end

  elseif command == device_commands.RDR_ZOOM then
    if value > 0 then
      dispatch_action(nil, iCommands.RADAR_ZoomIn)
    else
      dispatch_action(nil, iCommands.RADAR_ZoomOut)
    end

  elseif command == device_commands.INTAKE_TGL then
    dispatch_action(nil, iCommands.SYS_IntakeScreens)

  elseif command == device_commands.NWS_TGL then
    dispatch_action(nil, iCommands.SYS_NoseWheelSteeringRange)

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

  elseif command == device_commands.TGT_SIZE then
    if value > 0 then
      dispatch_action(nil, iCommands.TGT_WingspanInc)
    elseif value < 0 then
      dispatch_action(nil, iCommands.TGT_WingspanDec)
    else
      dispatch_action(nil, iCommands.TGT_WingspanStop)
    end

  elseif command == device_commands.WEP_RIP_MODE then
    dispatch_action(nil, iCommands.W_SalvoOnOff)


  -- Listen for user input that might change the current Master Mode
  elseif command == iCommands.MM_FI0 then
    su27_mode_aa = 1

  elseif command == iCommands.MM_Nav then
    su27_mode_aa = 2

  elseif command == iCommands.MM_Air_BVR then
    su27_mode_aa = 3

  elseif command == iCommands.MM_Air_VerticalScan then
    su27_mode_aa = 4

  elseif command == iCommands.MM_Air_Boresight then
    su27_mode_aa = 5

  elseif command == iCommands.MM_Air_HelmetCue then
    su27_mode_aa = 6

  end

end


function su27_master_mode_switch(value)
  -- Make sure input value is an integer
  if value > 0 then
    value = 1
  else
    value = -1
  end

  su27_mode_aa = su27_mode_aa + value
  -- Clamp 1:6, lua arrays are not 0-indexed
  if su27_mode_aa < 1 then
    su27_mode_aa = 1
  elseif su27_mode_aa > 6 then
    su27_mode_aa = 6
  end

  dispatch_action(nil, su27_commands_aa[su27_mode_aa])
end

-- This gets called every update_time_step
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_su27 INIT")
end

need_to_be_closed = false
