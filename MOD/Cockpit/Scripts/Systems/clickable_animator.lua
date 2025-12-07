-- This handles updating animated connectors, so they stay aligned to the cockpit model

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")
dofile(LockOn_Options.script_path.."/Utilities/dump_data.lua")  -- Debug scripts

local self = GetSelf()

-- Timestep controls how often we update the position of animated connectors
local update_time_step = 0.1  -- Update will be called 10 times per second
make_default_activity(update_time_step)

-- Declare some vars for storing animated clickable elements, scoped to this file
local PNT_GEAR
local PNT_CANOPY
local PNT_MIRROR_L
local PNT_MIRROR_U
local PNT_MIRROR_R
local PNT_MISSING  -- This point does not exist in any FCC files, and is purely to check for errors

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

end

-- This gets called every update_time_step
function update()
  
  -- Check if we found each point during post_initialize() before attempting to update them
  -- Condensed to one-liners since we aren't doing anything complex
  if PNT_GEAR then PNT_GEAR:update() end
  if PNT_CANOPY then PNT_CANOPY:update() end
  if PNT_MIRROR_L then PNT_MIRROR_L:update() end
  if PNT_MIRROR_U then PNT_MIRROR_U:update() end
  if PNT_MIRROR_R then PNT_MIRROR_R:update() end
  if PNT_MISSING then PNT_MISSING:update() end

end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  -- Store the clickable elements we're interested in updating.
  PNT_GEAR = get_clickable_element_reference("PNT_GEAR")
  PNT_CANOPY = get_clickable_element_reference("PNT_CANOPY")
  PNT_MIRROR_L = get_clickable_element_reference("PNT_MIRROR_L")
  PNT_MIRROR_U = get_clickable_element_reference("PNT_MIRROR_U")
  PNT_MIRROR_R = get_clickable_element_reference("PNT_MIRROR_R")
  PNT_MISSING = get_clickable_element_reference("PNT_MISSING")
  
  FCCLOG.info("clickable_animator INIT")
end

need_to_be_closed = false
