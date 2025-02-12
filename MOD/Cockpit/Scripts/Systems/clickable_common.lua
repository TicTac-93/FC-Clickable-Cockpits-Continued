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
self:listen_command(device_commands.CANOPY)
self:listen_command(device_commands.ENGL_OFF)
self:listen_command(device_commands.ENGR_OFF)

---This is called by the button handlers assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number unknown
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.CANOPY then
    dispatch_action(nil, iCommands.SYS_Canopy)
    FCCLOG.info("CANOPY")
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
