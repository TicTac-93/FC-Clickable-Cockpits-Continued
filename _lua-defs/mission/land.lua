---@meta

---@class land
land = {}

---@enum land.SurfaceType
land.SurfaceType = {
  LAND =            1,
  SHALLOW_WATER =   2,
  WATER =           3,
  ROAD =            4,
  RUNWAY =          5,
}

---Returns the distance from sea level (y-axis) of a given vec2 point.
---
---Example:
---The following example will convert a vec3 point lacking y-axis data to a vec3 point at ground level.
---```
---newPoint= {x = point.x, y = land.getHeight({x = point.x, y = point.z}), z= point.z}
---```
---@param vec2 vec2|table
---@return number
---Return Example: 25
function land.getHeight(vec2) end

---Returns the surface height and depth of a point. Useful for checking if the path is deep enough to support a given ship.<br>
---Both values are positive. When checked over water at sea level the first value is always zero.<br>
---When checked over water at altitude, for example the reservoir of the Inguri Dam, the first value is the corresponding altitude the water level is at.<br>
---
---Example:
---The following will return a value of the depth at a trigger zone named thors twins.
---```
---local p = trigger.action.getZone("thors twins").point
---local alt, depth = land.getSurfaceHeightWithSeabed({x = p.x, y = p.z})
---```
---@param vec2 vec2
---@return number, number
---Return Example: 0, 15
function land.getSurfaceHeightWithSeabed(vec2) end

---Returns an enumerator for the surface type at a given point.<br>
---Enumerator is as follows:<br>
---```
---land.SurfaceType
---  LAND             1
---  SHALLOW_WATER    2
---  WATER            3
---  ROAD             4
---  RUNWAY           5
---```
---Example:
---The following takes a number of trigger zones named "surf" with a suffix of 1 to 7 and returns the type of terrain enumerator ID and string to the dcs.log.
---Note that the function accepts a vec2 point so it is needed to be converted from vec2 to vec3.
---Can also be accomplished with a mist function mist.utils.makeVec2
---```
---for i = 1, 7 do
---  local point = trigger.misc.getZone('surface'..i).point
---  point.y = point.z
---  local surfType = land.getSurfaceType(point)
---  for str, ind in pairs(land.SurfaceType) do
---   if ind == surfType then
---    env.info('point ' .. i .. ' is type ' .. surfType .. ' String: ' .. str)			
---   end
---  end
---end
---```
---@param vec2 vec2
---@return land.SurfaceType
---Return Example: 1
function land.getSurfaceType(vec2) end

---Returns the boolean value if there is a terrain intersection via drawing a virtual line from the origin to the destination.<br>
---Used for determining line of sight.<br>
---
---Example:
---The following example outputs text based on the Line of Sight between a stationary target and a moving group that is moving over the ridge towards a target.
---```
---local mover = Unit.getByName('mover'):getPosition().p
---mover.y = mover.y + 3
---local target = Unit.getByName('target'):getPosition().p
---target.y = target.y + 1.8
---trigger.action.outText('Is Visible: ' .. tostring(land.isVisible(mover, target)), 2)
---```
---@param origin vec3
---@param destination vec3
---@return boolean
---Return Example: true or false
function land.isVisible(origin, destination) end

---Returns an intercept point at which a ray drawn from the origin in the passed normalized direction for a specified distance.<br>
---If no intersection found the function will return nil.<br>
---
---Example:
---The following is a sample of a tracked weapon object that is checked periodically and updates the estimated impact point of the weapon.
---```
---for id, wpn in pairs(trackedWeapons) do
---  local wpnData = {}
---  wpnData.pos = wpn:getPosition().p
---  wpnData.dir = wpn:getPosition().x
---  wpn.ip = land.getIP(wpnData.pos, wpnData.dir, 20)
---end
---```
---@param origin vec3
---@param direction vec3
---@param distance number
---@return vec3
---Return Example: vec3
function land.getIP(origin, direction, distance) end

---Returns the X and Y values of a coordinate on the nearest road from the given point.<br>
---NOTE that this function does not use vec2 or vec3. It uses individual values representing a vec2 for x and y.<br>
---Valid road type values: 'roads' and 'railroads'<br>
---
---Example:
---The following returns the closest road to a point.
---```
---local testPoint = trigger.misc.getZone('test').point
---local x, y = land.getClosestPointOnRoads('roads',testPoint.x, testPoint.z)
---```
---@param roadType string
---@param xCoord number
---@param yCoord number
---@return number, number
---Return Example: 233324, 423423
function land.getClosestPointOnRoads(roadType, xCoord, yCoord) end

---Returns a table of points along a that define a route from a starting point to a destination point.<br>
---Returned table is a table of vec2 points indexed numerically from starting point to destination. Table can return a high number of points over a relatively short route. So expect to iterate through a large number of values.<br>
---Roadtype can be 'railroads' or 'roads'<br>
---NOTE!!! A bug exists where the value for railroads is actually `rails`. This is different from the sister function `getClosestPointOnRoads`!<br>
---
---Example:
---The following returns the closest road to a point.
---```
---local testPoint = trigger.misc.getZone('test').point
---local x, y = land.getClosestPointOnRoads('roads',testPoint.x, testPoint.z)
---```
---@param roadType string
---@param xCoord number
---@param yCoord number
---@param destX number
---@param destY number
---@return vec2[]
---Return Example: table
function land.findPathOnRoads(roadType, xCoord, yCoord, destX, destY) end