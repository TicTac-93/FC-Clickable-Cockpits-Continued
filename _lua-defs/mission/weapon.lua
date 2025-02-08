---@meta

---@class Weapon: CoalitionObject
Weapon = {}

---@enum Weapon.Category
Weapon.Category = {
  SHELL    = 0,
  MISSILE  = 1,
  ROCKET   = 2,
  BOMB     = 3,
}

---@enum Weapon.GuidanceType
Weapon.GuidanceType = {
    INS = 1,
    IR = 2,
    RADAR_ACTIVE = 3,
    RADAR_SEMI_ACTIVE = 4,
    RADAR_PASSIVE = 5,
    TV = 6,
    LASER = 7,
    TELE = 8
}

---@enum Weapon.MissileCategory
Weapon.MissileCategory = {
    AAM = 1,
    SAM = 2,
    BM = 3,
    ANTI_SHIP = 4,
    CRUISE = 5,
    OTHER = 6
}

---@enum Weapon.WarheadType
Weapon.WarheadType = {
    AP = 0,
    HE = 1,
    SHAPED_EXPLOSIVE = 2
}

---@class WeaponDesc: ObjectDesc
---@field category Weapon.Category
---@field warhead WeaponDesc.warhead
---@field missileCategory Weapon.MissileCategory?
---@field guidance Weapon.GuidanceType?

---@class WeaponDesc.warhead
---@field explosiveMass number?
---@field type Weapon.WarheadType?
---@field caliber number?
---@field mass number

---Returns the Unit object that had launched the weapon.
---@return Unit
function Weapon:getLauncher() end

---Returns the target object that the weapon is guiding to.
---@return Object
function Weapon:getTarget() end

---@return WeaponDesc
function Weapon:getDesc() end
