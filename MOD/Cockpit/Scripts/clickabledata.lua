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

-- Common elements, baseline used by all FC aircraft.  May be replaced by more specific commands in aircraft sections further down
elements["PNT_ALT"] = fcc_knob(_("Set Altimeter"), devices.FCC_COMMON, device_commands.ALT_SET)
elements["PNT_CANOPY"] = fcc_button(_("Canopy OPEN/CLOSE"), devices.FCC_COMMON, device_commands.CANOPY)
elements["PNT_CAUTION_CLR"] = fcc_button(_("Reset Master Caution"), devices.FCC_COMMON, device_commands.CAUTION_CLR)
elements["PNT_CM_AUTO"] = fcc_button(_("Countermeasures Periodic Dispense"), devices.FCC_COMMON, device_commands.CM_AUTO)
elements["PNT_CM_CHAFF"] = fcc_button(_("Dispense Chaff"), devices.FCC_COMMON, device_commands.CM_CHAFF)
elements["PNT_CM_FLARE"] = fcc_button(_("Dispense Flare"), devices.FCC_COMMON, device_commands.CM_FLARE)
elements["PNT_CYCLE_WP"] = fcc_knob(_("Cycle Waypoint / Airfield / Target"), devices.FCC_COMMON, device_commands.WPT_CYCLE)
elements["PNT_DROP_EXT"] = fcc_button(_("Jettison External Stores"), devices.FCC_COMMON, device_commands.JET_EXT)
elements["PNT_ECM"] = fcc_button(_("ECM ON/OFF"), devices.FCC_COMMON, device_commands.ECM_TGL)
elements["PNT_ENGL_OFF"] = fcc_button(_("Shutdown Left Engine"), devices.FCC_COMMON, device_commands.ENGL_OFF)
elements["PNT_ENGL_ON"] = fcc_button(_("Start Left Engine"), devices.FCC_COMMON, device_commands.ENGL_ON)
elements["PNT_ENGR_OFF"] = fcc_button(_("Shutdown Right Engine"), devices.FCC_COMMON, device_commands.ENGR_OFF)
elements["PNT_ENGR_ON"] = fcc_button(_("Start Right Engine"), devices.FCC_COMMON, device_commands.ENGR_ON)
elements["PNT_FLAPS"] = springloaded_3_pos_tumb(_("Flaps INC/DEC"), devices.FCC_COMMON, device_commands.FLAPS, 1)
elements["PNT_GEAR"] = fcc_button(_("Landing Gear"), devices.FCC_COMMON, device_commands.GEAR)
elements["PNT_HUD_BRT"] = fcc_knob(_("Set HUD Brightness"), devices.FCC_COMMON, device_commands.HUD_BRT)
elements["PNT_LGT_EXT"] = fcc_button(_("Navigation Lights"), devices.FCC_COMMON, device_commands.LGT_NAV)
elements["PNT_LGT_INT"] = fcc_button(_("Instrument Lights"), devices.FCC_COMMON, device_commands.LGT_INT)
elements["PNT_LGT_LAND"] = fcc_button(_("Landing Lights"), devices.FCC_COMMON, device_commands.LGT_LANDING)
elements["PNT_MIRROR_L"] = fcc_button(_("Toggle Mirrors"), devices.FCC_COMMON, device_commands.MIRROR)
elements["PNT_MIRROR_U"] = fcc_button(_("Toggle Mirrors"), devices.FCC_COMMON, device_commands.MIRROR)
elements["PNT_MIRROR_R"] = fcc_button(_("Toggle Mirrors"), devices.FCC_COMMON, device_commands.MIRROR)
elements["PNT_MODE_AA"] = fcc_button(_("Air-to-Air Master Modes"), devices.FCC_COMMON, device_commands.MM_AA)
elements["PNT_MODE_AG"] = fcc_button(_("Air-to-Ground Master Modes"), devices.FCC_COMMON, device_commands.MM_AG)
elements["PNT_MODE_NAV"] = fcc_button(_("Navigation Master Modes"), devices.FCC_COMMON, device_commands.MM_NAV)
elements["PNT_POWER"] = fcc_button(_("Electrical Systems ON/OFF"), devices.FCC_COMMON, device_commands.POWER_TGL)
elements["PNT_RIP_INT"] = fcc_rotary_switch(_("Ripple Interval"), devices.FCC_COMMON, device_commands.WEP_RIP_INT)
elements["PNT_RIP_MODE"] = fcc_knob(_("Weapon Release Mode"), devices.FCC_COMMON, device_commands.WEP_RIP_MODE)
elements["PNT_RIP_QTY"] = fcc_rotary_switch(_("Ripple Quantity"), devices.FCC_COMMON, device_commands.WEP_RIP_QTY)
elements["PNT_RWR_VOL"] = fcc_knob(_("Set RWR Volume"), devices.FCC_COMMON, device_commands.RWR_VOL)
elements["PNT_RWR_MODE"] = fcc_button(_("Switch RWR Mode"), devices.FCC_COMMON, device_commands.RWR_MODE)
elements["PNT_SEAT_VERT"] = springloaded_3_pos_tumb(_("Adjust Seat UP/DOWN"), devices.FCC_COMMON, device_commands.VIEW_VERT)
elements["PNT_STICK_VIS"] = fcc_button(_("Stick SHOW/HIDE"), devices.FCC_COMMON, device_commands.STICK_TGL)
elements["PNT_WEP_CYC"] = fcc_button(_("Change Weapon"), devices.FCC_COMMON, device_commands.WEP_CYCLE)
-- Add to this with other shared basic features

-- A-10A specific features
if current_aircraft == "A-10A" then
  -- The A-10A autopilot system is a little odd, may need special treatment
  elements["A10A_AP_MODE"] = springloaded_3_pos_tumb(_("Autopilot Mode"), devices.FCC_A10A, device_commands.AP_MODE)
  elements["A10A_AP_TGL"] = fcc_button(_("Autopilot ON/OFF"), devices.FCC_A10A, device_commands.AP_TGL)  
  elements["A10A_AA_FUEL"] = fcc_button(_("Refuelling Bay OPEN/CLOSE"), devices.FCC_A10A, device_commands.FUEL_AA_TGL)
  -- These are just extra buttons for standard behavior
  elements["A10A_ENGL_OFF_FIRE"] = fcc_button("Left Engine OFF", devices.FCC_COMMON, device_commands.ENGL_OFF)
  elements["A10A_ENGR_OFF_FIRE"] = fcc_button("Right Engine OFF", devices.FCC_COMMON, device_commands.ENGR_OFF)
  elements["A10A_WEP_CYC_2"] = fcc_button(_("Change Weapon"), devices.FCC_COMMON, device_commands.WEP_CYCLE)
end


FCCLOG.info("clickabledata INIT")