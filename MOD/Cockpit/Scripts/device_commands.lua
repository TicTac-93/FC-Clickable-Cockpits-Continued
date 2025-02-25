-- Stores command values for both internal use and for sending to the game engine
dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions

local count = 3500  -- Adjust starting value to deconflict with other systems in the game.  Our range of values HAS to be unique!
local function counter()
	count = count + 1
	return count
end

-- ========================
--  Internal command codes
-- ========================
if device_commands == nil then
	---Internal command codes identifying what was interacted with.
	device_commands =
	{

		ALT_SET = counter(),
		AP_MODE = counter(),  -- Autopilot: Cycle modes
		AP_TGL = counter(),
		CANOPY = counter(),
		CAUTION_CLR = counter(),
		CM_AUTO = counter(),
		CM_CHAFF = counter(),
		CM_FLARE = counter(),
		ECM_TGL = counter(),
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
		LGT_NAV = counter(),
		LGT_INT = counter(),
		LGT_LANDING = counter(),
		MIRROR = counter(),
		MM_AA = counter(),  -- Master Mode: Air-to-Air
		MM_AG = counter(),  -- Master Mode: Air-to-Ground
		MM_NAV = counter(),  -- Master Mode: Navigation
		POWER_TGL = counter(),
		POWER_ON = counter(),
		POWER_OFF = counter(),
		RWR_VOL = counter(),
		RWR_MODE = counter(),
		WPT_CYCLE = counter(),  -- Waypoint / Airfield selection

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

-- ==============
--  DCS commands
-- ==============
-- Currently populated with binds from:
	-- A-10A

if iCommands == nil then
	---iCommand values, sent to the game engine to interact with aircraft systems.
	iCommands = 
	{

		-- Master Modes
		MM_NAV = 105,
		MM_FI0 = 110,  -- Longitudinal Missile Aiming Mode
		MM_Ground = 111,
		MM_NextTarget = 102,  -- Next Waypoint, Airfield or Target
		MM_PrevTarget = 1315,  -- Previous Waypoint, Airfield or Target

		-- Communications
		SYS_CycleReceiveMode = 1626,  -- AI Radio receive mode

		-- Countermeasures
		CM_DropFlareOnce = 357,
		CM_DropChaffOnce = 358,
		CM_ContinuousStart = 77,  -- Continuously dispense
		CM_ReleaseOnce = 176,  -- Countermeasures release
		CM_ReleaseOnceOff = 536,  -- Countermeasures stop
		CM_Jamming = 136,  -- ECM

		-- LASTE / AP
		AP_EAC_ARM = 1050,
		AP_EAC_OFF = 1051,
		AP_Toggle = 62,
		AP_AltBankMode = 387,  -- Altitude / Bank Hold
		AP_AltHdgMode = 636,  -- Altitude / Heading Hold
		AP_PathMode = 637,  -- Path Hold

		-- Sensors
		TGT_EOSOnOff = 87,  -- CCRP Steering in A-10A
		TGT_ZoomIn = 103,  -- Radar zoom in
		TGT_ZoomOut = 104,  -- Radar zoom out
		TGT_DesignatorLeft = 88,  -- Target designator left
		TGT_DesignatorRight = 89,  -- Target designator right
		TGT_DesignatorUp = 90,  -- Target designator up
		TGT_DesignatorDown = 91,  -- Target designator down
		TGT_DesignatorCenter = 92,  -- Target designator center
		TGT_DesignatorStop = 235,  -- Target designator release
		TGT_ChangeLock = 100,  -- Target Lock / AA Refuel Disconnect
		TGT_ChangeLockStop = 1627,  -- Target Lock release
		TGT_ResetLock = 1635,  -- Target Unlock

		RWR_Mode = 286,
		RWR_VolumeDown = 409,  -- RWR Vol Down
		RWR_VolumeUp = 410,  -- RWR Vol Up


		-- Systems
		SYS_AltIncrease = 316,
		SYS_AltDecrease = 317,
		SYS_AltStop = 318,
		SYS_ResetMasterCaution = 144,
		SYS_ClockElapsedTimeReset = 1629,
		SYS_FlightClockReset = 288,
		
		SYS_Canopy = 71,  -- Canopy Open/Close
		SYS_Eject = 83,
		SYS_JettisonWeapons = 82,
		SYS_JettisonWeaponsStop = 171,  -- Jettison Weapons release

		SYS_Power = 315,
		SYS_EnginesStart = 309,
		SYS_EnginesStop = 310,
		SYS_LeftEngineStart = 311,
		SYS_RightEngineStart = 312,
		SYS_LeftEngineStop = 313,
		SYS_RightEngineStop = 314,

		SYS_FlapsOn = 145,  -- Landing Flaps
		SYS_FlapsOff = 146,  -- Raise Flaps
		SYS_FlapsCycle = 72, -- Cycle Flaps
		SYS_GearUp = 430,
		SYS_GearDown = 431,
		SYS_GearCycle = 68,  -- Cycle gear
		SYS_AirRefuel = 155,  -- Refueling bay Open/Close

		SYS_DumpFuel = 79,  -- Dump Fuel
		SYS_DumpFuelStop = 80,  -- Dump Fuel release

		SYS_LightsNav = 175,  -- Cycle Nav lights
		SYS_LightsLanding = 328,  -- Cycle gear lights
		SYS_LightsCockpit = 300,
		SYS_HUDBrightnessUp = 746,
		SYS_HUDBrightnessDown = 747,
		SYS_HUDColor = 156,  -- HUD color

		-- View
		VIEW_Mirrors = 1625,
		VIEW_CameraMoveUp = 484,
		VIEW_CameraMoveDown = 485,
		VIEW_CameraMoveStop = 490,

		-- Weapons
		W_ReleaseModeCycle = 284,  -- Cycles Ripple, Single, etc
		W_RippleIntervalUp = 282,  -- Release interval up
		W_RippleIntervalDown = 308,  -- Release interval down
		W_RippleQuantityCycle = 281,
		W_SalvoOnOff = 81,
		W_ChangeWeapon = 101,

	}

	FCCLOG.info("iCommands INIT")
end
