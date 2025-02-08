-- Run automatically by EDGE
-- More or less responsible for initializing the rest of the plugin
--
-- Since the plugin should only run for aircraft that it's been associated with in entry.lua,
-- and should only run if their corresponding option is enabled, we can proceed with starting up.

local this_dir = LockOn_Options.script_path
current_aircraft = get_aircraft_type()

-- Initialize our devices table, which is really just a bunch of names paired with unique indices
-- Used for setting up the Creators table further down
dofile(this_dir.."devices.lua")

MainPanel = {
  "ccMainPanel",
  this_dir.."mainpanel_init.lua",
  {}
}

-- Creators table 
creators = {}
creators[devices.FCCC_COMMON] = {"avLuaDevice", this_dir.."Systems/clickable_common.lua"}

-- Aircraft-specific scripts will be added to creators[] here via conditional statements
if current_aircraft == "A-10A" then
  creators[devices.FCCC_A10A] = {"avLuaDevice", this_dir.."Systems/A-10A/clickable_a10a.lua"}
end
