---@meta

---@class net
net = {}

---Executes a lua string in a given lua environment in the game.
---@param state 'mission'|'gui'|'server'|'export'|'config' -- The lua environment in the game.<br>
--- `'mission'`: holds current mission <br>
--- `'server'`: GUI (hooks) environment <br>
--- `'export'`: runs $WRITE_DIR/Scripts/Export.lua and the relevant export API <br>
--- `'config'`: the state in which $INSTALL_DIR/Config/main.cfg is executed, as well as $WRITE_DIR/Config/autoexec.cfg. Used for configuration settings <br>
---@param dostring string -- The lua string to be executed.
---@return string -- The result of the lua string execution.
function net.dostring_in(state, dostring) end

---Forces the player to occupy the set slot.<br>
---SlotId matches unit Ids of client aircraft. The exception being Combined Arms slots and multicrew slots. The latter of which have "_X" appended to denote the seat.
---SideID:
--- - 0 : spectators
--- - 1 : Red
--- - 2 : Blue
---@param playerID integer -- The id of the player.
---@param sideId integer -- The id of the side.
---@param slotId integer|string -- The id of the slot.
---@return boolean
function net.force_player_slot(playerID, sideId, slotId) end

---Returns the name of a given player.<br>Is the same as `net.get_player_info(playerID, 'name')`.
---@param playerID integer -- from `net.get_player_list()`
---@return string
function net.get_name(playerID) end

---Returns a table of players currently connected to the server.
---@return integer[]
function net.get_player_list() end

---@class netPlayerInfo
---@field id integer
---@field name string
---@field side integer|0|1|2
---@field slot integer
---@field ping integer
---@field ipaddr string
---@field ucid string

---Returns a table of attributes for a given playerId. If optional attribute present only that value is returned.
---Attributes:
--- - `id`    : playerID
--- - `name`  : player name
--- - `side`  : 0 - spectators, 1 - red, 2 - blue
--- - `slot`  : slotID of the player
--- - `ping`  : ping of the player in ms
--- - `ipaddr`: IP address of the player, SERVER ONLY
--- - `ucid`  : Unique Client Identifier, SERVER ONLY
---@param playerID integer -- The id of the player.
---@param attribute string? -- The attribute to be returned (optional).
---@return netPlayerInfo -- The table of attributes for the player.
function net.get_player_info(playerID, attribute) end

--- Returns a statistic from a given player.<br>
--- Attributes:
---```
--- net.PS_PING  -- (0) ping (in ms)
--- net.PS_CRASH -- (1) number of crashes
--- net.PS_CAR   -- (2) number of destroyed vehicles
--- net.PS_PLANE -- (3) number of destroyed planes/helicopters
--- net.PS_SHIP  -- (4) number of destroyed ships
--- net.PS_SCORE -- (5) total score
--- net.PS_LAND  -- (6) number of landings
--- net.PS_EJECT -- (7) number of ejects
---```
--- @param playerID number The ID of the player.
--- @param statID number The ID of the statistic to retrieve.
--- @return number The requested statistic for the specified player.
function net.get_stat(playerID, statID) end

---Converts a lua value to a JSON string.
---@param lua any
---@return string
function net.lua2json(lua) end

---Converts a JSON string to a lua table.
---@param json string
---@return table
function net.json2lua(json) end

---Kicks a player from the server. Can display a message to the user.
---@param playerId integer -- The id of the player to be kicked.
---@param message string? -- The message to player received after kicked.
---@return boolean
function net.kick(playerId, message) end

---Loads the specified mission.<br>
---Example: Loads a mission from your saved games/missions folder. 
---```
---net.load_mission(lfs.writeDir() .. 'Missions\\' .. 'MyTotallyAwesomeMission.miz')
---```
---@param fileName string -- The path and name of the mission file to load.
---@return boolean -- True if the mission was successfully loaded, false otherwise.
function net.load_mission(fileName) end

---Loads the next mission from the server mission list.
---@return boolean -- True if the next mission was successfully loaded, false if at the end of the list.
function net.load_next_mission() end

---Sends a chat message.
---@param message string
---@param all boolean
function net.send_chat(message, all) end

---Sends a chat message to the player with the passed id.<br>
---If the optional fromId is set, then the player will appear to receive a message from that player.
---@param message string
---@param playerId number
---@param fromId number?
function net.send_chat_to(message, playerId, fromId) end