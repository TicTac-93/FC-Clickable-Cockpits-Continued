---@meta

---The voice chat singleton is a means of creating customized voice chat rooms for players to interact with each other in multiplayer. 
---@class VoiceChat
VoiceChat ={}

---@enum VoiceChat.Side
VoiceChat.Side = {
    NEUTRAL = 0,
    RED = 1,
    BLUE = 2,
    ALL = 3,
 }

 ---@enum VoiceChat.RoomType
 VoiceChat.RoomType= {
    PERSISTENT = 0,
    MULTICREW = 1,
    MANAGEABLE = 2,
 }

 ---Creates a VoiceChat room for players to join and interact with each other in a multiplayer mission.
 ---___
 ---Example:
 ---```lua
 ---  VoiceChat.CreateRoom("SRSIsBetter", 2, 0) 
 ---```
 ---___
 ---@param roomName string Name of roomto create.
 ---@param side VoiceChat.Side Who to create the room for.
 ---@param roomType VoiceChat.RoomType Type of room to create.
 function VoiceChat.createRoom(roomName, side, roomType) end