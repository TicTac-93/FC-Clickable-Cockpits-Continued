-- Called by device_init.lua
-- Responsible for loading the model (shape_name) for the cockpit,
-- as well as connecting parameters to animation args via Gauges

local aircraft = get_aircraft_type()

if aircraft == "A-10A" then
  shape_name = "FCClickable_A-10A"
  log.info("SHAPE set to FCClickable_A-10A")
end

-- Animation "gauges" declared here

need_to_be_closed = true