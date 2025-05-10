-- Run automatically by EDGE
-- More or less responsible for initializing the rest of the plugin

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions

local scripts = LockOn_Options.script_path
aircraft = get_aircraft_type()

-- You might think that this plugin would only be run for the aircraft in entry.lua's add_plugin_system()
-- You would be wrong.
-- If the current aircraft is not whitelisted, abort the initialization
local abort = true
local whitelist = {
  "A-10A",
  "F-15C",
  -- "J-11A",
  "MiG-29A",
  "MiG-29G",
  "MiG-29S",
  -- "Su-25",
  -- "Su-25T",
  -- "Su-27",
  -- "Su-33",
  "F-5E-3_FC",
  "F-86F_FC",
  "MiG-15bis_FC",
}
for index= 0, table.getn(whitelist), 1 do
  if whitelist[index] == aircraft then
    abort = false
    break
  end
end
if abort then
  return
end
-- END AIRCRAFT WHITELIST

MainPanel = {
  "ccMainPanel",
  scripts.."mainpanel_init.lua",
  {}
}

-- Creators table 
dofile(scripts.."devices.lua")  -- Device IDs
creators = {}
creators[devices.FCC_COMMON] = {"avLuaDevice", scripts.."Systems/clickable_common.lua"}

-- Aircraft-specific scripts will be added to creators[] here via conditional statements
if aircraft == "A-10A" then
  creators[devices.FCC_A10A] = {"avLuaDevice", scripts.."Systems/clickable_a10a.lua"}

elseif aircraft == "F-5E-3_FC" then
  creators[devices.FCC_F5E] = {"avLuaDevice", scripts.."Systems/clickable_f5e.lua"}

elseif aircraft == "F-15C" then
  creators[devices.FCC_F15C] = {"avLuaDevice", scripts.."Systems/clickable_f15c.lua"}

elseif aircraft == "F-86F_FC" then
  creators[devices.FCC_F86] = {"avLuaDevice", scripts.."Systems/clickable_f86.lua"}

elseif aircraft == "MiG-15bis_FC" then
  creators[devices.FCC_MIG15] = {"avLuaDevice", scripts.."Systems/clickable_mig15.lua"}

elseif aircraft == "MiG-29A" or aircraft == "MiG-29G" or aircraft == "MiG-29S" then
  creators[devices.FCC_MIG29] = {"avLuaDevice", scripts.."Systems/clickable_mig29.lua"}

end

-- FCCLOG.info("device_init INIT")
