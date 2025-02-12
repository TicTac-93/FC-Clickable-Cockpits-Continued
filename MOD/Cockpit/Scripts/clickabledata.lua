-- Run automatically by EDGE
--
-- Binds Connectors in the cockpit to handler functions and devices

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions
dofile(LockOn_Options.script_path.."clickable_defs.lua")  -- Clickable element handler functions
dofile(LockOn_Options.script_path.."device_commands.lua")  -- Command codes to be sent to devices
dofile(LockOn_Options.script_path.."devices.lua")  -- Device IDs, bound to .lua files in device_init

-- Not used directly, but possibly a requirement?
local gettext = require("i_18n")
_ = gettext.translate


-- Elements table, stores all connectors as keys and their associated function calls as values
elements = {}
local current_aircraft = get_aircraft_type()

-- Common elements, used by all FC aircraft
elements["PNT_CANOPY"] = fcc_default_button("Canopy OPEN/CLOSE", devices.FCC_COMMON, device_commands.CANOPY)

-- DEBUG - A10A stuff that's easily clickable on load
elements["PNT_ENGL_OFF_FIRE"] = fcc_default_button("Left Engine OFF", devices.FCC_COMMON, device_commands.ENGL_OFF)
elements["PNT_ENGR_OFF_FIRE"] = fcc_default_button("Right Engine OFF", devices.FCC_COMMON, device_commands.ENGR_OFF)


FCCLOG.info("clickabledata INIT")