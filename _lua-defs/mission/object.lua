---@meta

---@class Object
---@field id_ integer
Object = {}

---@enum Object.Category
Object.Category = {
    UNIT    = 1,
    WEAPON  = 2,
    STATIC  = 3,
    BASE    = 4,
    SCENERY = 5,
    Cargo   = 6,
}

---@class ObjectDesc
---@field typeName string
---@field displayName string
---@field category Object.Category
---@field attributes table?

---Destroys the object, physically removing it from the game world without creating an event. The object simply disappears.
function Object:destroy() end

---Returns an enumerator of the category for the specific object. <br>
---The enumerator returned is dependent on the category of the object and how the function is called. As of DCS 2.9.2 when this function is called on an Object, Unit, Weapon, or Airbase a 2nd value will be returned which details the object sub-category value. See enumerators Group.Category, Object.Category, and Spot.Category for further reference.
---@return Object.Category, Unit.Category? -- The category and sub-category of the object.
function Object:getCategory() end

---Returns an enumerator of the category for the specific object.<br>
---The enumerator returned is dependent on the category of the object and how the function is called. See enumerators Group.Category, Object.Category, and Spot.Category for further reference.<br>
---Function also works with Unit, Weapon, Static Object, Scenery Object, Airbase. <br>
---Unit.getCategoryEx(obj) will return the unit category.<br>
---obj:getCategoryEx() will return the unit category.<br>
---@return Unit.Category
function Object:getCategoryEx() end

---Return a description table of the given object. Table entries are dependent on the category of object and the sub-categories that may exist within that object type.
---@return table
function Object:getDesc() end

---Returns a number which defines the unique mission id of a given object.
---@return integer
function Object:getID() end

---Returns a string of the name of the object as defined by the mission editor or dynamic spawning functions. <br>
---When run as Object.getName(obj) the value can be different than if run via Unit.getName(obj) or obj:getName(). It appears to be returning the runtime Id.
---@return string
function Object:getName() end

---Returns a vec3 table of the x, y, and z coordinates for the position of the given object in 3D space. <br>
---Coordinates are dependent on the position of the maps origin. In the case of the Caucuses theater, the origin is located in the Crimean region of the map.
---@return vec3
function Object:getPoint() end

---Returns a pos3 table of the objects current position and orientation in 3D space. <br>
---X, Y, Z values are unit vectors defining the objects orientation. Coordinates are dependent on the position of the maps origin. In the case of the Caucuses theater, the origin is located in the Crimean region of the map. Function also works with Unit, Weapon, Static Object, Scenery Object, Airbase.
---@return pos3
function Object:getPosition() end

---Return a string of the object's type name.
---@return string
function Object:getTypeName() end

---Returns a vec3 table of the object's velocity vectors.
---@return vec3
function Object:getVelocity() end

---Returns a boolean value if the object in question has the passed attribute.<br>
---See [Article list of Attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes) for more details.<br>
---Additionally, attributes for each object are defined within their DB lua file. DB files provided on [github](https://github.com/mrSkortch/DCS-miscScripts/tree/master/ObjectDB) for reference.<br>
---Function also works with Unit, Weapon, Static Object, Scenery Object, Airbase.
---@param attribute string -- The attribute to check for.
---@return boolean -- True if the object has the attribute, false otherwise.
function Object:hasAttribute(attribute) end

---Returns a boolean value if the object in question is in the air.
---@return boolean
function Object:inAir() end

---Return a boolean value based on whether the object currently exists in the mission.
---@return boolean
function Object:isExist() end

---@class CoalitionObject: Object
CoalitionObject = {}

---Returns an enumerator that defines the coalition that an object currently belongs to. Function also works with Unit, Static Object, Airbase, Weapon.
---@return coalition.side -- Sides are as follows: 0 = neutral, 1 = red, 2 = blue. Airbase objects can return 3 if the base has red and blue coalition units within the capture perimeter.
function CoalitionObject:getCoalition() end

---Returns an enumerator that defines the country that an object currently belongs to. <br>
---Function also works with Unit, Static Object, Airbase, Weapon.
---@return number -- The country id that the object belongs to. See `country` enums for full listing of countries.
function CoalitionObject:getCountry() end


---@class StaticObject: CoalitionObject
StaticObject = {}

---Returns the static object by its name
---@param name string
---@return StaticObject
function StaticObject.getByName(name) end


---Returns a string of a cargo object's mass in the format ' mass kg'.
---@return string
function StaticObject:getCargoDisplayName() end

---Returns the current value for an animation argument on the external model of the given object.<br>
---Each model animation has an id tied to with different values representing different states of the model.<br>
---Animation arguments can be figured out by opening the respective 3d model in the modelviewer.<br>
---For example, you can determine the rotation and orientation of the barrel of a Tank's cannon by checking its animation arguments.<br>
---More practically, you can determine whether or not a helicopter's doors are open.<br>
---If draw argument value is invalid for the unit in question a value of 0 will be returned.<br>
---@param arg integer
---@return number
function StaticObject:getDrawArgumentValue(arg) end