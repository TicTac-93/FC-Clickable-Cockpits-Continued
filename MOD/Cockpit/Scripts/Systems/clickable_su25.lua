-- This handles behavior specific to the Su-25

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

  if command == device_commands.ASP_VERT then
    if value > 0 then
      dispatch_action(0, iCommands.SYS_HUDFilter, -1)
    else
      dispatch_action(0, iCommands.SYS_HUDFilter, 1)
    end

  elseif command == device_commands.FLAPS then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_FlapsCycle)
    else
      dispatch_action(nil, iCommands.SYS_FlapsOn)
    end

  elseif command == device_commands.HUD_SIGHT then
    dispatch_action(nil, iCommands.MM_Gunsight)

  elseif command == device_commands.TGT_LASER then
    dispatch_action(nil, iCommands.W_LaserDesignator)

  elseif command == device_commands.MM_AG then
    if value > 0 then
      dispatch_action(nil, iCommands.MM_FI0)
    else
      dispatch_action(nil, iCommands.MM_Ground)
    end

  -- Laser designator adjustment
  elseif command == device_commands.TGT_HORZ then
    if value > 0 then
      dispatch_action(0, iCommands.RADAR_MoveLeft)
    elseif value < 0 then
      dispatch_action(0, iCommands.RADAR_MoveRight)
    else
      dispatch_action(0, iCommands.RADAR_MoveStop)
    end

  elseif command == device_commands.TGT_VERT then
    if value > 0 then
      dispatch_action(0, iCommands.RADAR_MoveUp)
    elseif value < 0 then
      dispatch_action(0, iCommands.RADAR_MoveDown)
    else
      dispatch_action(0, iCommands.RADAR_MoveStop)
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
  FCCLOG.info("clickable_su25 INIT")
end

need_to_be_closed = false
