local mod_ID = "FC Clickable Cockpits Continued"

declare_plugin(mod_ID,
{

	installed			= true,
	dirName				= current_mod_path,
	displayName		= mod_ID,
	shortName			= "FC Clickable",
	fileMenuName	= "FC Clickable",
	version				= "TEST",
	state					= "installed",
	developerName	= "TicTac",
	info					= "A spiritual successor to RedK0d's Clickable Cockpits mod",

	load_immediately	= true,
	binaries					= {},
	Skins = {},
	Options = 
	{
		{
			name			= mod_ID,
			nameId		= "FC CCC",
			dir				= "Options",
		},
	},

})

mount_vfs_model_path(current_mod_path.."/Shapes")

-- I believe this is linking the plugin to each aircraft, as long as their corresponding option is ENABLED
-- Aircraft names must be exactly the same as in their entry.lua MAC_flyable() calls
add_plugin_systems('FC-Clickable_module','*',current_mod_path.."/Cockpit/Scripts/",
	{
	
		["A-10A"]						= {enable_options_key_for_unit = "A10A_enabled"},
		["F-15C"]						= {enable_options_key_for_unit = "F15C_enabled"},
		["J-11A"] 					= {enable_options_key_for_unit = "J11_enabled"},
		["MiG-29A"] 				= {enable_options_key_for_unit = "MIG29A_enabled"},
		["MiG-29G"] 				= {enable_options_key_for_unit = "MIG29G_enabled"},
		["MiG-29S"] 				= {enable_options_key_for_unit = "MIG29S_enabled"},
		["Su-25"] 					= {enable_options_key_for_unit = "SU25A_enabled"},
		["Su-25T"] 					= {enable_options_key_for_unit = "SU25T_enabled"},
		["Su-27"] 					= {enable_options_key_for_unit = "SU27_enabled"},
		["Su-33"] 					= {enable_options_key_for_unit = "SU33_enabled"},
		["F-5E-3_FC"] 			= {enable_options_key_for_unit = "F5EFC_enabled"},
		["F-86F_FC"] 				= {enable_options_key_for_unit = "F86FC_enabled"},
		["MiG-15bis_FC"] 		= {enable_options_key_for_unit = "MIG15FC_enabled"},

	}
)

plugin_done()