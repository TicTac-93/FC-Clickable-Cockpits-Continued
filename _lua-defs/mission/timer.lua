---@meta

---@alias time number

---@class timer
timer = {}

---Returns the model time in seconds to 3 decimal places.<br>
---This counts time once the simulator loads. So if a mission is paused, the time this function returns still moves forward.<br>
---@return time
function timer.getTime() end

---Returns the mission start time in seconds. Can be used with timer.getAbsTime() to see how much time has passed in the mission.
---@return time
function timer.getTime0() end

---Returns the game world time in seconds relative to time the mission started.<br>
---Will always count up from when the mission started. If the value is above 86400 then it is the next day after the mission started.<br>
---This function is useful in attaining the time of day.<br>
---Assuming a mission started at noon the value returned would be 43200. (12*60*60). Midnight would be 0. Calling this function at 12:00:10 timer.getAbsTime will return 43210.xxx.
---@return time
function timer.getAbsTime() end


---Schedules a function to run at a time in the future. This is a very powerful function.<br>
---The function that is called is expected to return nil or a number which will indicate the next time the function will be rescheduled.<br>
---Use the second argument in that function to retrieve the current time and add the desired amount of delay (expressed in seconds).<br>
---
---Example:
---The following will run a function named "main" 120 seconds from one the code would run.
---```
---timer.scheduleFunction(main, {}, timer.getTime() + 120)
---```
---The following example sets up a repetitive call loop where function CheckStatus is called every 5 seconds or.
---```
---function CheckStatus(ourArgument, time)
--- -- Do things to check, use ourArgument (which is the scheduleFunction's second argument)
--- if ourArgument == 53 and someExternalCondition then
---   -- Keep going
---   return time + 5
--- else
---   -- That's it we're done looping
---   return nil
--- end
---end
---timer.scheduleFunction(CheckStatus, 53, timer.getTime() + 5)
---```
---@param functionToCall function
---@param anyFunctionArguement any
---@param modelTime time
---@return integer functionId
---Return Example: 3
function timer.scheduleFunction(functionToCall, anyFunctionArguement, modelTime) end

---Removes a scheduled function as defined by the functionId from executing. Essentially will "destroy" the function.<br>
---
---Example:
---The following will run a function named "main" 120 seconds from one the code would run.
---```
---local id = timer.scheduleFunction(main, {}, timer.getTime() + 120)
---```
---If further down in the code it was decided to stop main() from running it may look like this.
---```
---if abort == true then  
---   timer.removeFunction(id)
---end
---```
---@param functionId integer
---@return function
---Return Example: none
function timer.removeFunction(functionId) end

---Re-Schedules an already scheduled function to run at a different time in the future.<br>
---
---Example:
---The following will run a function named "main" 120 seconds from one the code would run.
---```
---local id = timer.scheduleFunction(main, {}, timer.getTime() + 120)
---```
---If further down in the code it was decided to run the main() function sooner it could look like this.
---```
---if mustGoFaster == true then  
---   timer.setFunctionTime(id, timer.getTime() + 1)
---end
---```
---@param functionId integer
---@param modelTime time
---@return function
---Return Example: none
function timer.setFunctionTime(functionId, modelTime) end