-- Specified by device_init.lua, but called by EDGE
-- Responsible for loading the model (shape_name) for the cockpit,
-- as well as connecting parameters to animation args via Gauges

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions
dofile(LockOn_Options.script_path.."/Utilities/dump_data.lua")  -- Debug scripts

local aircraft = get_aircraft_type()
shape_name = ""

-- Set the clickable cockpit model based on the current aircraft
if aircraft == "A-10A" then
  shape_name = "FCClickable_A-10A"
elseif aircraft == "F-5E-3_FC" then
  shape_name = "FCClickable_F-5E"
elseif aircraft == "F-15C" then
  shape_name = "FCClickable_F-15C"
end

FCCLOG.info("SHAPE set to " .. shape_name)

local controllers = LoRegisterPanelControls()
-- dump_table(controllers)  -- Print all of the parameters to the log
-- show_param_handles_list()  -- Opens a window in-game to show the values of different parameters in real-time

-- Animation "gauges" declared here

-- FCC_GEARLEVER              = CreateGauge()
-- FCC_GEARLEVER.arg_number   = 1
-- FCC_GEARLEVER.input        = {0,1}
-- FCC_GEARLEVER.output       = {0,1}
-- FCC_GEARLEVER.controller   = controllers.base_gauge_LandingGearHandlePos

-- FCC_CANOPY                 = CreateGauge()
-- FCC_CANOPY.arg_number      = 2
-- FCC_CANOPY.input           = {0,1}
-- FCC_CANOPY.output          = {0,1}
-- FCC_CANOPY.controller      = controllers.base_gauge_CanopyPos


FCCLOG.info("mainpanel_init INIT")

need_to_be_closed = true
