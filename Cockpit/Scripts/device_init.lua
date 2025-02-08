-- Run automatically by EDGE
-- More or less responsible for initializing the rest of the plugin
--
-- Since the plugin will only run for aircraft that it's been associated with in entry.lua,
-- and  will only run if their option is enabled, we can proceed with starting up.

local aircraft = get_aircraft_type()

log.info("Detected aircraft " .. aircraft)