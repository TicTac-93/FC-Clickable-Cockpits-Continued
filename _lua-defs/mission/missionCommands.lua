---@meta

---@class missionCommands
missionCommands = {}

---Adds a command to the "F10 Other" radio menu allowing players to run specified scripting functions. Command is added for both teams. The string name is the text that will be displayed in the F10 Other menu and is also used in the function to remove the command from the menu.<br>
---Path is an optional value that defines whether or not the command will be in a named submenu.<br>
---FunctionToCall is the name of the function, with the optional argument value designating any passed values.<br>
---Function returns a table indexed numerically indicating where in the F10 menu the command resides.<br>
---Examples of return values:<br>
---```
---{
---   [1] = "Negative Ghostrider",
---}
---{
---   [1] = "SubMenuInRoot", 
---   [2] = "Command in the submenu",
---}
---{ 
---   [1] = "SubMenuInRoot", 
---   [2] = "SubMenuInSubMenu", 
---   [3] = "Command in nested submenu",
---}
---```
---The sample below will generate a base menu accessed via F10 called "Display Requests" for all users with two sub-items for a negative or positive response:<br>
---```
---local function displayRequests(vars)
---    if vars.flyby == true then
---        trigger.action.outText("Roger that Ghostrider, you may do a flyby.", 20)
---    else
---        trigger.action.outText("Negative Ghostrider, the pattern is full", 20)
---    end
---end
---local displayRequests = missionCommands.addSubMenu( "Display Requests")
---local negativeReply = missionCommands.addCommand( "Negative Ghostrider", displayRequests , displayMsg, {flyby = false})
---local positiveReply = missionCommands.addCommand( "Roger Ghostrider", displayRequests , displayMsg, {flyby = true})
---```
---@param name string -- The name of the command to be displayed in the F10 Other menu.
---@param path table | nil -- Defines whether the command will be in a named submenu.
---@param functionToRun function -- The function to be run.
---@param ... any -- Optional. Any passed values.
---@return table -- A table indicating where in the F10 menu the command resides.
function missionCommands.addCommand(name, path, functionToRun, ...) end

---Creates a submenu of a specified name for all players. Can be used to create nested submenus. If the path is not specified, submenu is added to the root menu.<br>
---Function returns a table indexed numerically indicating where in the F10 menu the submenu resides.<br>
---Example of return value:<br>
---```
---{
---   [1] = "SubMenuInRoot",
---}
---```
---The following creates a submenu named "Request Asset" and fills it with 3 options "SEAD", "CAS", and "CAP":<br>
---```
---local requestM = missionCommands.addSubMenu('Request Asset')
---local rSead = missionCommands.addCommand('SEAD', requestM, doRequestFunction, {type = "SEAD"})
---local rCAS = missionCommands.addCommand('CAS', requestM, doRequestFunction, {type = "CAS"})
---local rCAP= missionCommands.addCommand('CAP', requestM, doRequestFunction, {type = "CAP"})
---```
---An example of how to create nested submenus:<br>
---```
---local subR = missionCommands.addSubMenu('Root SubMenu')
---local subN1 = missionCommands.addSubMenu('SubMenu within RootSubmenu', subR)
---local subN2 = missionCommands.addSubMenu('we must go deeper', subN1)
---local subN3 = missionCommands.addSubMenu('Go take a UX class', subN2)
---```
---@param name string -- The name of the submenu.
---@param path table? -- Optional. Defines whether the submenu will be in a named submenu.
---@return table -- A table indicating where in the F10 menu the submenu resides.
function missionCommands.addSubMenu(name, path) end

---Removes the item of the specified path from the F10 radio menu for all. If the value is nil all items will be removed from the radio menu. If the path given is a submenu then all items nested within will be removed.<br>
---This function does not return a value.<br>
---The following would remove a command named "Test Command" that is listed in the root menu:<br>
---```
---missionCommands.removeItem({[1] = "Test Command"})
---```
---Here is a relatively simple setup to save possibly multiple paths for commands generated for the purpose of removing it at a later time. When a command is created it is stored in the commandDB table. When the player selects "Warning Message" in their F10 menu the player will be informed that someone is taking the Hobbits to Isengard, repeatedly. At the end of the function it calls the removeItem function to remove the path with the name "Isengard" from the commandDB table:<br>
---```
---local commandDB = {}
---local function removeItem(name) 
---   missionCommands.removeItem(commandDB[name])
---end
---local function loopMessage() 
---   for i = 1, 20 do
---     trigger.action.outText('They are taking the Hobbits to Isengard', 2)
---   end
---    removeItem('Isengard')
---end 
---commandDB['Isengard'] = missionCommands.addCommand('Warning Message', nil, loopMessage)
---```
---@param path table | nil -- The path of the item to be removed. If nil, all items will be removed.
function missionCommands.removeItem(path) end

---Adds a command to the "F10 Other" radio menu allowing players to run specified scripting functions. Command is added for the specified coalition. The string name is the text that will be displayed in the F10 Other menu and is also used in the function to remove the command from the menu.<br>
---Path is an optional value that defines whether or not the command will be in a named submenu.<br>
---FunctionToCall is the name of the function, with the optional argument value designating any passed values.<br>
---This function returns a table indicating where in the F10 menu the command resides.<br>
---@param coalition coalition.side -- The coalition for which the command is added.
---@param name string -- The name of the command.
---@param path table | nil -- Optional. Defines whether the command will be in a named submenu.
---@param functionToRun function -- The function to be run when the command is selected.
---@param ... any -- Optional. Any argument to be passed to the function.
---@return table -- A table indicating where in the F10 menu the command resides.
function missionCommands.addCommandForCoalition(coalition, name, path, functionToRun, ...) end

---Creates a submenu of a specified name for the specified coalition. Can be used to create nested submenus. If the path is not specified, submenu is added to the root menu.<br>
---This function returns a table indicating where in the F10 menu the submenu resides.<br>
---@param coalition coalition.side -- The coalition for which the submenu is added.
---@param name string -- The name of the submenu.
---@param path table | nil -- Optional. Defines whether the submenu will be in a named submenu.
---@return table -- A table indicating where in the F10 menu the submenu resides.
function missionCommands.addSubMenuForCoalition(coalition, name, path) end

---Removes the item of the specified path from the F10 radio menu for the specified coalition. If the value is nil all items will be removed from the radio menu.<br>
---This function does not return a value.<br>
---@param coalition coalition.side -- The coalition for which the item is removed.
---@param path table | nil -- The path of the item to be removed. If nil, all items will be removed.
function missionCommands.removeItemForCoalition(coalition, path) end

---Adds a command to the "F10 Other" radio menu allowing players to run specified scripting functions. Command is added for the specified groupId. The string name is the text that will be displayed in the F10 Other menu and is also used in the function to remove the command from the menu.<br>
---Path is an optional value that defines whether or not the command will be in a named submenu.<br>
---FunctionToCall is the name of the function, with the optional argument value designating any passed values.<br>
---This function returns a table indicating where in the F10 menu the command resides.<br>
---The following iterates the table, finds their groupIds, and passes the groupName to the imLost function whenever someone from the group selects the F10 choice:<br>
---```
---local function imLost(gName)
---  -- whatever
---end
---local tbl = {'group1', 'group2', 'group3', 'group4' ,'group5'}
---for i = 1, #tbl do
---   if Group.getByName(tbl[i]) then
---      local groupId = Group.getByName(tbl[i]):getID
---      missionCommands.addCommandForGroup(groupId, 'Halp', nil , imLost, tbl[i])
---   end
---end
---```
---@param groupId integer -- The groupId for which the command is added.
---@param name string -- The name of the command.
---@param path table | nil -- Optional. Defines whether the command will be in a named submenu.
---@param functionToRun function -- The function to be run when the command is selected.
---@param ... any -- Optional. Any argument to be passed to the function.
---@return table -- A table indicating where in the F10 menu the command resides.
function missionCommands.addCommandForGroup(groupId, name, path, functionToRun, ...) end

---Creates a submenu of a specified name for the specified group. Can be used to create nested submenus. If the path is not specified, submenu is added to the root menu.<br>
---This function returns a table indicating where in the F10 menu the submenu resides.<br>
---@param groupId integer -- The groupId for which the submenu is added.
---@param name string -- The name of the submenu.
---@param path table | nil -- Optional. Defines whether the submenu will be in a named submenu.
---@return table -- A table indicating where in the F10 menu the submenu resides.
function missionCommands.addSubMenuForGroup(groupId, name, path) end

---Removes the item of the specified path from the F10 radio menu for the specified group. If the value is nil all items will be removed from the radio menu.<br>
---This function does not return a value.<br>
---@param groupId number -- The groupId for which the item is removed.
---@param path table | nil -- The path of the item to be removed. If nil, all items will be removed.
function missionCommands.removeItemForGroup(groupId, path) end