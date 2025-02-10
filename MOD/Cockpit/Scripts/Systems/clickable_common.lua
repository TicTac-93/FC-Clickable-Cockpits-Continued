-- This will house all universal clickable logic
-- eg: Canopy, Gear, Flaps, Mirrors, HUD brightness, etc

dofile(LockOn_Options.script_path.."defs_commands.lua")

local update_time_step = 0.02  -- Update will be called 50 times per second
make_default_activity(update_time_step)

---I think this gets called every update_time_step, but we may not need it
---since we're not implementing new features.
function update()
  
end

---This is called by the button handlers assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number unknown
function SetCommand(command, value)

  if command == device_commands.CANOPY then
    log.info("CANOPY ACTIVATED")
  end

end

need_to_be_closed = false
