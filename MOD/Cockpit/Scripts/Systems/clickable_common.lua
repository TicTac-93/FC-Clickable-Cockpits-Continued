-- This handles all default clickable logic, if an aircraft requires more specific implementation
-- it will be in its clickable_xxx.lua file

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")
-- dofile(LockOn_Options.script_path.."/Utilities/dump_data.lua")  -- Debug scripts

local self = GetSelf()
local sensor_data = get_base_data()
-- dump_table(sensor_data)

-- Timestep has to be fairly small, otherwise view adjustments will stutter
local update_time_step = 0.02  -- Update will be called 50 times per second
make_default_activity(update_time_step)

-- Used to drive behavior in update()
seat_stopped = true

local trim_yaw_value = 0
local trim_yaw_stopped = true
local trim_pitch_value = 0
local trim_pitch_stopped = true
local trim_roll_value = 0
local trim_roll_stopped = true


-- NOTE: Consider refactoring this with a table lookup?  There are a LOT of if...else statements to run through.

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  -- ==================================================
  -- Master Modes

  if command == device_commands.MM_AA then
    dispatch_action(nil, iCommands.MM_FI0)

  elseif command == device_commands.MM_AG then
    dispatch_action(nil, iCommands.MM_Ground)

  elseif command == device_commands.MM_NAV then
    dispatch_action(nil, iCommands.MM_Nav)

  elseif command == device_commands.WPT_CYCLE then
    if value > 0 then
      dispatch_action(nil, iCommands.MM_NextTarget)
    else
      dispatch_action(nil, iCommands.MM_PrevTarget)
    end


  -- ==================================================
  -- Misc Aircraft Systems

  elseif command == device_commands.ALT_SET then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_AltIncrease)
    else
      dispatch_action(nil, iCommands.SYS_AltDecrease)
    end

  elseif command == device_commands.CANOPY then
    dispatch_action(nil, iCommands.SYS_Canopy)

  elseif command == device_commands.CAUTION_CLR then
    dispatch_action(nil, iCommands.SYS_ResetMasterCaution)

  elseif command == device_commands.CHUTE then
    dispatch_action(nil, iCommands.SYS_Parachute)

  elseif command == device_commands.CLOCK then
    dispatch_action(nil, iCommands.SYS_ClockElapsedTimeReset)

  elseif command == device_commands.CLOCK2 then
    dispatch_action(nil, iCommands.SYS_FlightClockReset)

  elseif command == device_commands.CM_AUTO then
    dispatch_action(nil, iCommands.CM_ContinuousRelease)

  elseif command == device_commands.CM_CHAFF then
    dispatch_action(nil, iCommands.CM_DropChaffOnce)

  elseif command == device_commands.CM_FLARE then
    dispatch_action(nil, iCommands.CM_DropFlareOnce)

  elseif command == device_commands.ECM_TGL then
    dispatch_action(nil, iCommands.CM_Jamming)

  elseif command == device_commands.EJECT then
    dispatch_action(nil, iCommands.SYS_Eject)

  elseif command == device_commands.FUEL_AA_TGL then
    dispatch_action(nil, iCommands.SYS_AirRefuel)

  elseif command == device_commands.FUEL_DUMP then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_DumpFuel)
    else
      dispatch_action(nil, iCommands.SYS_DumpFuelStop)
    end

  elseif command == device_commands.MIRROR then
    dispatch_action(nil, iCommands.VIEW_Mirrors)

  elseif command == device_commands.RWR_VOL then
    if value > 0 then
      dispatch_action(nil, iCommands.RWR_VolumeUp)
    else
      dispatch_action(nil, iCommands.RWR_VolumeDown)
    end

  elseif command == device_commands.RWR_MODE then
    dispatch_action(nil, iCommands.RWR_Mode)

  -- The actual view adjustment is handled in update()
  elseif command == device_commands.VIEW_VERT then
    seat_adj = value
    seat_stopped = false


  -- ==================================================
  -- Engines and Power

  elseif command == device_commands.ENGL_OFF then
    dispatch_action(nil, iCommands.SYS_LeftEngineStop)

  elseif command == device_commands.ENGL_ON then
    dispatch_action(nil, iCommands.SYS_LeftEngineStart)

  elseif command == device_commands.ENGR_OFF then
    dispatch_action(nil, iCommands.SYS_RightEngineStop)

  elseif command == device_commands.ENGR_ON then
    dispatch_action(nil, iCommands.SYS_RightEngineStart)

  elseif command == device_commands.POWER_TGL then
    dispatch_action(nil, iCommands.SYS_Power)


  -- ==================================================
  -- Lights / HUD

  elseif command == device_commands.HUD_BRT then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_HUDBrightnessUp)
    else
      dispatch_action(nil, iCommands.SYS_HUDBrightnessDown)
    end
    
  elseif command == device_commands.HUD_FILTER then
    dispatch_action(nil, iCommands.SYS_HUDFilter)

  elseif command == device_commands.LGT_COLLISION then
    dispatch_action(nil, iCommands.SYS_LightsAntiCollision)

  elseif command == device_commands.LGT_NAV then
    dispatch_action(nil, iCommands.SYS_LightsNav)

  elseif command == device_commands.LGT_LANDING then
    dispatch_action(nil, iCommands.SYS_LightsLanding)

  elseif command == device_commands.LGT_INT then
    dispatch_action(nil, iCommands.SYS_LightsCockpit)


  -- ==================================================
  -- Gear / Control Surfaces

  elseif command == device_commands.FLAPS then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_FlapsOff)
    elseif value < 0 then
      dispatch_action(nil, iCommands.SYS_FlapsOn)
    end

  elseif command == device_commands.GEAR then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_GearUp)
    elseif value < 0 then
      dispatch_action(nil, iCommands.SYS_GearDown)
    end

  elseif command == device_commands.AIRBRAKE then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_AirbrakeOn)
    else
      dispatch_action(nil, iCommands.SYS_AirbrakeOff)
    end

  elseif command == device_commands.TRIM_YAW then
    trim_yaw_value = value
    trim_yaw_stopped = false

  elseif command == device_commands.TRIM_PITCH then
    trim_pitch_value = value
    trim_pitch_stopped = false

  elseif command == device_commands.TRIM_ROLL then
    trim_roll_value = value
    trim_roll_stopped = false


  -- ==================================================
  -- Weapons / Pylons

  elseif command == device_commands.WEP_RIP_INT then
    if value > 0 then
      dispatch_action(nil, iCommands.W_RippleIntervalUp)
    elseif value < 0 then
      dispatch_action(nil, iCommands.W_RippleIntervalDown)
    end

  elseif command == device_commands.WEP_RIP_MODE then
    dispatch_action(nil, iCommands.W_ReleaseModeCycle)

  elseif command == device_commands.WEP_RIP_QTY then
    dispatch_action(nil, iCommands.W_RippleQuantityCycle)

  elseif command == device_commands.JET_EXT then
    if value == 1 then
      dispatch_action(nil, iCommands.SYS_JettisonWeapons)
    else
      dispatch_action(nil, iCommands.SYS_JettisonWeaponsStop)
    end

  elseif command == device_commands.JET_FUEL then
    dispatch_action(nil, iCommands.SYS_JettisonFuel)

  elseif command == device_commands.JET_ALL then
    for i = 1, 6, 1 do
      dispatch_action(nil, iCommands.SYS_JettisonWeapons)
      dispatch_action(nil, iCommands.SYS_JettisonWeaponsStop)
    end
    dispatch_action(nil, iCommands.SYS_JettisonFuel)

  elseif command == device_commands.WEP_CYCLE then
    dispatch_action(nil, iCommands.W_ChangeWeapon)

  end

  -- Not implemented in FC3 planes
  -- elseif command == device_commands.STICK_TGL then
  --   FCCLOG.info("SHOW/HIDE STICK")

end



---Handles camera adjustments (scootch up, down, forward, back)
---Adjustment speed is DIRECTLY dependent on the update_time_step!
function view_adjust()
  if seat_stopped then
    -- Return early if we aren't moving the camera right now
    return
  end
  
  if seat_adj == 0 then
    dispatch_action(nil, iCommands.VIEW_CameraMoveStop)
    seat_stopped = true
  elseif seat_adj > 0 then
    dispatch_action(nil, iCommands.VIEW_CameraMoveUp)
  elseif seat_adj < 0 then
    dispatch_action(nil, iCommands.VIEW_CameraMoveDown)
  end

end

---Handles rudder trim
---Adjustment speed is DIRECTLY dependent on the update_time_step!
function trim_rudder_adjust()
  if trim_yaw_stopped then
    -- Return early if we aren't moving the trim right now
    return
  end

  if trim_yaw_value == 0 then
    dispatch_action(nil, iCommands.SYS_TrimStop)
    trim_yaw_stopped = true
  elseif trim_yaw_value > 0 then
    dispatch_action(nil, iCommands.SYS_TrimRudderLeft)
  else  -- < 0
    dispatch_action(nil, iCommands.SYS_TrimRudderRight)
  end
end

---Handles elevator trim
---Adjustment speed is DIRECTLY dependent on the update_time_step!
function trim_pitch_adjust()
  if trim_pitch_stopped then
    -- Return early if we aren't moving the trim right now
    return
  end

  if trim_pitch_value == 0 then
    dispatch_action(nil, iCommands.SYS_TrimStop)
    trim_pitch_stopped = true
  elseif trim_pitch_value > 0 then
    dispatch_action(nil, iCommands.SYS_TrimPitchUp)
  else  -- < 0
    dispatch_action(nil, iCommands.SYS_TrimPitchDown)
  end
end

---Handles aileron trim
---Adjustment speed is DIRECTLY dependent on the update_time_step!
function trim_roll_adjust()
  if trim_roll_stopped then
    -- Return early if we aren't moving the trim right now
    return
  end

  if trim_roll_value == 0 then
    dispatch_action(nil, iCommands.SYS_TrimStop)
    trim_roll_stopped = true
  elseif trim_roll_value > 0 then
    dispatch_action(nil, iCommands.SYS_TrimRollLeft)
  else  -- < 0
    dispatch_action(nil, iCommands.SYS_TrimRollRight)
  end
end

-- This gets called every update_time_step
function update()
  view_adjust()
  trim_rudder_adjust()
  trim_pitch_adjust()
  trim_roll_adjust()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_common INIT")
end

need_to_be_closed = false
