local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
if devices == nil then

	devices = {
		FCC_COMMON = counter(),
		FCC_TEST = counter(),
		FCC_A10A = counter(),
	}
	
end
