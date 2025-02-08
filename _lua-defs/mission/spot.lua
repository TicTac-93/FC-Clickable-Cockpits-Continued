---@meta
---@class Spot
Spot = {}

---Creates an infrared ray emanating from the given object to a point in 3d space. Can be seen with night vision goggles.<br>
---localRef is technically an optional variable, however the function's format requires an entry to be made. If not used, simply replace with nil.<br>
---Example:
---```
---local jtac = Unit.getByName('jtacBob')
---local target = Unit.getByName('BMPAirDefenseSystemGroup1_unit1'):getPoint()
---local ray = Spot.createInfraRed(jtac, {x = 0, y = 1, z = 0}, target)
---```
---@param source Object -- The object from which the infrared ray emanates.
---@param localRef vec3? -- The local reference point. If not used, replace with nil.
---@param point vec3 -- The point in 3D space where the infrared ray ends.
---@return Spot Object
function Spot.createInfraRed(source, localRef, point) end

---Creates a laser ray emanating from the given object to a point in 3d space.<br>
---localRef is technically an optional variable, however the function's format requires an entry to be made. If not used, simply replace with nil.<br>
---If optional variable laserCode is not present the beam will automatically be set to an IR beam. If laserCode is specified, the beam is a laser which can be used to guide laser guided bombs.<br>
---Laser code is any 4 digit number between 1111 and 1788.<br>
---Example:
---```
---local jtac = Unit.getByName('jtacBob')
---local target = Unit.getByName('BMPAirDefenseSystemGroup1_unit1'):getPoint()
---local ray = Spot.createLaser(jtac, {x = 0, y = 1, z = 0}, target, 1337)
---```
---@param source Object -- The object from which the laser ray emanates.
---@param localRef vec3? -- The local reference point. If not used, replace with nil.
---@param point vec3 -- The point in 3D space where the laser ray ends.
---@param laseCode integer? -- The laser code for guiding laser guided bombs. Optional.
---@return Spot Object
function Spot.createLaser(source, localRef, point, laseCode) end

---Sets the destination point from which the source of the spot is drawn toward.<br>
---Example:
---```
---local jtac = Unit.getByName('jtacBob')
---local target = Unit.getByName('BMPAirDefenseSystemGroup1_unit1')
---local ray = Spot.createLaser(jtac, {x = 0, y = 1, z = 0}, target:getPoint(), 1337)
---local function updateRay()
---    if Object.isExist(target) then
---        ray:setPoint(target:getPoint())
---        timer.scheduleFunction(updateRay, {}, timer.getTime() + 0.5)
---    else
---        ray:destroy()
---    end
---end
---timer.scheduleFunction(updateRay, {}, timer.getTime() + 0.5)
---```
---@param vec3 table -- The destination point in 3D space.
function Spot:setPoint(vec3) end

---Returns the laser code used for laser designation tracking.<br>
---The default and maximum value is 1688.<br>
---Example:
---```
---local jtac = Unit.getByName('jtacBob')
---local target = Unit.getByName('BMPAirDefenseSystemGroup1_unit1')
---local ray = Spot.createLaser(jtac, {x = 0, y = 1, z = 0}, target:getPoint(), 1337)
---local laserCode = ray:getCode()
---print("Laser code is: " .. laserCode)
---```
---@return number
function Spot:getCode() end

---Sets the laser code for the spot. If no code is provided, a default value is used.<br>
---Example:
---```
---local ray = Spot.createLaser(jtac, {x = 0, y = 1, z = 0}, Unit.getByName('target'):getPoint(), 1337)
---local function changeCodePlease(code)
---    local c = code or 1234 -- Default code if none provided
---    ray:setCode(c)
---end
---```
---@param code number -- The laser code to set. Default and max value is 1688.
function Spot:setCode(code) end