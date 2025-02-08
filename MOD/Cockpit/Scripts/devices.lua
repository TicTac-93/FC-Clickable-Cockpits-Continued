local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["FCCC_COMMON"] = counter()
devices["FCCC_TEST"] = counter()
devices["FCCC_A10A"] = counter()
