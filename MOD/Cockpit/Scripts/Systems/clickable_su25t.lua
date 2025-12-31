-- This handles behavior specific to the Su-25T

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

-- Localization function
local gettext = require("i_18n")
_ = gettext.translate

local self = GetSelf()

local update_time_step = 0.1  -- Update will be called 10 times per second
make_default_activity(update_time_step)

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.AP_MODE_ATT then
    dispatch_action(nil, iCommands.AP_AttitudeMode)

  elseif command == device_commands.AP_MODE_ALT then
    dispatch_action(nil, iCommands.AP_AltMode)

  elseif command == device_commands.AP_MODE_NAV then
    dispatch_action(nil, iCommands.AP_RouteMode)

  elseif command == device_commands.AP_MODE_LEVEL then
    dispatch_action(nil, iCommands.AP_LevelMode)

  elseif command == device_commands.AP_MODE_RALT then
    dispatch_action(nil, iCommands.AP_RadarMode)

  -- IR Jammer
  elseif command == device_commands.ECM_TGL then
    dispatch_action(nil, iCommands.CM_IR)

  -- Shkval
  elseif command == device_commands.EOS_TGL then
    dispatch_action(nil, iCommands.TGT_EOSOnOff)

  -- Shkval zoom
  elseif command == device_commands.RDR_ZOOM then
    if value > 0 then
      dispatch_action(nil, iCommands.RADAR_ZoomIn)
    else
      dispatch_action(nil, iCommands.RADAR_ZoomOut)
    end

  -- ELINT / Fantasmagoria pod
  elseif command == device_commands.RDR_TGL then
    dispatch_action(nil, iCommands.RADAR_Toggle)

  -- Mercury FLIR pod
  elseif command == device_commands.RDR_MODE then
    dispatch_action(nil, iCommands.TGT_LLTV)

  elseif command == device_commands.TGT_LASER then
    dispatch_action(nil, iCommands.W_LaserDesignator)

  elseif command == device_commands.HUD_SIGHT then
    dispatch_action(nil, iCommands.MM_Gunsight)

  elseif command == device_commands.MM_AG then
    if value > 0 then
      dispatch_action(nil, iCommands.MM_FI0)
    else
      dispatch_action(nil, iCommands.MM_Ground)
    end

  elseif command == device_commands.WEP_RIP_QTY then
    if value > 0 then
      dispatch_action(nil, iCommands.W_RippleQuantityCycle)
    else
      -- Similar to the F-15C fuel selector, cycle backwards by going forwards
      local rip_mode_count = 3
      while rip_mode_count > 0 do
        dispatch_action(nil, iCommands.W_RippleQuantityCycle)
        rip_mode_count = rip_mode_count - 1
      end
    end

  end

end

-- This gets called every update_time_step
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_su25t INIT")
end

need_to_be_closed = false
