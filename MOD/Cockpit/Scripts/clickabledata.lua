-- Run automatically by EDGE
--
-- Binds Connectors in the cockpit to handler functions and devices

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions
dofile(LockOn_Options.script_path.."clickable_defs.lua")  -- Clickable element handler functions
dofile(LockOn_Options.script_path.."device_commands.lua")  -- Command codes to be sent to devices
dofile(LockOn_Options.script_path.."devices.lua")  -- Device IDs, bound to .lua files in device_init

-- Localization function
local gettext = require("i_18n")
_ = gettext.translate


-- Elements table, stores all connectors as keys and their behavior tables (returned by the functions in clickable_defs) as values
elements = {}
local aircraft = get_aircraft_type()

-- Common elements, a baseline for all FC aircraft.  May be replaced by more specific commands in aircraft sections further down
-- Radar and targetting commands are not included here, due to inconsistencies between aircraft
elements["PNT_AIRBRAKE"] = fcc_switch(_("Airbrake DEPLOY/RETRACT"), devices.FCC_COMMON, device_commands.AIRBRAKE)
elements["PNT_ALT"] = fcc_knob(_("Set Altimeter"), devices.FCC_COMMON, device_commands.ALT_SET)
elements["PNT_CANOPY"] = fcc_button(_("Canopy OPEN/CLOSE"), devices.FCC_COMMON, device_commands.CANOPY, true)
elements["PNT_CAUTION_CLR"] = fcc_button(_("Reset Master Caution"), devices.FCC_COMMON, device_commands.CAUTION_CLR)
elements["PNT_CHUTE"] = fcc_button(_("Drogue Chute DEPLOY/CUT"), devices.FCC_COMMON, device_commands.CHUTE)
elements["PNT_CLOCK"] = fcc_button(_("Clock Start/Stop/Reset"), devices.FCC_COMMON, device_commands.CLOCK)
-- elements["PNT_CLOCK_2"] = fcc_button(_("Flight Clock Start/Stop/Reset"), devices.FCC_COMMON, device_commands.CLOCK2)
elements["PNT_CM_AUTO"] = fcc_button(_("Countermeasures Periodic Dispense"), devices.FCC_COMMON, device_commands.CM_AUTO)
-- elements["PNT_CM_CHAFF"] = fcc_button(_("Dispense Chaff"), devices.FCC_COMMON, device_commands.CM_CHAFF)
-- elements["PNT_CM_FLARE"] = fcc_button(_("Dispense Flare"), devices.FCC_COMMON, device_commands.CM_FLARE)
elements["PNT_CYCLE_WP"] = fcc_switch_scrollable(_("Next/Prev Waypoint, Airfield, Target"), devices.FCC_COMMON, device_commands.WPT_CYCLE)
elements["PNT_DROP_EXT"] = fcc_button(_("Jettison External Stores"), devices.FCC_COMMON, device_commands.JET_EXT)
elements["PNT_DROP_FUEL"] = fcc_button(_("Jettison External Fuel Tanks"), devices.FCC_COMMON, device_commands.JET_FUEL)
elements["PNT_DROP_EMER"] = fcc_button(_("Emergency Jettison ALL External Stores"), devices.FCC_COMMON, device_commands.JET_ALL)
elements["PNT_ECM"] = fcc_button(_("ECM ON/OFF"), devices.FCC_COMMON, device_commands.ECM_TGL)
elements["PNT_EJECT_1"] = fcc_button(_("EJECT x3"), devices.FCC_COMMON, device_commands.EJECT)
elements["PNT_EJECT_2"] = fcc_button(_("EJECT x3"), devices.FCC_COMMON, device_commands.EJECT)
elements["PNT_ENGL_OFF"] = fcc_button(_("Shutdown Left Engine"), devices.FCC_COMMON, device_commands.ENGL_OFF)
elements["PNT_ENGL_ON"] = fcc_button(_("Start Left Engine"), devices.FCC_COMMON, device_commands.ENGL_ON)
elements["PNT_ENGR_OFF"] = fcc_button(_("Shutdown Right Engine"), devices.FCC_COMMON, device_commands.ENGR_OFF)
elements["PNT_ENGR_ON"] = fcc_button(_("Start Right Engine"), devices.FCC_COMMON, device_commands.ENGR_ON)
elements["PNT_FLAPS"] = fcc_switch(_("Flaps LMB RAISE, RMB LOWER"), devices.FCC_COMMON, device_commands.FLAPS)
elements["PNT_FLAPS_ANIM"] = fcc_switch(_("Flaps LMB RAISE, RMB LOWER"), devices.FCC_COMMON, device_commands.FLAPS, false, true)
elements["PNT_FUEL_AA"] = fcc_button(_("Toggle A/A Refueling"), devices.FCC_COMMON, device_commands.FUEL_AA_TGL)
elements["PNT_FUEL_DUMP"] = fcc_momentary_button(_("Dump Fuel"), devices.FCC_COMMON, device_commands.FUEL_DUMP)
elements["PNT_GEAR"] = fcc_switch(_("Landing Gear RAISE/LOWER"), devices.FCC_COMMON, device_commands.GEAR, false, true)
elements["PNT_HUD_BRT"] = fcc_knob(_("Set HUD Brightness"), devices.FCC_COMMON, device_commands.HUD_BRT)
elements["PNT_HUD_FILTER"] = fcc_button(_("Toggle HUD Filter"), devices.FCC_COMMON, device_commands.HUD_FILTER)
elements["PNT_LGT_BCN"] = fcc_button(_("Beacon Light"), devices.FCC_COMMON, device_commands.LGT_BCN)
elements["PNT_LGT_INT"] = fcc_button(_("Instrument Lights"), devices.FCC_COMMON, device_commands.LGT_INT)
elements["PNT_LGT_LAND"] = fcc_button(_("Landing Lights"), devices.FCC_COMMON, device_commands.LGT_LANDING)
elements["PNT_LGT_NAV"] = fcc_button(_("Navigation Lights"), devices.FCC_COMMON, device_commands.LGT_NAV)
elements["PNT_MIRROR_L"] = fcc_button(_("Toggle Mirrors"), devices.FCC_COMMON, device_commands.MIRROR, true)
elements["PNT_MIRROR_U"] = fcc_button(_("Toggle Mirrors"), devices.FCC_COMMON, device_commands.MIRROR, true)
elements["PNT_MIRROR_R"] = fcc_button(_("Toggle Mirrors"), devices.FCC_COMMON, device_commands.MIRROR, true)
elements["PNT_MODE_AA"] = fcc_button(_("Air-to-Air Master Modes"), devices.FCC_COMMON, device_commands.MM_AA)
elements["PNT_MODE_AG"] = fcc_button(_("Air-to-Ground Master Modes"), devices.FCC_COMMON, device_commands.MM_AG)
elements["PNT_MODE_NAV"] = fcc_button(_("Navigation Master Modes"), devices.FCC_COMMON, device_commands.MM_NAV)
elements["PNT_POWER"] = fcc_button(_("Electrical Systems ON/OFF"), devices.FCC_COMMON, device_commands.POWER_TGL)
elements["PNT_RIP_INT"] = fcc_switch_scrollable(_("Ripple Interval"), devices.FCC_COMMON, device_commands.WEP_RIP_INT)
elements["PNT_RIP_MODE"] = fcc_knob(_("Weapon Release Mode"), devices.FCC_COMMON, device_commands.WEP_RIP_MODE)
elements["PNT_RIP_QTY"] = fcc_switch_scrollable(_("Ripple Quantity"), devices.FCC_COMMON, device_commands.WEP_RIP_QTY)
elements["PNT_RWR_VOL"] = fcc_knob(_("Set RWR Volume"), devices.FCC_COMMON, device_commands.RWR_VOL)
elements["PNT_RWR_MODE"] = fcc_button(_("Switch RWR Mode"), devices.FCC_COMMON, device_commands.RWR_MODE)
elements["PNT_SEAT_VERT"] = fcc_switch(_("Adjust Seat UP/DOWN"), devices.FCC_COMMON, device_commands.VIEW_VERT, true)
elements["PNT_TRIM_PITCH"] = fcc_switch(_("Trim Elevator UP/DOWN"), devices.FCC_COMMON, device_commands.TRIM_PITCH, true)
elements["PNT_TRIM_ROLL"] = fcc_switch(_("Trim Ailerons LEFT/RIGHT"), devices.FCC_COMMON, device_commands.TRIM_ROLL, true)
elements["PNT_TRIM_YAW"] = fcc_switch(_("Trim Rudder LEFT/RIGHT"), devices.FCC_COMMON, device_commands.TRIM_YAW, true)
elements["PNT_WEP_CYC"] = fcc_button(_("Change Weapon"), devices.FCC_COMMON, device_commands.WEP_CYCLE)
-- Implement these two in more planes?
elements["PNT_WEP_BURST"] = fcc_button(_("Cannon Burst Cutoff ON/OFF"), devices.FCC_COMMON, device_commands.WEP_BURST)
elements["PNT_WEP_LA"] = fcc_button(_("Launch Authority OVERRIDE"), devices.FCC_COMMON, device_commands.WEP_LA)

-- A-10A specific features
if aircraft == "A-10A" then
  -- The A-10A autopilot system is a little odd, may need special treatment
  elements["A10A_AP_EAC_ARM"] = fcc_switch(_("Autopilot EAC ARM/OFF"), devices.FCC_A10A, device_commands.AP_ARM)
  elements["A10A_AP_MODE"] = fcc_switch(_("Autopilot Mode"), devices.FCC_A10A, device_commands.AP_MODE)
  elements["A10A_AP_TGL"] = fcc_button(_("Autopilot ON/OFF"), devices.FCC_A10A, device_commands.AP_TGL)
  -- Left click to enter A2G mode, right click for CCRP Steering
  elements["A10A_MODE_AG"] = fcc_switch(_("Air-to-Ground CCIP/CCRP"), devices.FCC_A10A, device_commands.MM_AG)
  elements["A10A_RIP_MODE"] = fcc_knob(_("Weapon Release Mode"), devices.FCC_A10A, device_commands.WEP_RIP_MODE)
  elements["A10A_RIP_QTY"] = fcc_switch_scrollable(_("Ripple Quantity"), devices.FCC_A10A, device_commands.WEP_RIP_QTY)
  -- These are just extra buttons for standard behavior
  elements["A10A_ENGL_OFF_FIRE"] = fcc_button(_("Left Engine OFF"), devices.FCC_COMMON, device_commands.ENGL_OFF)
  elements["A10A_ENGR_OFF_FIRE"] = fcc_button(_("Right Engine OFF"), devices.FCC_COMMON, device_commands.ENGR_OFF)
  elements["A10A_WEP_CYC_2"] = fcc_button(_("Change Weapon"), devices.FCC_COMMON, device_commands.WEP_CYCLE)

-- F-5E specific features
elseif aircraft == "F-5E-3_FC" then
  elements["F5E_NOSE_STRUT"] = fcc_button(_("Nosewheel Strut EXTEND/RETRACT"), devices.FCC_F5E, device_commands.NWS_STRUT)
  elements["F5E_RADAR"] = fcc_button(_("Radar ON/OFF"), devices.FCC_F5E, device_commands.RDR_TGL)
  elements["F5E_RADAR_ELEV"] = fcc_switch(_("Radar Elevation UP/DOWN"), devices.FCC_F5E, device_commands.RDR_VERT, true)
  elements["F5E_RADAR_RANGE"] = fcc_switch_scrollable(_("Radar Display Range INC/DEC"), devices.FCC_F5E, device_commands.RDR_RANGE)
  elements["F5E_SIGHT_MODE"] = fcc_switch_scrollable(_("Master Modes"), devices.FCC_F5E, device_commands.MM_AA)

-- F-15C specific features
elseif aircraft == "F-15C" then
  elements["F15_AP_ALT"] = fcc_button(_("Autopilot Altitude Hold ON/OFF"), devices.FCC_F15C, device_commands.AP_MODE_ALT)
  elements["F15_AP_ATT"] = fcc_button(_("Autopilot ON/OFF, Attitude Hold"), devices.FCC_F15C, device_commands.AP_TGL)
  elements["F15_BINGO"] = fcc_switch(_("Bingo Fuel INC/DEC"), devices.FCC_F15C, device_commands.FUEL_BINGO, true)
  elements["F15_CAS_PITCH"] = fcc_button(_("CAS Pitch ON/OFF"), devices.FCC_F15C, device_commands.AP_CAS_PITCH)
  elements["F15_CAS_ROLL"] = fcc_button(_("CAS Roll ON/OFF"), devices.FCC_F15C, device_commands.AP_CAS_ROLL)
  elements["F15_CAS_YAW"] = fcc_button(_("CAS Yaw ON/OFF"), devices.FCC_F15C, device_commands.AP_CAS_YAW)
  elements["F15_ENGL_MASTER"] = fcc_switch(_("Left Engine START/STOP"), devices.FCC_F15C, device_commands.ENGL_TGL)
  elements["F15_ENGR_MASTER"] = fcc_switch(_("Right Engine START/STOP"), devices.FCC_F15C, device_commands.ENGR_TGL)
  elements["F15_RADAR"] = fcc_button(_("Radar ON/OFF"), devices.FCC_F15C, device_commands.RDR_TGL)
  elements["F15_RADAR_ELEV"] = fcc_switch(_("Radar Elevation UP/DOWN"), devices.FCC_F15C, device_commands.RDR_VERT, true)
  elements["F15_RADAR_HORZ"] = fcc_switch(_("Radar Scan Zone INC/DEC"), devices.FCC_F15C, device_commands.RDR_HORZ)
  elements["F15_RADAR_MODE"] = fcc_button(_("Radar Mode TWS/STT"), devices.FCC_F15C, device_commands.RDR_MODE)
  elements["F15_RADAR_RANGE"] = fcc_switch_scrollable(_("Radar Display Range INC/DEC"), devices.FCC_F15C, device_commands.RDR_RANGE)
  elements["F15_TANK_SEL"] = fcc_switch_scrollable(_("Fuel Gauge Tank Selection"), devices.FCC_F15C, device_commands.FUEL_SEL)
  elements["F15_TRIM_TO"] = fcc_button(_("Take-off Trim"), devices.FCC_F15C, device_commands.TRIM_TO)

-- F-86 specific features
elseif aircraft == "F-86F_FC" then
  elements["F86_ENG_TGL"] = fcc_switch(_("Engine START/STOP"), devices.FCC_F86, device_commands.ENG_TGL)
  elements["F86_MODE_AA"] = fcc_switch(_("Air-to-Air Weapons / Nav Mode"), devices.FCC_F86, device_commands.MM_AA)
  elements["F86_MODE_AG"] = fcc_switch(_("Air-to-Ground Weapons / Cannons"), devices.FCC_F86, device_commands.MM_AG)
  elements["F86_ADI_RESET"] = fcc_momentary_button(_("Reset ADI"), devices.FCC_F86, device_commands.ADI_RESET)

-- MiG-15bis specific features
elseif aircraft == "MiG-15bis_FC" then
  elements["MIG15_ADI_RESET"] = fcc_momentary_button(_("Reset ADI"), devices.FCC_MIG15, device_commands.ADI_RESET)
  elements["MIG15_ENG_TGL"] = fcc_switch(_("Engine START/STOP"), devices.FCC_MIG15, device_commands.ENG_TGL)
  elements["MIG15_MODE_AA"] = fcc_switch(_("Cannons ARM/DISARM"), devices.FCC_MIG15, device_commands.MM_AA)
  elements["MIG15_MODE_AG"] = fcc_switch(_("Bombs ARM/DISARM"), devices.FCC_MIG15, device_commands.MM_AG)
  elements["MIG15_POWER_2"] = fcc_button(_("Electrical Systems ON/OFF"), devices.FCC_COMMON, device_commands.POWER_TGL)
  elements["MIG15_SIGHT_BACKUP"] = fcc_button(_("Backup Gunsight"), devices.FCC_MIG15, device_commands.HUD_SIGHT)
  elements["MIG15_WINGSPAN"] = fcc_knob(_("Adjust Target Wingspan"), devices.FCC_MIG15, device_commands.RDR_HORZ)
  elements["MIG15_CANOPY_2"] = fcc_button(_("Canopy OPEN/CLOSE"), devices.FCC_COMMON, device_commands.CANOPY)

-- MiG-29 A/G/S specific features
elseif aircraft == "MiG-29A" or aircraft == "MiG-29G" or aircraft == "MiG-29S" then
  elements["MIG29_ALT_RADAR"] = fcc_switch(_("Set Radar Altimeter Warning"), devices.FCC_MIG29, device_commands.ALT_SET_RADAR, true)
  elements["MIG29_AP_ALT"] = fcc_button(_("Autopilot: Altitude Hold"), devices.FCC_MIG29, device_commands.AP_MODE_ALT)
  elements["MIG29_AP_ATT"] = fcc_button(_("Autopilot: Attitude Hold"), devices.FCC_MIG29, device_commands.AP_MODE_ATT)
  elements["MIG29_AP_DAMPER"] = fcc_button(_("Autopilot: Damper"), devices.FCC_MIG29, device_commands.AP_MODE_DAMPER)
  elements["MIG29_AP_LEVEL"] = fcc_button(_("Autopilot: Ground Collision Avoidance"), devices.FCC_MIG29, device_commands.AP_MODE_GCA)
  elements["MIG29_ENG_SEL"] = fcc_switch(_("Engine Starter Mode: LEFT/AUTO/RIGHT"), devices.FCC_MIG29, device_commands.ENG_TGL)
  elements["MIG29_ENG_START"] = fcc_button(_("Engine Starter"), devices.FCC_MIG29, device_commands.ENG_ON)
  elements["MIG29_EOS"] = fcc_button(_("EOS ON/OFF"), devices.FCC_MIG29, device_commands.EOS_TGL)
  elements["MIG29_GUNSIGHT"] = fcc_button(_("Backup Gunsight"), devices.FCC_MIG29, device_commands.HUD_SIGHT)
  elements["MIG29_MODE"] = fcc_switch_scrollable(_("Weapons System Mode"), devices.FCC_MIG29, device_commands.MM_AA)
  elements["MIG29_RADAR"] = fcc_button(_("Radar ON/OFF"), devices.FCC_MIG29, device_commands.RDR_TGL)
  elements["MIG29_RADAR_ELEV"] = fcc_switch(_("Radar Elevation UP/DOWN"), devices.FCC_MIG29, device_commands.RDR_VERT, true)
  elements["MIG29_RADAR_FREQ"] = fcc_button(_("Radar Frequency AUTO/MED/HIGH"), devices.FCC_MIG29, device_commands.RDR_FREQ)
  elements["MIG29_RADAR_HORZ"] = fcc_switch(_("Radar Scan Zone LEFT/CENTER/RIGHT"), devices.FCC_MIG29, device_commands.RDR_HORZ, true)
  elements["MIG29_RADAR_MODE"] = fcc_button(_("Radar Mode STT/TWS"), devices.FCC_MIG29, device_commands.RDR_MODE)
  elements["MIG29_SALVO"] = fcc_button(_("Weapons and Cannons SALVO/SINGLE"), devices.FCC_MIG29, device_commands.WEP_RIP_MODE)
  elements["MIG29_TGT_WINGSPAN"] = fcc_knob(_("Target Wingspan INC/DEC"), devices.FCC_MIG29, device_commands.TGT_SIZE)

  if aircraft == "MiG-29S" then
    elements["MIG29_ECM"] = fcc_button(_("ECM ON/OFF"), devices.FCC_COMMON, device_commands.ECM_TGL)  -- Not available in other variants
  end

-- Su-25 specific features
elseif aircraft == "Su-25" then
  elements["SU25_ASP_VERT"] = fcc_knob(_("Adjust ASP Sight UP/DOWN"), devices.FCC_SU25, device_commands.ASP_VERT)
  elements["SU25_GUNSIGHT"] = fcc_button(_("Backup Gunsight"), devices.FCC_SU25, device_commands.HUD_SIGHT)
  elements["SU25_LASER"] = fcc_button(_("Toggle Laser Designator"), devices.FCC_SU25, device_commands.TGT_LASER)
  elements["SU25_MODE_AG"] = fcc_switch(_("Air-to-Air / Air-to-Ground Weapons"), devices.FCC_SU25, device_commands.MM_AG)
  elements["SU25_RIP_QTY"] = fcc_switch_scrollable(_("Ripple Quantity / Gunpod Selection"), devices.FCC_SU25, device_commands.WEP_RIP_QTY)
  elements["SU25_TGT_HORZ"] = fcc_switch(_("Adjust Reticle LEFT/RIGHT"), devices.FCC_SU25, device_commands.TGT_HORZ, true)
  elements["SU25_TGT_VERT"] = fcc_switch(_("Adjust Reticle UP/DOWN"), devices.FCC_SU25, device_commands.TGT_VERT, true)
  elements["SU25_CANOPY_2"] = fcc_button(_("Canopy OPEN/CLOSE"), devices.FCC_COMMON, device_commands.CANOPY)

-- Su-25T specific features
elseif aircraft == "Su-25T" then
  elements["SU25T_AP_AUTO"] = fcc_button(_("Autopilot: Attitude Hold"), devices.FCC_SU25T, device_commands.AP_MODE_ATT)
  elements["SU25T_AP_BARO"] = fcc_button(_("Autopilot: Altitude Hold"), devices.FCC_SU25T, device_commands.AP_MODE_ALT)
  elements["SU25T_AP_ROUTE"] = fcc_button(_("Autopilot: Route Following"), devices.FCC_SU25T, device_commands.AP_MODE_NAV)
  elements["SU25T_AP_LEVEL"] = fcc_button(_("Autopilot: Transition to Level Flight"), devices.FCC_SU25T, device_commands.AP_MODE_LEVEL)
  elements["SU25T_AP_RADAR"] = fcc_button(_("Autopilot: Radar Altitude Hold"), devices.FCC_SU25T, device_commands.AP_MODE_RALT)
  elements["SU25T_ELINT"] = fcc_button(_("'Fantasmagoria' ELINT Pod ON/OFF"), devices.FCC_SU25T, device_commands.RDR_TGL)
  elements["SU25T_GUNSIGHT"] = fcc_button(_("Backup Gunsight"), devices.FCC_SU25T, device_commands.HUD_SIGHT)
  elements["SU25T_IRJAM"] = fcc_button(_("IR Jammer ON/OFF"), devices.FCC_SU25T, device_commands.ECM_TGL)
  elements["SU25T_MERCURY"] = fcc_button(_("Mercury LLTV/FLIR Pod ON/OFF"), devices.FCC_SU25T, device_commands.RDR_MODE)
  elements["SU25T_LASER"] = fcc_button(_("Toggle Laser Designator"), devices.FCC_SU25T, device_commands.TGT_LASER)
  elements["SU25T_MODE_AG"] = fcc_switch(_("Air-to-Air / Air-to-Ground Weapons"), devices.FCC_SU25T, device_commands.MM_AG)
  elements["SU25T_RIP_QTY"] = fcc_switch_scrollable(_("Ripple Quantity / Gunpod Selection"), devices.FCC_SU25T, device_commands.WEP_RIP_QTY)
  elements["SU25T_SHKVAL"] = fcc_button(_("Shkval Camera ON/OFF"), devices.FCC_SU25T, device_commands.EOS_TGL)
  elements["SU25T_ZOOM"] = fcc_switch(_("Shkval Zoom IN/OUT"), devices.FCC_SU25T, device_commands.RDR_ZOOM)
  elements["SU25T_CANOPY_2"] = fcc_button(_("Canopy OPEN/CLOSE"), devices.FCC_COMMON, device_commands.CANOPY)

-- Su-27 specific features
elseif aircraft == "Su-27" or aircraft == "J11-A" then
  elements["SU27_AP_AUTO"] = fcc_button(_("Autopilot: Attitude Hold"), devices.FCC_SU27, device_commands.AP_MODE_ATT)
  elements["SU27_AP_BARO"] = fcc_button(_("Autopilot: Altitude Hold"), devices.FCC_SU27, device_commands.AP_MODE_ALT) -- use 387
  elements["SU27_AP_NAV"] = fcc_button(_("Autopilot: Route Following"), devices.FCC_SU27, device_commands.AP_MODE_NAV)
  elements["SU27_AP_RADAR"] = fcc_button(_("Autopilot: Radar Altitude Hold / Ground Avoidance"), devices.FCC_SU27, device_commands.AP_MODE_GCA)
  elements["SU27_AP_RESET"] = fcc_button(_("Autopilot: Reset and Disable"), devices.FCC_SU27, device_commands.AP_MODE_RESET)
  elements["SU27_AP_GUIDE"] = fcc_button(_("Autopilot: Transition to Level Flight"), devices.FCC_SU27, device_commands.AP_MODE_LEVEL)
  elements["SU27_DIRECT"] = fcc_button(_("Direct Control ON/OFF"), devices.FCC_SU27, device_commands.AP_MODE_DAMPER)
  elements["SU27_EOS"] = fcc_button(_("Electro-Optical System ON/OFF"), devices.FCC_SU27, device_commands.EOS_TGL)
  elements["SU27_FLAPS_OFF"] = fcc_button(_("Retract Flaps"), devices.FCC_SU27, device_commands.FLAPS_OFF)
  elements["SU27_FLAPS_ON"] = fcc_button(_("Deploy Flaps"), devices.FCC_SU27, device_commands.FLAPS_ON)
  elements["SU27_GUNSIGHT"] = fcc_button(_("Backup Gunsight"), devices.FCC_SU27, device_commands.HUD_SIGHT)
  elements["SU27_HDD_REPEAT"] = fcc_button(_("Heads-Down Display RADAR/REPEAT"), devices.FCC_SU27, device_commands.HUD_MODE)
  elements["SU27_HDD_ZOOM"] = fcc_switch(_("Heads-Down Display Zoom IN/OUT"), devices.FCC_SU27, device_commands.RDR_ZOOM)
  elements["SU27_INTAKE"] = fcc_button(_("Intake Screens AUTO/OFF"), devices.FCC_SU27, device_commands.INTAKE_TGL)
  elements["SU27_MODE"] = fcc_switch_scrollable(_("Weapons System Mode"), devices.FCC_SU27, device_commands.MM_AA)
  elements["SU27_MODE_AG"] = fcc_switch(_("AA/AG Mode"), devices.FCC_SU27, device_commands.MM_AG)
  elements["SU27_NWS"] = fcc_button(_("Nosewheel Steering ON/OFF"), devices.FCC_SU27, device_commands.NWS_TGL)
  elements["SU27_RIP_MODE"] = fcc_switch_scrollable(_("Salvo Mode"), devices.FCC_SU27, device_commands.WEP_RIP_MODE)
  elements["SU27_RADAR"] = fcc_button(_("Radar ON/OFF"), devices.FCC_SU27, device_commands.RDR_TGL)
  elements["SU27_RADAR_ELEV"] = fcc_switch(_("Radar Elevation UP/DOWN"), devices.FCC_SU27, device_commands.RDR_VERT, true)
  elements["SU27_RADAR_FREQ"] = fcc_button(_("Radar Frequency AUTO/MED/HIGH"), devices.FCC_SU27, device_commands.RDR_FREQ)
  elements["SU27_RADAR_HORZ"] = fcc_switch(_("Radar Scan Zone LEFT/CENTER/RIGHT"), devices.FCC_SU27, device_commands.RDR_HORZ, true)
  elements["SU27_RADAR_MODE"] = fcc_button(_("Radar Mode STT/TWS"), devices.FCC_SU27, device_commands.RDR_MODE)
  elements["SU27_TGT_SIZE"] = fcc_knob(_("Target Wingspan INC/DEC"), devices.FCC_SU27, device_commands.TGT_SIZE)
  -- These are just extra buttons for standard behavior
  elements["SU27_CYCLE_WP_2"] = fcc_switch_scrollable(_("Next/Prev Waypoint, Airfield, Target"), devices.FCC_COMMON, device_commands.WPT_CYCLE)
  elements["SU27_ECM_2"] = fcc_button(_("ECM ON/OFF"), devices.FCC_COMMON, device_commands.ECM_TGL)

elseif aircraft == "Su-33" then
  elements["SU33_AP_AUTO"] = fcc_button(_("Autopilot: Attitude Hold"), devices.FCC_SU33, device_commands.AP_MODE_ATT)
  elements["SU33_AP_ALT"] = fcc_button(_("Autopilot: Altitude Hold"), devices.FCC_SU33, device_commands.AP_MODE_ALT)
  elements["SU33_AP_GCA"] = fcc_button(_("Autopilot: Ground Collision Avoidance"), devices.FCC_SU33, device_commands.AP_MODE_GCA)
  elements["SU33_AP_NAV"] = fcc_button(_("Autopilot: Route Following"), devices.FCC_SU33, device_commands.AP_MODE_NAV)
  elements["SU33_AP_RADAR"] = fcc_button(_("Autopilot: Radar Altitude Hold"), devices.FCC_SU33, device_commands.AP_MODE_RALT)
  elements["SU33_AP_RESET"] = fcc_button(_("Autopilot: Reset and Disable"), devices.FCC_SU33, device_commands.AP_MODE_RESET)
  elements["SU33_AP_STAB"] = fcc_button(_("Autopilot: Transition to Level Flight"), devices.FCC_SU33, device_commands.AP_MODE_LEVEL)
  elements["SU33_AP_THRUST"] = fcc_button(_("Autopilot: Velocity Control"), devices.FCC_SU33, device_commands.AP_MODE_VEL)
  elements["SU33_AP_SET_VEL"] = fcc_switch(_("INC/DEC Velocity for Autopilot"), devices.FCC_SU33, device_commands.AP_SET_VEL, true)
  elements["SU33_EOS"] = fcc_button(_("Electro-Optical System ON/OFF"), devices.FCC_SU33, device_commands.EOS_TGL)
  elements["SU33_FCS_DIRECT"] = fcc_button(_("Direct Control ON/OFF"), devices.FCC_SU33, device_commands.AP_MODE_DAMPER)
  elements["SU33_FCS_REFUEL"] = fcc_button(_("A/A Refuel Control Damping ON/OFF"), devices.FCC_SU33, device_commands.AP_MODE_DAMPER2)
  elements["SU33_FLAPS_OFF"] = fcc_button(_("Retract Flaps"), devices.FCC_SU33, device_commands.FLAPS_OFF)
  elements["SU33_FLAPS_ON"] = fcc_button(_("Deploy Flaps"), devices.FCC_SU33, device_commands.FLAPS_ON)
  elements["SU33_FOLD_WINGS"] = fcc_button(_("FOLD/UNFOLD Wings"), devices.FCC_SU33, device_commands.WING_FOLD)
  elements["SU33_GUNSIGHT"] = fcc_button(_("Backup Gunsight"), devices.FCC_SU33, device_commands.HUD_SIGHT)
  elements["SU33_HDD_REPEAT"] = fcc_button(_("Heads-Down Display RADAR/HUD"), devices.FCC_SU33, device_commands.HUD_MODE)
  elements["SU33_HDD_ZOOM"] = fcc_switch(_("Heads-Down Display Zoom IN/OUT"), devices.FCC_SU33, device_commands.RDR_ZOOM)
  elements["SU33_HOOK"] = fcc_switch(_("Arresting Hook UP/DOWN"), devices.FCC_SU33, device_commands.HOOK)
  elements["SU33_INTAKE"] = fcc_button(_("Intake Screens AUTO/OFF"), devices.FCC_SU33, device_commands.INTAKE_TGL)
  elements["SU33_LGT_REFUEL"] = fcc_button(_("Refuelling Probe Light ON/OFF"), devices.FCC_SU33, device_commands.LGT_BCN)
  elements["SU33_MODE"] = fcc_switch_scrollable(_("Weapons System Mode"), devices.FCC_SU33, device_commands.MM_AA)
  elements["SU33_MODE_AG"] = fcc_switch(_("AA/AG Mode"), devices.FCC_SU33, device_commands.MM_AG)
  elements["SU33_NWS"] = fcc_button(_("Nosewheel Steering ON/OFF"), devices.FCC_SU33, device_commands.NWS_TGL)
  elements["SU33_RIP_MODE"] = fcc_switch_scrollable(_("Salvo Mode"), devices.FCC_SU33, device_commands.WEP_RIP_MODE)
  elements["SU33_RADAR"] = fcc_button(_("Radar ON/OFF"), devices.FCC_SU33, device_commands.RDR_TGL)
  elements["SU33_RADAR_ELEV"] = fcc_switch(_("Radar Elevation UP/DOWN"), devices.FCC_SU33, device_commands.RDR_VERT, true)
  elements["SU33_RADAR_FREQ"] = fcc_button(_("Radar Frequency AUTO/MED/HIGH"), devices.FCC_SU33, device_commands.RDR_FREQ)
  elements["SU33_RADAR_HORZ"] = fcc_switch(_("Radar Scan Zone LEFT/CENTER/RIGHT"), devices.FCC_SU33, device_commands.RDR_HORZ, true)
  elements["SU33_RADAR_MODE"] = fcc_button(_("Radar Mode STT/TWS"), devices.FCC_SU33, device_commands.RDR_MODE)
  elements["SU33_TGT_SIZE"] = fcc_knob(_("Target Wingspan INC/DEC"), devices.FCC_SU33, device_commands.TGT_SIZE)
  -- These are just extra buttons for standard behavior
  elements["SU33_CYCLE_WP_2"] = fcc_switch_scrollable(_("Next/Prev Waypoint, Airfield, Target"), devices.FCC_COMMON, device_commands.WPT_CYCLE)
  elements["SU33_ECM_2"] = fcc_button(_("ECM ON/OFF"), devices.FCC_COMMON, device_commands.ECM_TGL)

end


-- FCCLOG.info("clickabledata INIT")