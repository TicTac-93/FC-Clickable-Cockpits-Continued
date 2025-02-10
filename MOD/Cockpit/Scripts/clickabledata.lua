-- Run automatically by EDGE
--
-- Binds Connectors in the cockpit to handler functions and devices

dofile(LockOn_Options.script_path.."defs_clickables.lua")  -- Clickable element handler functions
dofile(LockOn_Options.script_path.."defs_commands.lua")  -- Command codes to be sent to devices.  Internal, not specific to DCS
dofile(LockOn_Options.script_path.."devices.lua")  -- Device IDs, bound to .lua files in device_init

-- Not used directly, but possibly a requirement?
local gettext = require("i_18n")
_ = gettext.translate

log.write("FC-Clickable", log.INFO, "clickabledata.lua")



-- Elements table, stores all connectors as keys and their associated function calls as values
elements = {}
local current_aircraft = get_aircraft_type()

-- Common elements, used by all FC aircraft
-- elements["PNT_ALT_SET"] = default_axis_limited("Altimeter Pressure Set", devices.CLICKABLE, commands.ALTIMETER)
elements["PNT_CANOPY"] = default_button("Canopy OPEN/CLOSE", devices.CLICKABLE, device_commands.CANOPY)
