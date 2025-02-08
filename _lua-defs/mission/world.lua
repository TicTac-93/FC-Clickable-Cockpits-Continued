---@meta
---@class world
---@field eventHandlers table
world = {}
---@enum world.event
world.event = {
    S_EVENT_INVALID = 0,
    S_EVENT_SHOT = 1,
    S_EVENT_HIT = 2,
    S_EVENT_TAKEOFF = 3,
    S_EVENT_LAND = 4,
    S_EVENT_CRASH = 5,
    S_EVENT_EJECTION = 6,
    S_EVENT_REFUELING = 7,
    S_EVENT_DEAD = 8,
    S_EVENT_PILOT_DEAD = 9,
    S_EVENT_BASE_CAPTURED = 10,
    S_EVENT_MISSION_START = 11,
    S_EVENT_MISSION_END = 12,
    S_EVENT_TOOK_CONTROL = 13,
    S_EVENT_REFUELING_STOP = 14,
    S_EVENT_BIRTH = 15,
    S_EVENT_HUMAN_FAILURE = 16,
    S_EVENT_DETAILED_FAILURE = 17,
    S_EVENT_ENGINE_STARTUP = 18,
    S_EVENT_ENGINE_SHUTDOWN = 19,
    S_EVENT_PLAYER_ENTER_UNIT = 20,
    S_EVENT_PLAYER_LEAVE_UNIT = 21,
    S_EVENT_PLAYER_COMMENT = 22,
    S_EVENT_SHOOTING_START = 23,
    S_EVENT_SHOOTING_END = 24,
    S_EVENT_MARK_ADDED  = 25,
    S_EVENT_MARK_CHANGE = 26,
    S_EVENT_MARK_REMOVED = 27,
    S_EVENT_KILL = 28,
    S_EVENT_SCORE = 29,
    S_EVENT_UNIT_LOST = 30,
    S_EVENT_LANDING_AFTER_EJECTION = 31,
    S_EVENT_PARATROOPER_LENDING = 32,
    S_EVENT_DISCARD_CHAIR_AFTER_EJECTION = 33,
    S_EVENT_WEAPON_ADD = 34,
    S_EVENT_TRIGGER_ZONE = 35,
    S_EVENT_LANDING_QUALITY_MARK = 36,
    S_EVENT_BDA = 37,
    S_EVENT_AI_ABORT_MISSION = 38,
    S_EVENT_DAYNIGHT = 39,
    S_EVENT_FLIGHT_TIME = 40,
    S_EVENT_PLAYER_SELF_KILL_PILOT = 41,
    S_EVENT_PLAYER_CAPTURE_AIRFIELD = 42,
    S_EVENT_EMERGENCY_LANDING = 43,
    S_EVENT_UNIT_CREATE_TASK = 44,
    S_EVENT_UNIT_DELETE_TASK = 45,
    S_EVENT_SIMULATION_START = 46,
    S_EVENT_WEAPON_REARM = 47,
    S_EVENT_WEAPON_DROP = 48,
    S_EVENT_UNIT_TASK_TIMEOUT = 49,
    S_EVENT_UNIT_TASK_STAGE = 50,
    S_EVENT_MAC_SUBTASK_SCORE = 51,
    S_EVENT_MAC_EXTRA_SCORE = 52,
    S_EVENT_MISSION_RESTART = 53,
    S_EVENT_MISSION_WINNER = 54,
    S_EVENT_POSTPONED_TAKEOFF = 55,
    S_EVENT_POSTPONED_LAND = 56,
    S_EVENT_MAX = 57,
}

---@enum world.VolumeType
world.VolumeType = {
    SEGMENT = 0,
    BOX = 1,
    SPHERE = 2,
    PYRAMID = 3
}

---@enum world.BirthPlace
world.BirthPlace = {
    wsBirthPlace_Air = 1,
    wsBirthPlace_Ship = 3,
    wsBirthPlace_RunWay = 4,
    wsBirthPlace_Park = 5,
    wsBirthPlace_Heliport_Hot = 10,
    wsBirthPlace_Heliport_Cold = 11,
    wsBirthPlace_Ship_Cold = 12,
    wsBirthPlace_Ship_Hot = 13
}

---Returns a table of airbase objects belonging to the specified coalition. Objects can be ships, static objects(FARP), or airbases on the map.<br>
---When the function is run as world.getAirbases() no input values required, and the function returns all airbases, ships, and farps on the map.<br>
---
---Example:
---The following iterates the returned airbases via world.getAirbases() and stores callsign, id, and other useful information in another table.
---```
---local base = world.getAirbases()
---local myBaseTbl = {}
---for i = 1, #base do
---    local info = {}
---    info.desc = Airbase.getDesc(base[i])
---    info.callsign = Airbase.getCallsign(base[i])
---    info.id = Airbase.getID(base[i])
---    info.cat = Airbase.getCategory(base[i])
---    info.point = Airbase.getPoint(base[i])
---    if Airbase.getUnit(base[i]) then
---        info.unitId = Airbase.getUnit(base[i]):getID()
---    end
---    
---    myBaseTbl[info.callsign] = info
---end
---```
---@return Airbase[]
function world.getAirbases() end

---Returns a table of mark panels and drawn shapes indexed numerically that are present within the mission.<br>
---Panel is designed with the mark points in mind, but still returns data for shapes created via markups.<br>
---@return table
---Return Example: Table indexed numerically.
---```
---[1] ={
---   idx = idxMark(IDMark),
---   time = Time,
---   initiator = Unit,
---   coalition = -1 (or RED/BLUE),
---   groupID = -1 (or ID),
---   text = markText,
---   pos = vec3
---}
---```
function world.getMarkPanels() end

---Returns a table of the single unit object in the game who's skill level is set as "Player".<br>
---There is only a single player unit in a mission and in single player the user will always spawn into this unit automatically unless other client or Combined Arms slots are available.<br>
---@return table
function world.getPlayer() end

---Adds a function as an event handler that executes whenever a simulator event occurs.<br>
---The most common uses of event handlers are to track statistics of units within a given scenario and to execute code based on certain events occurring.<br>
---Handlers are passed event tables which contains numerous data regarding the event.<br>
---For examples of the event tables returned, reference the event page on the wiki to get more information regarding the event.<br>
---Event Types: shot, hit, takeoff, land, crash, ejection, refueling, dead, pilot_dead, base_captured, mission_start, mission_end, took_control, refueling_stop, birth, human_failure, detailed_failure, engine_startup, engine_shutdown, player_enter_unit, player_leave_unit, player_comment, shooting_start, shooting_end, mark_added, mark_change, mark_remove, kill, score, unit_lost, landing_after_ejection, discard_chair_after_ejection, weapon_add, landing_quality_mark, ai_abort_mission, weapon_drop<br>
---
---Example:
---The following displays a message detailing the event that occurred:
---```
---local e = {}
---function e:onEvent(event)
---    local m = {}
---    m[#m+1] = "Event ID: "
---    m[#m+1] = event.id
---    if event.initiator then 
---       m[#m+1] = "\nInitiator : "
---       m[#m+1] = event.initiator:getName()
---    end
---    if event.weapon then 
---       m[#m+1] = "\nWeapon : "
---       m[#m+1] = event.weapon :getTypeName()
---    end 
---    if event.target then 
---       m[#m+1] = "\nTarget : "
---       m[#m+1] = event.target :getName()
---    end 
---    trigger.action.outText(table.concat(m), 60)
---end
---world.addEventHandler(e)
---```
---@param handler table
---@return function
function world.addEventHandler(handler) end

---Removes the specified event handler from handling events.<br>
---Use this when an event handler has outlived its usefulness.<br>
---@param handler EventHandler
---@return function
function world.removeEventHandler(handler) end

---Searches the defined area passed to the function to remove craters, object wreckage, and any other debris within the search volume.<br>
---Will not remove wreckage of scenery objects.<br>
---See pages for the correct format of each volume type: Volumes: segment, box, sphere, pyramid.<br>
---
---Example:
---The following will remove wreckage, craters, and debris in the zone "trainingAirbase" where there surely will be wreckage, craters, and debris due to skill issues.
---```
---local sphere = trigger.misc.getZone('trainingAirbase')
---sphere.point.y = land.getHeight({x = sphere.point.x, y = sphere.point.z})
---local volS = {
---   id = world.VolumeType.SPHERE,
---   params = {
---     point = sphere.point,
---     radius = sphere.radius
---   }
---}
---world.removeJunk(volS)
---```
---@param searchVolume volume
---@return number
---Return Example: 420
function world.removeJunk(searchVolume) end

---Searches a defined volume of 3d space for the specified objects within it and then can run function on each returned object.<br>
---Object category is either a single enum or a table of enums that defines the types of objects that will be searched for.<br>
---Search volume is the defined 3d space that will be searched. See pages for the correct format of each volume type: Volumes: segment, box, sphere, pyramid.<br>
---Handler is the function that will be run on each object that is found.<br>
---Any data is a variable that is passed to the handler function, it can be anything.<br>
---
---Example:
---The following example would populate the table "foundUnits" of any unit found within a sphere defined by the zone "town".
---```
---local foundUnits = {}
---local sphere = trigger.misc.getZone('town')
---local volS = {
---   id = world.VolumeType.SPHERE,
---   params = {
---     point = sphere.point,
---     radius = sphere.radius
---   }
---}
--- 
---local ifFound = function(foundItem, val)
---    foundUnits[#foundUnits + 1] = foundItem:getName()
---    return true
---end
---
---world.searchObjects(Object.Category.UNIT, volS, ifFound)
---```
---@param objectCategory table|enum
---@param searchVolume volume
---@param Handler function
---@param data any
---@return table
---Return Example: Object
function world.searchObjects(objectCategory, searchVolume, Handler, data) end

---@class EventHandler: table
---@field onEvent function

---@class volume
---@field id world.VolumeType
---@field params volume.params

---@class volume.params
---@field point vec3
---@field radius number