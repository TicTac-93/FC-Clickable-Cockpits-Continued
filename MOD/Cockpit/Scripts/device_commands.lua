-- Stores command values for both internal use and for sending to the game engine
dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions

-- Adjust starting value to deconflict with other systems in the game.  Our range of values HAS to be unique!
-- Reserved range for Cockpit commands is 3001-3998
local count = 3500
local function counter()
	count = count + 1
	return count
end

-- ==========================
--   Internal command codes
-- ==========================
if device_commands == nil then
	---Internal command codes identifying what was interacted with.
	device_commands =
	{

		ALT_SET = counter(),
		AP_MODE = counter(),  -- Autopilot: Cycle modes
		AP_TGL = counter(),
		AP_ARM = counter(),  -- Used by the A-10A to arm the autopilot system
		CANOPY = counter(),
		CAUTION_CLR = counter(),
		CHUTE = counter(),
		CLOCK = counter(),
		CM_AUTO = counter(),
		CM_CHAFF = counter(),
		CM_FLARE = counter(),
		ECM_TGL = counter(),
		EJECT = counter(),
		ENGL_OFF = counter(),
		ENGR_OFF = counter(),
		ENGL_ON = counter(),
		ENGR_ON = counter(),
		FLAPS = counter(),
		GEAR = counter(),
		HUD_BRT = counter(),
		HUD_CLR = counter(),
		JET_EXT = counter(),
		JET_FUEL = counter(),
		LGT_COLLISION = counter(),
		LGT_NAV = counter(),
		LGT_INT = counter(),
		LGT_LANDING = counter(),
		MIRROR = counter(),
		MM_AA = counter(),  -- Master Mode: Air-to-Air
		MM_AG = counter(),  -- Master Mode: Air-to-Ground
		MM_NAV = counter(),  -- Master Mode: Navigation
		NWS_STRUT = counter(),
		NWS_TGL = counter(),
		POWER_TGL = counter(),
		POWER_ON = counter(),
		POWER_OFF = counter(),
		RWR_VOL = counter(),
		RWR_MODE = counter(),
		WPT_CYCLE = counter(),  -- Waypoint / Airfield selection

		RDR_TGL = counter(),
		RDR_RANGE = counter(),
		RDR_VERT = counter(),  -- Adjust radar elevation
		RDR_HORZ = counter(),  -- Adjust radar horizontal angle

		WEP_CYCLE = counter(),
		WEP_RIP_INT = counter(),
		WEP_RIP_MODE = counter(),
		WEP_RIP_QTY = counter(),

		FUEL_AA_TGL = counter(),
		FUEL_DUMP = counter(),

		VIEW_VERT = counter(),
		VIEW_FWD = counter(),
		STICK_TGL = counter(),

	}
	
	FCCLOG.info("device_commands INIT")
end

-- ================
--   DCS commands
-- ================
-- Currently populated with binds from:
	-- A-10A
	-- F-15C
	-- F-5E
	-- F-86
	-- MiG-15bis
	-- MiG-29
	-- Su-27
	-- Su-33

-- iCommand values, used for sending commands to the game engine as if the player pressed a key
--
-- Can be found by adding the following line to your Saved Games/DCS/Config/autoexec.cfg file:
	-- input = 
	-- {
	-- 	command_code_tooltips = true,
	-- 	}

-- Or dumped en-masse for installed modules by adding this to the start of your
-- DCS/Config/Input/Aircrafts/Default/keyboard/default.lua file:
	-- local lfs = require("lfs")
	-- local io = require("io")
	-- f = io.open(lfs.writedir()..[[Logs\inputenum.txt]], "w")
	-- if f then
	-- f:write("\n\n*** fenv:\n")
	-- for k, v in pairs(getfenv()) do
	-- 	f:write(tostring(k))
	-- 	f:write("\t")
	-- 	f:write(tostring(v))
	-- 	f:write("\n")
	-- end	
	-- f:close()
	-- end

if iCommands == nil then
	---iCommand values, sent to the game engine to interact with aircraft systems.
	---The NAMES used here are unique to the mod, the VALUES are what's important.
	---For original names see "enumSorted.txt" in "_utilities\iCommand enums"
	iCommands = 
	{

		-- Master Modes
		MM_Nav = 105,
		MM_Air_BVR = 106,
		MM_Air_VerticalScan = 107,
		MM_Air_Boresight = 108,
		MM_Air_HelmetCue = 109,
		MM_FI0 = 110,  -- Longitudinal Missile Aiming Mode
		MM_Ground = 111,
		MM_Gunsight = 112,
		MM_NextTarget = 102,  -- Next Waypoint, Airfield or Target
		MM_PrevTarget = 1315,  -- Previous Waypoint, Airfield or Target

		-- Communications
		SYS_CycleReceiveMode = 1626,  -- AI Radio receive mode

		-- Countermeasures
		CM_DropFlareOnce = 357,
		CM_DropChaffOnce = 358,
		CM_ContinuousRelease = 77,
		CM_ReleaseOnce = 176,  -- Countermeasures release
		CM_ReleaseOnceOff = 536,  -- Countermeasures stop
		CM_Jamming = 136,  -- ECM

		-- Autopilot
		AP_EAC_Arm = 1050,  -- The A-10A's AP computer
		AP_EAC_Off = 1051,  -- The A-10A's AP computer
		AP_Toggle = 62,
		AP_Disengage = 408,
		AP_Reset = 629,
		AP_AttitudeMode = 386,
		AP_AltBankMode = 387,  -- Altitude / Bank Hold, or Damper
		AP_LevelMode = 388,  -- Transition to Level Flight
		AP_AltMode = 389,  -- Pressure Altitude Hold
		AP_RadarMode = 390,  -- Radar Alt Hold / MiG-29 Reapproach mode
		AP_AltModeH = 59,  -- Pressure ALtitude Hold 'H' bind
		AP_AltHdgMode = 636,  -- Altitude / Heading Hold
		AP_PathMode = 637,  -- Path Hold
		AP_RouteMode = 429,  -- Russian Path Hold
		AP_GroundAvoidance = 60,
		AP_MIG29_MinAlt = 64,
		AP_F15_CASRoll = 301,
		AP_F15_CASYaw = 302,
		AP_F15_CASPitch = 303,
		AP_SU33_AutoThrust = 63,
		AP_SU33_AutoThrustAdj = 64,

		-- Sensors
		TGT_EOSOnOff = 87,  -- A-10A CCRP Steering
		TGT_PredictedRangeDec = 262,
		TGT_PredictedRangeInc = 263,
		TGT_WingspanInc = 412,
		TGT_WingspanDec = 413,
		TGT_SelectorLeft = 139,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		TGT_SelectorRight = 140,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		TGT_SelectorUp = 141,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		TGT_SelectorDown = 142,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		TGT_SelectorStop = 230,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		TGT_ChangeLock = 100,  -- Target Lock / AA Refuel Disconnect
		TGT_ChangeLockStop = 1627,  -- Target Lock release
		TGT_Unlock = 1635,  -- Target Unlock / Return to Search

		RADAR_Toggle = 86,
		RADAR_ZoomIn = 103,
		RADAR_ZoomOut = 104,
		RADAR_MoveLeft = 88,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		RADAR_MoveRight = 89,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		RADAR_MoveUp = 90,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		RADAR_MoveDown = 91,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		RADAR_MoveCenter = 92,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		RADAR_MoveStop = 235,  -- Sometimes used to swivel the radar itself, sometimes for target designator
		RADAR_Mode = 285,  -- F-5E gunsight modes
		RADAR_PulseWidth = 394,
		RADAR_ResetTWS = 143,  -- TWS Target Unlock

		RWR_Mode = 286,
		RWR_VolumeDown = 409,  -- RWR Vol Down
		RWR_VolumeUp = 410,  -- RWR Vol Up


		-- Systems
		SYS_AltIncrease = 316,
		SYS_AltDecrease = 317,
		SYS_AltStop = 318,
		SYS_F86_ResetADI = 24,
		SYS_MIG15_ResetADI = 25,
		SYS_ResetMasterCaution = 144,
		SYS_ClockElapsedTimeReset = 1629,
		SYS_FlightClockReset = 288,
		
		SYS_TailHook = 69,
		SYS_FoldWings = 70,
		SYS_Canopy = 71,  -- Canopy Open/Close
		SYS_Eject = 83,

		SYS_EnginesStart = 309,
		SYS_EnginesStop = 310,
		SYS_LeftEngineStart = 311,
		SYS_RightEngineStart = 312,
		SYS_LeftEngineStop = 313,
		SYS_RightEngineStop = 314,
		SYS_Power = 315,
		SYS_IntakeScreens = 566,
		SYS_SU33_SpecialABMode = 1601,

		SYS_FlapsOn = 145,
		SYS_FlapsOff = 146,
		SYS_FlapsCycle = 72,
		SYS_AirbrakeOn = 147,
		SYS_AirbrakeOff = 148,
		SYS_AirbrakeCycle = 73,
		SYS_Parachute = 76,
		SYS_DirectControl = 121,
		SYS_SU33_RefuelingMode = 583,

		SYS_GearUp = 430,
		SYS_GearDown = 431,
		SYS_GearCycle = 68,
		SYS_WheelBrakeOn = 74,
		SYS_WheelBrakeOff = 75,
		SYS_NoseWheelSteeringRange = 562,  -- Sometimes used as NWS toggle
		SYS_NoseWheelSteering = 606,  -- F-5E Nose wheel strut EXTEND/RETRACT
		SYS_ParkingBrake = 855,

		SYS_AirRefuel = 155,  -- Refueling bay Open/Close
		SYS_DumpFuel = 79,
		SYS_DumpFuelStop = 80,
		SYS_JettisonWeapons = 82,
		SYS_JettisonWeaponsStop = 171,  -- Jettison Weapons release
		SYS_JettisonFuel = 178,
		SYS_F15_BingoIndex = 1092,  -- Used for both up and down
		SYS_F15_FuelQtySource = 1093,  -- Cycle which tank is shown in the fuel gauge
		SYS_F15_FuelBitTest = 1097,

		SYS_LightsNav = 175,  -- Cycle Nav lights
		SYS_LightsLanding = 328,  -- Cycle landing lights
		SYS_LightsCockpit = 300,
		SYS_LightsAntiCollision = 518,
		SYS_SU33_LightsRefuelling = 588,
		SYS_SU27_HUDonHDD = 672,
		SYS_HUDBrightnessUp = 746,
		SYS_HUDBrightnessDown = 747,
		SYS_HUDColor = 156,  -- Cycle HUD colors
		SYS_HUDFilter = 247,

		-- View
		VIEW_Mirrors = 1625,
		VIEW_CameraMoveUp = 484,
		VIEW_CameraMoveDown = 485,
		VIEW_CameraMoveStop = 490,

		-- Weapons
		W_ReleaseModeCycle = 284,  -- Cycles Ripple, Single, etc
		W_RippleIntervalUp = 282,  -- Release interval up
		W_RippleIntervalDown = 308,  -- Release interval down
		W_RippleQuantityCycle = 281,  -- MiG-15 Gun Selector
		W_SalvoOnOff = 81,
		W_ChangeWeapon = 101,
		W_CannonBurst = 280,
		W_LaunchPermissionOverride = 349,


	}

	FCCLOG.info("iCommands INIT")
end
