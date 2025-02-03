local mod_ID = "FC Clickable Cockpits Continued"

declare_plugin(mod_ID,
{

	installed			= true,
	dirName				= current_mod_path,
	displayName		= _(mod_ID),
	shortName			= _("FC Clickable"),
	fileMenuName	= _("FC Clickable"),
	version				= "TEST",
	state					= "installed",
	developerName	= "TicTac",
	info					= _("A spiritual successor to RedK0d's Clickable Cockpits mod"),

	load_immediately	= true,
	binaries					= {},
	Skins = {},
	Options = 
	{
		{
			name			= _("FC Clickable"),
			nameId		= "FC Clickable",
			dir				= "Options",
			CLSID			= "{FC Clickable Options}"
		},
	},

})

-- plugin setup goes here

log.alert("FC Clickable: Loaded")

plugin_done()