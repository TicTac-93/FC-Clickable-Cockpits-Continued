local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["FCC_COMMON"] = counter()
devices["FCC_TEST"] = counter()
devices["FCC_A10A"] = counter()
