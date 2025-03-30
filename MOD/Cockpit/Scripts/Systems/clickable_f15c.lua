-- This handles behavior specific to the F-15C

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

-- Localization function
local gettext = require("i_18n")
_ = gettext.translate

local self = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.02  -- Update will be called 50 times per second
make_default_activity(update_time_step)


-- Used to drive behavior in update()
local radar_elev_value = 0
local radar_elev_stopped = true

local trim_takeoff = false

local bingo_index_val = 0
local bingo_index_stopped = true

local fuel_sel_count = 0


---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.AP_TGL then
    dispatch_action(nil, iCommands.AP_Toggle)

  elseif command == device_commands.AP_MODE_ALT then
    dispatch_action(nil, iCommands.AP_AltMode)

  elseif command == device_commands.AP_CAS_PITCH then
    dispatch_action(nil, iCommands.AP_F15_CASPitch)

  elseif command == device_commands.AP_CAS_ROLL then
    dispatch_action(nil, iCommands.AP_F15_CASRoll)

  elseif command == device_commands.AP_CAS_YAW then
    dispatch_action(nil, iCommands.AP_F15_CASYaw)

  elseif command == device_commands.FUEL_BINGO then
    bingo_index_val = value
    bingo_index_stopped = false

  elseif command == device_commands.ENGL_TGL then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_LeftEngineStart)
    else
      dispatch_action(nil, iCommands.SYS_LeftEngineStop)
    end

  elseif command == device_commands.ENGR_TGL then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_RightEngineStart)
    else
      dispatch_action(nil, iCommands.SYS_RightEngineStop)
    end

  elseif command == device_commands.RDR_TGL then
    dispatch_action(nil, iCommands.RADAR_Toggle)

  elseif command == device_commands.RDR_VERT then
    radar_elev_value = value
    radar_elev_stopped = false

  -- Change size of radar scan area in STT mode
  elseif command == device_commands.RDR_HORZ then
    if value > 0 then
      dispatch_action(nil, iCommands.TGT_PredictedRangeInc)
    else
      dispatch_action(nil, iCommands.TGT_PredictedRangeDec)
    end

  elseif command == device_commands.RDR_MODE then
    dispatch_action(nil, iCommands.RADAR_Mode)

  elseif command == device_commands.RDR_RANGE then
    if value > 0 then
      dispatch_action(nil, iCommands.RADAR_ZoomOut)
    else
      dispatch_action(nil, iCommands.RADAR_ZoomIn)
    end

  -- Perform bit-test by reading the animation arg from the cockpit?
  elseif command == device_commands.FUEL_SEL then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_F15_FuelQtySel)
    else
      fuel_sel_count = 5
      while fuel_sel_count > 0 do
        dispatch_action(nil, iCommands.SYS_F15_FuelQtySel)
        fuel_sel_count = fuel_sel_count - 1
      end
    end

  elseif command == device_commands.TRIM_TO then
    if trim_takeoff then
      dispatch_action(nil, iCommands.SYS_TrimOff)
      trim_takeoff = false
    else
      dispatch_action(nil, iCommands.SYS_TrimOn)
      trim_takeoff = true
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
    dispatch_action(nil, iCommands.TGT_SelectorStop)
    radar_elev_stopped = true
  elseif radar_elev_value > 0 then
    dispatch_action(nil, iCommands.TGT_SelectorUp)
  else  -- < 0
    dispatch_action(nil, iCommands.TGT_SelectorDown)
  end
end

---Handles adjusting the Bingo Fuel index
---Adjustment speed is DIRECTLY dependent on the update_time_step!
function bingo_index_adjust()
  if bingo_index_stopped then
    -- Return early if we aren't adjusting the index right now
    return
  end

  if bingo_index_val == 0 then
    dispatch_action(0, iCommands.SYS_F15_BingoIndex, 0)
    bingo_index_stopped = true
  elseif bingo_index_val > 0 then
    dispatch_action(0, iCommands.SYS_F15_BingoIndex, 1)
  else  -- < 0
    dispatch_action(0, iCommands.SYS_F15_BingoIndex, -1)
  end
end

-- This gets called every update_time_step
function update()
  radar_elev_adjust()
  bingo_index_adjust()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_f15c INIT")
end

need_to_be_closed = false