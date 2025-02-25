-- This will house all universal clickable logic
-- eg: Canopy, Gear, Flaps, Mirrors, HUD brightness, etc

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

local self = GetSelf()

local sensor_data = get_base_data()
local update_time_step = 0.2  -- Update will be called 5 times per second
make_default_activity(update_time_step)

-- Register all device_commands that will be handled in this file
-- If it's not in this list, it cannot trigger SetCommand()
-- self:listen_command(device_commands.CANOPY)
-- self:listen_command(device_commands.ENGL_OFF)
-- self:listen_command(device_commands.ENGR_OFF)

---This is called by the button handlers assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number unknown
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.ALT_SET then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_AltIncrease)
    else
      dispatch_action(nil, iCommands.SYS_AltDecrease)
    end

  elseif command == device_commands.CANOPY then
    dispatch_action(nil, iCommands.SYS_Canopy)

  elseif command == device_commands.CAUTION_CLR then
    dispatch_action(nil, iCommands.SYS_ResetMasterCaution)

  elseif command == device_commands.CM_AUTO then
    dispatch_action(nil, iCommands.CM_ContinuousStart)

  elseif command == device_commands.CM_CHAFF then
    dispatch_action(nil, iCommands.CM_DropChaffOnce)

  elseif command == device_commands.CM_FLARE then
    dispatch_action(nil, iCommands.CM_DropFlareOnce)

  elseif command == device_commands.WPT_CYCLE then
    if value > 0 then
      dispatch_action(nil, iCommands.MM_NextTarget)
    else
      dispatch_action(nil, iCommands.MM_PrevTarget)
    end

  elseif command == device_commands.JET_EXT then
    if value == 1 then
      dispatch_action(nil, iCommands.SYS_JettisonWeapons)
    else
      dispatch_action(nil, iCommands.SYS_JettisonWeaponsStop)
    end

  elseif command == device_commands.ECM_TGL then
    dispatch_action(nil, iCommands.CM_Jamming)

  elseif command == device_commands.ENGL_OFF then
    dispatch_action(nil, iCommands.SYS_LeftEngineStop)

  elseif command == device_commands.ENGL_ON then
    dispatch_action(nil, iCommands.SYS_LeftEngineStart)

  elseif command == device_commands.ENGR_OFF then
    dispatch_action(nil, iCommands.SYS_RightEngineStop)

  elseif command == device_commands.ENGR_ON then
    dispatch_action(nil, iCommands.SYS_RightEngineStart)

  elseif command == device_commands.FLAPS then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_FlapsOn)
    else
      dispatch_action(nil, iCommands.SYS_FlapsOff)
    end

  elseif command == device_commands.GEAR then
    -- Should update this to be a springloaded_3_pos switch, signals for gear down and up
    dispatch_action(nil, iCommands.SYS_GearCycle)

  elseif command == device_commands.HUD_BRT then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_HUDBrightnessUp)
    else
      dispatch_action(nil, iCommands.SYS_HUDBrightnessDown)
    end

  elseif command == device_commands.LGT_NAV then
    dispatch_action(nil, iCommands.SYS_LightsNav)

  elseif command == device_commands.LGT_LANDING then
    dispatch_action(nil, iCommands.SYS_LightsLanding)

  elseif command == device_commands.LGT_INT then
    dispatch_action(nil, iCommands.SYS_LightsCockpit)

  elseif command == device_commands.MIRROR then
    dispatch_action(nil, iCommands.VIEW_Mirrors)

  elseif command == device_commands.MM_AA then
    dispatch_action(nil, iCommands.MM_FI0)

  elseif command == device_commands.MM_AG then
    dispatch_action(nil, iCommands.MM_Ground)

  elseif command == device_commands.MM_NAV then
    dispatch_action(nil, iCommands.MM_NAV)

  elseif command == device_commands.POWER_TGL then
    dispatch_action(nil, iCommands.SYS_Power)

  elseif command == device_commands.WEP_RIP_INT then
    if value > 0 then
      dispatch_action(nil, iCommands.W_RippleIntervalUp)
    else
      dispatch_action(nil, iCommands.W_RippleIntervalDown)
    end

  elseif command == device_commands.WEP_RIP_MODE then
    dispatch_action(nil, iCommands.W_ReleaseModeCycle)

  elseif command == device_commands.WEP_RIP_QTY then
    dispatch_action(nil, iCommands.W_RippleQuantityCycle)

  elseif command == device_commands.RWR_VOL then
    if value > 0 then
      dispatch_action(nil, iCommands.RWR_VolumeUp)
    else
      dispatch_action(nil, iCommands.RWR_VolumeDown)
    end

  elseif command == device_commands.RWR_MODE then
    dispatch_action(nil, iCommands.RWR_Mode)

  elseif command == device_commands.VIEW_VERT then
    if value > 0 then
      dispatch_action(nil, iCommands.VIEW_CameraMoveUp)
    else
      dispatch_action(nil, iCommands.VIEW_CameraMoveDown)
    end

  elseif command == device_commands.STICK_TGL then
    FCCLOG.info("SHOW/HIDE STICK")

  elseif command == device_commands.WEP_CYCLE then
    dispatch_action(nil, iCommands.W_ChangeWeapon)

  end


end

-- This gets called every update_time_step, but we may not need it
-- since we're not implementing new features.
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_common INIT")
end

need_to_be_closed = false
