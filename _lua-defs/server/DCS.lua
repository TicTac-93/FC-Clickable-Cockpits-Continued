---@meta

---@class DCS
DCS = {
    UNIT_RUNTIME_ID = 1,
    UNIT_MISSION_ID = 2,
    UNIT_NAME = 3,
    UNIT_TYPE = 4,
    UNIT_CATEGORY = 5,
    UNIT_GROUP_MISSION_ID = 6,
    UNIT_GROUPNAME = 7,
    UNIT_GROUPCATEGORY = 8,
    UNIT_CALLSIGN = 9,
    UNIT_HIDDEN = 10,
    UNIT_COALITION = 11,
    UNIT_COUNTRY_ID = 12,
    UNIT_TASK = 13,
    UNIT_PLAYER_NAME = 14,
    UNIT_ROLE = 15,
    UNIT_INVISIBLE_MAP_ICON = 16
}
---Pauses/resumes the simulation. Server-side only.
---@param action boolean -- If true, pauses the server. If false, resumes the server.
---@return nil
---Example: This example pauses the server
---```
---DCS.setPause(true)
---```
---This would resume the server
---```
---DCS.setPause(false)
---```
function DCS.setPause(action) end

---Returns the pause state of a server. True for server is paused, false if server is not paused.
---@return boolean -- True if the server is paused, false otherwise.
function DCS.getPause() end

---Command to stop the mission.
function DCS.stopMission() end

---Command to close the DCS application.
function DCS.exitProcess() end

---Returns whether or not the game is in the multiplayer mode.
---@return boolean -- True if the game is in multiplayer, false in single player.
function DCS.isMultiplayer() end

---Returns whether or not the game is running as a server or is in the single player mode. 
---@return boolean
function DCS.isServer() end

---Returns the DCS simulation time in seconds. Dependent on how long the mission has been running.
---@return number
function DCS.getModelTime() end

---Returns the current time in a mission relative to the DCS process start time.
---@return number
function DCS.getRealTime() end

---Returns the table of the options for a given mission as stored in the options.lua file embedded in a miz. 
---@return table
function DCS.getMissionOptions() end

---Returns a list of coalitions which have client slots available. 
---@return table
function DCS.getAvailableCoalitions() end

---Returns a table of slots available to a given coalition. 
---@param coalition 'red' | 'blue'
---@return table
function DCS.getAvailableSlots(coalition) end

---Returns the table of the mission as stored in the mission file embedded in a miz. 
---@return table
function DCS.getCurrentMission() end

---Returns the name of the mission. 
---@return string
function DCS.getMissionName() end

---Returns the file name of the current mission file. 
---@return string
function DCS.getMissionFilename() end

---Returns the current result for a given coalition as defined by the mission goals in the mission. 
---@param coalition 'red' | 'blue'
---@return number
function DCS.getMissionResult(coalition) end

---Returns the given property for the passed unit. <br>
---List of properties:
---```
--- DCS.UNIT_RUNTIME_ID -- unique within runtime mission. int
--- DCS.UNIT_MISSION_ID -- unique within mission file. int>0
--- DCS.UNIT_NAME -- unit name, as assigned by mission designer.
--- DCS.UNIT_TYPE -- unit type (Ural, ZU-23, etc)
--- DCS.UNIT_CATEGORY,
--- DCS.UNIT_GROUP_MISSION_ID -- group ID, unique within mission file. int>0
--- DCS.UNIT_GROUPNAME -- group name, as assigned by mission designer.
--- DCS.UNIT_GROUPCATEGORY,
--- DCS.UNIT_CALLSIGN,
--- DCS.UNIT_HIDDEN -- ME hiding
--- DCS.UNIT_COALITION -- "blue", "red" or "unknown"
--- DCS.UNIT_COUNTRY_ID,
--- DCS.UNIT_TASK --"unit.group.task"
--- DCS.UNIT_PLAYER_NAME -- valid for network "humanable" units
--- DCS.UNIT_ROLE --"artillery_commander", "instructor", etc
--- DCS.UNIT_INVISIBLE_MAP_ICON --ME invisible map icon
---```
---@param unitId integer
---@param property enum
---@return string
function DCS.getUnitProperty(unitId, property) end

---Shortcut of `DCS.getUnitProperty(missionId, DCS.UNIT_TYPE)`
---@param unitId integer
function DCS.getUnitType(unitId) end

---Returns the attribute of the specified type for the specified unit type.<br>
---Example:
---```
---DCS.getUnitTypeAttribute("Ural", "DisplayName") 
---```
---@param typeName string -- The type of the unit.
---@param attribute string -- The attribute to get.
---@return string, number, table
function DCS.getUnitTypeAttribute(typeName, attribute) end

---Adds the functions defined in the table to be run when the given event is called from the GameGUI environment.<br>
---For each grouping of callbacks you create it needs to be added to a file placed in your saved games folder.<br>
---This file is automatically loaded when the game starts. File is placed in Users\%YOURWINDOWSUSERNAME%\Saved Games\DCS\Scripts\Hooks folder. If this folder does not exist create it.<br>
---Some callbacks can have a return value. If returned in your code then that value will take precedence over any other callback that might be checking the same thing.<br>
---It is best to return nothing unless you want to force a given action to occur.<br>
---@param functions table -- A table of functions to be run when the corresponding event is called.
---Example: The following saves and modifies global values for the current mission name and a list of connected clients.
---```lua
---local myCall = {}
---clients = {}
---function myCall.onMissionLoadBegin()
---   current_mission = DCS.getMissionName()
---end
---function myCall.onPlayerConnect(id)
---   clients[id] = {id = id, addr = net.get_player_info(id, 'ipaddr'), name = net.get_player_info(id, 'name'), ucid = net.get_player_info(id, 'ucid'), ip = net.get_player_info(id, 'ipaddr')}
---end  
---function myCall.onPlayerDisconnect(id)
---   clients[id] = nil
---end 
---DCS.setUserCallbacks(myCall)
---```
function DCS.setUserCallbacks(functions) end