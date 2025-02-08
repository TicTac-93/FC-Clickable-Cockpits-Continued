---@meta

---@class coord
coord = {}

---Returns a point from latitude, longitude and altitude (optional) in the vec3 format.
---@param latitude number
---@param longitude number
---@param altitude number? -- Optional parameter
---@return vec3
function coord.LLtoLO(latitude, longitude, altitude) end

---Returns multiple values of a given vec3 point in latitude, longitude, and altitude.
---@param vec3 vec3
---@return number latitude, number logitude, number altitude
---Example:
---```
---local curPoint = Unit.getByName('bob'):getPoint()
---local lat, lon, alt = coord.LOtoLL(curPoint)
---trigger.action.outText('Bob is at the raw coordinates of \nLatitude: ' .. lat .. ' \nLongitude: ' .. lon .. '\nAltitude: ' .. alt, 20)
---```
function coord.LOtoLL(vec3) end

---Returns an MGRS table from the latitude and longitude coordinates provided.
---@param latitude number
---@param longitude number
---@return table MGRS
---Return Example: 
---```
---MGRS = {
---  UTMZone = string,
---  MGRSDigraph = string,
---  Easting = number,
---  Northing = number
---}
---```
---Example:
---```
---local grid = coord.LLtoMGRS(coord.LOtoLL(Unit.getByName('bobTheTarget'):getPoint()))
---local s = grid.UTMZone .. ' ' .. grid.MGRSDigraph .. ' ' .. grid.Easting .. ' ' .. grid.Northing
---trigger.action.outText(s, 20)
---```
function coord.LLtoMGRS(latitude, longitude) end

---Returns latitude, longitude, and altitude of a given MGRS coordinates.<br>
---MGRS table format:
---```
---MGRS = {
---  UTMZone = string,
---  MGRSDigraph = string,
---  Easting = number,
---  Northing = number
---}
---```
---Example:
---```
---local mId = 0
---local function id()
---    mId = mId + 1
---    return mId
---end
---local colors = {{0.894, 0.012, 0.012, .8},{1, 0.549, 0, .8},{1, 0.929, 0, .8},{0, 0.502, 0.149, .8},{0.141, 0.251, 0.557, .8},{0.451, 0.161, 0.51, .8}}
---local wMod = {-1, 1, 1, -1}
---local hMod = {1, 1, -1, -1}
---local mgrs = {UTMZone = "37T", MGRSDigraph = "DK",}
---local w = -15000
---local h = -1000
---local startEast = 40000 
---for i = 1, 6 do
---    local startNorth = 29000 + (h * i * 2)
---    local tbl = {-1, id()}
---    for j = 1, 4 do
---        mgrs.Easting = startEast + (w * wMod[j])
---        mgrs.Northing = startNorth + (h * hMod[j])
---        local lat, lon = coord.MGRStoLL(mgrs)
---        local point = coord.LLtoLO(lat, lon, 0)
---        table.insert(tbl,point)
---    end
---    table.insert(tbl, {0, 0, 0, 0} )   
---    table.insert(tbl, colors[i])
---    table.insert(tbl,  math.random(0, 6))
---    trigger.action.quadToAll(unpack(tbl))
---end
---```
---@param MGRS table
---@return number latitude, number longitude, number altitude
function coord.MGRStoLL(MGRS) end