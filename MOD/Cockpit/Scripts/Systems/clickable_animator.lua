-- This handles updating animated connectors, so they stay aligned to the cockpit model

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")
dofile(LockOn_Options.script_path.."/Utilities/dump_data.lua")  -- Debug scripts

local self = GetSelf()
local mainpanel = GetDevice(0)
local aircraft = get_aircraft_type()
local is_FC24 = false
local is_F86 = false
local is_MIG15 = false

local arg_gear = 0
local arg_gear_fcc = 0
local arg_flaps = 0
local arg_flaps_fcc = 0

-- Timestep controls how often we update the position of animated connectors
local update_time_step = 0.1  -- Update will be called 10 times per second
make_default_activity(update_time_step)

-- Declare some vars for storing animated clickable elements, scoped to this file
local PNT_GEAR = nil
local PNT_FLAPS_ANIM = nil
local PNT_CANOPY = nil
local MIG15_CANOPY_2 = nil
local MIG15_CANOPY_3 = nil
local PNT_MIRROR_L = nil
local PNT_MIRROR_U = nil
local PNT_MIRROR_R = nil
local PNT_MISSING = nil  -- This point does not exist in any FCC files, and is purely to check for errors

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

end

-- This gets called every update_time_step
function update()

  -- Special treatment for the FC24 planes, they don't use base_gauge_LandingGearHandlePos
  if is_FC24 then
    mainpanel:set_argument_value(arg_gear_fcc, get_cockpit_draw_argument_value(arg_gear))

    -- Extra special treatment for the F-86 and MiG-15 for animated flap handles
    if is_F86 or is_MIG15 then
      mainpanel:set_argument_value(arg_flaps_fcc, get_cockpit_draw_argument_value(arg_flaps))
    end
  end

  -- Check if we found each point during post_initialize() before attempting to update them
  -- Condensed to one-liners since we aren't doing anything complex
  if PNT_GEAR then PNT_GEAR:update() end
  if PNT_FLAPS_ANIM then PNT_FLAPS_ANIM:update() end
  if PNT_CANOPY then PNT_CANOPY:update() end
  if MIG15_CANOPY_2 then MIG15_CANOPY_2:update() end
  if MIG15_CANOPY_3 then MIG15_CANOPY_3:update() end
  if PNT_MIRROR_L then PNT_MIRROR_L:update() end
  if PNT_MIRROR_U then PNT_MIRROR_U:update() end
  if PNT_MIRROR_R then PNT_MIRROR_R:update() end
  if PNT_MISSING then PNT_MISSING:update() end

end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  -- Store the clickable elements we're interested in updating.
  PNT_GEAR = get_clickable_element_reference("PNT_GEAR")
  PNT_FLAPS_ANIM = get_clickable_element_reference("PNT_FLAPS_ANIM")
  PNT_CANOPY = get_clickable_element_reference("PNT_CANOPY")
  MIG15_CANOPY_2 = get_clickable_element_reference("MIG15_CANOPY_2")
  MIG15_CANOPY_3 = get_clickable_element_reference("MIG15_CANOPY_3")
  PNT_MIRROR_L = get_clickable_element_reference("PNT_MIRROR_L")
  PNT_MIRROR_U = get_clickable_element_reference("PNT_MIRROR_U")
  PNT_MIRROR_R = get_clickable_element_reference("PNT_MIRROR_R")
  PNT_MISSING = get_clickable_element_reference("PNT_MISSING")

  -- Check if we're in a FC24 aircraft, requires special syncing
  if aircraft == "F-5E-3_FC" or aircraft == "F-86F_FC" or aircraft == "MiG-15bis_FC" then
    is_FC24 = true

    -- Define which arg to sync the gear lever with, it varies from plane to plane
    -- arg_gear is the FC24 animation arg
    -- arg_gear_fcc is the mod animation arg, may vary to avoid conflicts
    if aircraft == "F-5E-3_FC" then
      arg_gear = 83
      arg_gear_fcc = 2

    elseif aircraft == "F-86F_FC" then
      is_F86 = true
      arg_gear = 599
      arg_gear_fcc = 2
      arg_flaps = 735
      arg_flaps_fcc = 4
    
    elseif aircraft == "MiG-15bis_FC" then
      is_MIG15 = true
      arg_gear = 71
      arg_gear_fcc = 2
      arg_flaps = 207
      arg_flaps_fcc = 3
      
    end
  end
  
  FCCLOG.info("clickable_animator INIT")
end

need_to_be_closed = false
