-- This handles behavior specific to the F-5E

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

-- Localization function
local gettext = require("i_18n")
_ = gettext.translate

local self = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.02  -- Update will be called 50 times per second
make_default_activity(update_time_step)

-- 0 = MSL, 1 = A/A1, 2 = A/A2, 3 = A/G MAN
local f5e_mode = 0
local radar_elev_value = 0
local radar_elev_stopped = true


---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.NWS_STRUT then
    dispatch_action(nil, iCommands.SYS_NoseWheelSteering)

  elseif command == device_commands.RDR_TGL then
    dispatch_action(nil, iCommands.RADAR_Toggle)

  elseif command == device_commands.RDR_VERT then
    radar_elev_value = value
    radar_elev_stopped = false

  elseif command == device_commands.RDR_RANGE then
    if value > 0 then
      dispatch_action(nil, iCommands.RADAR_ZoomOut)
    else
      dispatch_action(nil, iCommands.RADAR_ZoomIn)
    end

  -- NOTE: I think this is behaving correctly, it doesn't allow for entering Dogfight Missile Mode but users will probably have a bind for that.
  --       You can always enter A/A GUNS and then hit your Cannon keybind
  elseif command == device_commands.MM_AA then
    if value > 0 then
      f5e_mode = f5e_mode + 1
    else
      f5e_mode = f5e_mode - 1
    end

    -- Clamp values
    if f5e_mode > 4 then
      f5e_mode = 0
    elseif f5e_mode < 0 then
      f5e_mode = 4
    end

    -- Reset by switching to NAV mode momentarily
    dispatch_action(nil, iCommands.MM_Nav)  -- mode 0
    if f5e_mode == 1 then  -- MSL
      -- FCCLOG.info("F5E MSL")
      dispatch_action(nil, iCommands.MM_Air_BVR)
    elseif f5e_mode == 2 then  -- A/A1 GUNS
      -- FCCLOG.info("F5E A/A1 GUNS")
      dispatch_action(nil, iCommands.MM_Air_Boresight)
      dispatch_action(nil, iCommands.W_Cannon)
    elseif f5e_mode == 3 then  -- A/A2 GUNS
      -- FCCLOG.info("F5E A/A2 GUNS")
      dispatch_action(nil, iCommands.MM_Air_Boresight)
      dispatch_action(nil, iCommands.W_Cannon)
      dispatch_action(nil, iCommands.RADAR_Mode)
    elseif f5e_mode == 4 then  -- A/G MAN
      -- FCCLOG.info("F5E A/G")
      dispatch_action(nil, iCommands.MM_Ground)
    end
  end

end

---Handles radar elevation adjustment
---Adjustment speed is DIRECTLY dependent on the update_time_step!
function radar_elev_adjust()
  if radar_elev_stopped then
    -- Return early if we aren't moving the radar right now
    return
  end

  if radar_elev_value == 0 then
    dispatch_action(nil, iCommands.RADAR_MoveStop)
    radar_elev_stopped = true
  elseif radar_elev_value > 0 then
    dispatch_action(nil, iCommands.RADAR_MoveUp)
  elseif radar_elev_value < 0 then
    dispatch_action(nil, iCommands.RADAR_MoveDown)
  
  end

end

-- This gets called every update_time_step
function update()
  radar_elev_adjust()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_f5e INIT")
end

need_to_be_closed = false