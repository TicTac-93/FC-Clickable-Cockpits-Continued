local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
if devices == nil then

	devices = {
		FCC_ANIMATOR = counter(),
		FCC_COMMON = counter(),
		FCC_TEST = counter(),
		FCC_A10A = counter(),
		FCC_F5E = counter(),
		FCC_F15C = counter(),
		FCC_F86 = counter(),
		FCC_MIG15 = counter(),
		FCC_MIG29 = counter(),
		FCC_SU25 = counter(),
		FCC_SU25T = counter(),
		FCC_SU27 = counter(),
		FCC_SU33 = counter(),
	}

end
