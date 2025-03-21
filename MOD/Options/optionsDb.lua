-- Copied this from the A-4E mod
-- No clue what's going on here due to lack of ED documentation, so I'll assume it's all important.

local DbOption  = require('Options.DbOption')
local Range		 	= DbOption.Range
local oms       = require('optionsModsScripts')

-- find the relative location of optionsDb.lua
function script_path() 
    -- remember to strip off the starting @ 
	local luafileloc = debug.getinfo(2, "S").source:sub(2)
	local ti, tj = string.find(luafileloc, "Options")
	local temploc = string.sub(luafileloc, 1, ti-1)
    return temploc
end 

-- find module path
local relativeloc = script_path()
modulelocation = lfs.currentdir().."\\"..relativeloc

local tblCPLocalList = oms.getTblCPLocalList(modulelocation)

return {
  -- These correspond to both the UI elements (A10A_Enabled == A10A_EnabledCheckbox) and to the local
  -- plugin settings (ie, get_plugin_option_value("thisMod", "A10A_Enabled", "local") ) 
	A10A_enabled = DbOption.new():setValue(true):checkbox(),
	F15C_enabled = DbOption.new():setValue(true):checkbox(),
	J11_enabled = DbOption.new():setValue(true):checkbox(),
	MIG29A_enabled = DbOption.new():setValue(true):checkbox(),
	MIG29G_enabled = DbOption.new():setValue(true):checkbox(),
	MIG29S_enabled = DbOption.new():setValue(true):checkbox(),
	SU25A_enabled = DbOption.new():setValue(true):checkbox(),
	SU25T_enabled = DbOption.new():setValue(true):checkbox(),
	SU27_enabled = DbOption.new():setValue(true):checkbox(),
	SU33_enabled = DbOption.new():setValue(true):checkbox(),
	F5EFC_enabled = DbOption.new():setValue(true):checkbox(),
	F86FC_enabled = DbOption.new():setValue(true):checkbox(),
	MIG15FC_enabled = DbOption.new():setValue(true):checkbox(),

}
