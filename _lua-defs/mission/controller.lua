---@meta

---@class Controller
Controller = {}
---@enum Controller.Detection
Controller.Detection = {
    VISUAL  = 1,
    OPTIC   = 2,
    RADAR   = 4,
    IRST    = 8,
    RWR     = 16,
    DLINK   = 32
}

---Returns true if the controller currently has a task.
---@return boolean
function Controller:hasTask() end

---Pushes the specified task to the front of the tasking queue. If no other tasks are currently active it will function effectively the same as `Controller.setTask()`.<br>
---[Available Tasks](https://wiki.hoggitworld.com/view/DCS_func_pushTask)
---@param task table -- The task to be pushed to the front of the queue.
function Controller:pushTask(task) end

---Removes the top task from the tasking queue.<br>
function Controller:popTask() end

---Resets the current task assigned to the controller.
function Controller:resetTask() end

---Commands are instant actions that require zero time to perform. <br>
---Commands may be used both for control unit/group behavior and control game mechanics. Setting a command will have no impact on active tasking.
---[Available Commands](https://wiki.hoggitworld.com/view/DCS_func_command)
---@param command table -- The command to be set.
function Controller:setCommand(command) end

---Options are a pair of identifier and value.<br>
---Behavior options are global parameters and will affect controller behavior in all tasks it performs.<br>
---Options are executed immediately.<br>
---For example, Rules of Engagement (ROE) are an option that can dictate whether or not a group is currently allowed to attack.<br>
---This option can over-ride tasking to attack specific targets.<br>
---Unlike Tasks and Commands, options are organized by id and value.<br>
---See [Available Options](https://wiki.hoggitworld.com/view/DCS_func_setOption)
---@param optionId enum -- The identifier of the option.
---@param optionValue enum|boolean -- The value of the option.
function Controller:setOption(optionId, optionValue) end

---Sets the controlled group to go the specified speed in meters per second.<br>
---Optional boolean `keep` when set to true will maintain that speed on passing waypoints.<br> 
---If `keep` is not present or false, the controlled group will return to the speed as defined by their route.<br>
---The following will set the tanker to fly slower at a speed an A-10 can achieve:<br>
---```
---Group.getByName("KC-135"):getController():setSpeed(125)
---```
---@param speed number -- The speed in meters per second.
---@param keep boolean? -- Optional. If true, maintains the speed on passing waypoints.
function Controller:setSpeed(speed, keep) end

---Sets the specified task to the units or groups associated with the controller object. Tasks must fit a specified format. <br>
---[Available Tasks](https://wiki.hoggitworld.com/view/DCS_func_setTask)
---@param task table -- The task to be set.
function Controller:setTask(task) end

---Forces the controller to become aware of the specified target, without the controller manually detecting the object itself.<br>
---Applies only to a Unit Controller. Cannot be used at the group level.
---@param target Object
---@param knowType boolean
---@param knowDistance boolean
function Controller:knowTarget(target, knowType, knowDistance) end
