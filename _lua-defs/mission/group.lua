---@meta

---@class Group
---@field id_ integer
Group = {}

---@enum Group.Category
Group.Category = {
    AIRPLANE      = 0,
    HELICOPTER    = 1,
    GROUND        = 2,
    SHIP          = 3,
    TRAIN         = 4
}

---Returns the group object by its name
---@param name string
---@return Group
function Group.getByName(name) end

---Activates the group if the group has a delayed start or late activation. 
function Group:activate() end

---Destroys the group, physically removing it from the game world without creating an event. The entire group simply disappears.
function Group:destroy() end

---Sets the passed group radar emitters on or off. Can be used on sam sites for example to shut down the radar without setting AI off or changing the alarm state.
---@param setting boolean
function Group:enableEmission(setting) end

---Returns an enumerator of the category for the specific group. <br>
---See enumerators Group.Category for further reference.
---@return Group.Category -- The category and sub-category of the object.
function Group:getCategory() end

---Returns an enumerator that defines the coalition that a group belongs to. Function also works with Unit, Static Object, Airbase, Weapon.
---@return coalition.side -- Sides are as follows: 0 = neutral, 1 = red, 2 = blue.
function Group:getCoalition() end

---Returns the controller of the specified object. <br>
---Ships and ground units can only be controlled at a group level. Airplanes and helicopters can be controlled at both a group and unit level.
---@return Controller
function Group:getController() end

---Returns an enumerator that defines the country that a group belongs to. <br>
---Function also works with Unit, Static Object, Airbase, Weapon.
---@return country.id -- The country id that the group belongs to. See `country` enums for full listing of countries.
function Group:getCountry() end

---Returns a number which defines the unique mission id of a given group.
---@return integer
function Group:getID() end

---Returns the initial size of the group as defined in the mission editor or if spawned via function. This number will not change as units are destroyed.
---@return number
function Group:getInitialSize() end

---Returns a string of the name of the group as defined by the mission editor or dynamic spawning functions. 
---@return string
function Group:getName() end

---Returns the current size of the group. <br>
---This value will change as units are destroyed. Can be used in combination with getUnit to not accidentally use too big a value for that function, or to access the last unit in the group.
---@return number
function Group:getSize() end

---Returns the unit object of the specified unitIndex within the group. If the index is not valid, this function will return nil. 
---@param UnitIndex number -- The index of the unit within the group.
---@return Unit
function Group:getUnit(UnitIndex) end

---Returns a table of unit objects indexed in unit order. Useful for getting unit specific data for every unit in the group.
---@return Unit[] -- A table of Unit objects.
function Group:getUnits() end

---Return a boolean value based on whether the group currently exists in the mission.
---@return boolean
function Group:isExist() end