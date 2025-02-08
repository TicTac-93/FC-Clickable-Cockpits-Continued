---@meta

---@class AI
AI = {
    Skill = {
        PLAYER = "Player",
        CLIENT = "Client",
        AVERAGE = "Average",
        GOOD = "Good",
        HIGH = "High",
        EXCELLENT = "Excellent"
    },
    Task = {
        OrbitPattern = {
            RACE_TRACK = "Race-Track",
            CIRCLE = "Circle"
        },
        Designation = {
            NO = "No",
            WP = "WP",
            IR_POINTER = "IR-Pointer",
            LASER = "Laser",
            AUTO = "Auto"
        },
        TurnMethod = {
            FLY_OVER_POINT = "Fly Over Point",
            FIN_POINT = "Fin Point"
        },
        VehicleFormation = {
            VEE = "Vee",
            ECHELON_RIGHT = "EchelonR",
            OFF_ROAD = "Off Road",
            RANK = "Rank",
            ECHELON_LEFT = "EchelonL",
            ON_ROAD = "On Road",
            CONE = "Cone",
            DIAMOND = "Diamond"
        },
        AltitudeType = {
            RADIO = "RADIO",
            BARO = "BARO"
        },
        WaypointType = {
            TAKEOFF = "TakeOff",
            TAKEOFF_PARKING = "TakeOffParking",
            TURNING_POINT = "Turning Point",
            TAKEOFF_PARKING_HOT = "TakeOffParkingHot",
            LAND = "Land"
        },
        WeaponExpend = {
            QUARTER = "Quarter",
            TWO = "Two",
            ONE = "One",
            FOUR = "Four",
            HALF = "Half",
            ALL = "All"
        }
    },
    Option = {
        Air = {
            id = {
                ROE = 0,
                REACTION_ON_THREAT = 1,
                RADAR_USING = 3,
                FLARE_USING = 4,
                Formation = 5,
                RTB_ON_BINGO = 6,
                SILENCE = 7,
                RTB_ON_OUT_OF_AMMO = 10,
                ECM_USING = 13,
                PROHIBIT_AA = 14,
                PROHIBIT_JETT = 15,
                PROHIBIT_AB = 16,
                PROHIBIT_AG = 17,
                MISSILE_ATTACK = 18,
                PROHIBIT_WP_PASS_REPORT = 19,
                OPTION_RADIO_USAGE_CONTACT = 21,
                OPTION_RADIO_USAGE_ENGAGE = 22,
                OPTION_RADIO_USAGE_KILL = 23,
                JETT_TANKS_IF_EMPTY = 25,
                FORCED_ATTACK = 26,
                PREFER_VERTICAL = 32
            },
            val = {
                ROE = {
                    WEAPON_FREE = 0,
                    OPEN_FIRE_WEAPON_FREE = 1,
                    OPEN_FIRE = 2,
                    RETURN_FIRE = 3,
                    WEAPON_HOLD = 4
                },
                REACTION_ON_THREAT = {
                    NO_REACTION = 0,
                    PASSIVE_DEFENCE = 1,
                    EVADE_FIRE = 2,
                    BYPASS_AND_ESCAPE = 3,
                    ALLOW_ABORT_MISSION = 4,
                    AAA_EVADE_FIRE = 5
                },
                RADAR_USING = {
                    NEVER = 0,
                    FOR_ATTACK_ONLY = 1,
                    FOR_SEARCH_IF_REQUIRED = 2,
                    FOR_CONTINUOUS_SEARCH = 3
                },
                FLARE_USING = {
                    NEVER = 0,
                    AGAINST_FIRED_MISSILE = 1,
                    WHEN_FLYING_IN_SAM_WEZ = 2,
                    WHEN_FLYING_NEAR_ENEMIES = 3
                },
                ECM_USING = {
                    NEVER_USE = 0,
                    USE_IF_ONLY_LOCK_BY_RADAR = 1,
                    USE_IF_DETECTED_LOCK_BY_RADAR = 2,
                    ALWAYS_USE = 3
                },
                MISSILE_ATTACK = {
                    MAX_RANGE = 0,
                    NEZ_RANGE = 1,
                    HALF_WAY_RMAX_NEZ = 2,
                    TARGET_THREAT_EST = 3,
                    RANDOM_RANGE = 4
                }
            }
        },
        Ground = {
            id = {
                ROE = 0,
                FORMATION = 5,
                DISPERSE_ON_ATTACK = 8,
                ALARM_STATE = 9,
                ENGAGE_AIR_WEAPONS = 20,
                AC_ENGAGEMENT_RANGE_RESTRICTION = 24,
                Restrict_AAA_min = 27,
                Restrict_Targets = 28,
                Restrict_AAA_max = 29
            },
            val = {
                ALARM_STATE = {
                    AUTO = 0,
                    GREEN = 1,
                    RED = 2
                },
                ROE = {
                    OPEN_FIRE = 2,
                    RETURN_FIRE = 3,
                    WEAPON_HOLD = 4
                }
            }
        },
        Naval = {
            id = {
                ROE = 0
            },
            val = {
                ROE = {
                    OPEN_FIRE = 2,
                    RETURN_FIRE = 3,
                    WEAPON_HOLD = 4
                }
            }
        }
    }
}