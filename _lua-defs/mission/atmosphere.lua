---@meta

---@class atmosphere

atmosphere = {}

---Returns a velocity vector of the wind at a specified point.<br>
---Return Example: 
---```
---{ ["y"] = 0, ["x"] = 2.1700058188484, ["z"] = 3.058223998561, }
---```
---Example:
---```
---local point = trigger.misc.getZone('z').point
---local windOverPoint = {}
---for i = 0, 20 do
---    point.y = i * 500
---    windOverPoint[i+1] = atmosphere.getWind(point)
---end
---```
---@param vec3 vec3
---@return vec3
function atmosphere.getWind(vec3) end

---Returns a velocity vector of the wind at a specified point, this time factoring turbulence into the equation.<br>
---Return Example: 
---```
---{ ["y"] = 0.03367256503866, ["x"] = 2.0073974820325, ["z"] = 3.0021618733208, }
---```
---@param vec3 vec3
---@return vec3
function atmosphere.getWindWithTurbulence(vec3) end

---Returns the temperature and pressure at a given point in 3d space. Temperature is returned in Kelvins. Pressure is returned in Pascals.<br>
---Return Example: 
---```
---temperature = 293.15 
---pressure = 101325
---```
---Example:
---```
---local pos = trigger.misc.getZone('posit').point
---for i = 0, 10 do
---    pos.y = (i * 1000)
---    local t, p = atmosphere.getTemperatureAndPressure(pos)
---end
---```
---@param vec3 vec3
---@return number temperature, number pressure
function atmosphere.getTemperatureAndPressure(vec3) end