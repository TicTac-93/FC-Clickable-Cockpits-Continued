---@meta

---@class env
---@field mission table see [Miz mission structure](https://wiki.hoggitworld.com/view/Miz_mission_structure)
---@field warehouse table see [Miz warehouses structure](https://wiki.hoggitworld.com/view/Miz_warehouses_structure)
env = {}

---Prints the passed string to the dcs.log with a prefix of 'info'.<br>
---If the second parameter is true, a message box will pop up when the logging occurs.
---@param log string
---@param showMessageBox boolean?
function env.info(log, showMessageBox) end

---Prints the passed string to the dcs.log with a prefix of 'warning'.<br>
---If the second parameter is true, a message box will pop up when the logging occurs.
---@param log string
---@param showMessageBox boolean?
function env.warning(log, showMessageBox) end

---Prints the passed string to the dcs.log with a prefix of 'error'.<br>
---If the second parameter is true, a message box will pop up when the logging occurs.
---@param log string
---@param showMessageBox boolean?
function env.error(log, showMessageBox) end

---Sets the value for whether or not an error message box will be displayed if a lua error occurs.<br>
---By default the error message box will appear.
---@param toggle boolean
function env.setErrorMessageBoxEnabled(toggle) end

---Returns a string associated with the passed dictionary key value.<br>
---If the key is not found within the miz the function will return the string that was passed.<br>
---Example usage:<br>
---```
---groupName = env.getValueDictByKey('DictKey_GroupName_5')
---```
---@param value string
---@return string
function env.getValueDictByKey(value) end
