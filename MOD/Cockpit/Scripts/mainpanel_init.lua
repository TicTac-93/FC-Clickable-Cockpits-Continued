-- Specified by device_init.lua, but called by EDGE
-- Responsible for loading the model (shape_name) for the cockpit,
-- as well as connecting parameters to animation args via Gauges

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")  -- Mod logging functions

local aircraft = get_aircraft_type()

if aircraft == "A-10A" then
  shape_name = "FCClickable_A-10A"
end

FCCLOG.info("SHAPE set to "..shape_name)

local controllers = LoRegisterPanelControls()  -- Required?

-- Animation "gauges" declared here

FCCLOG.info("mainpanel_init INIT")

need_to_be_closed = true