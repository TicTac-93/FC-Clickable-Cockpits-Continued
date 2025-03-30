-- This handles behavior specific to the F-86

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

local self = GetSelf()
local sensor_data = get_base_data()

-- Timestep has to be fairly small, otherwise view adjustments will stutter
local update_time_step = 0.02  -- Update will be called 50 times per second
make_default_activity(update_time_step)

local f86_mode = 1  -- 1 == Nav, 2 == A/A, 3 == A/G
local adi_reset = -1


---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.ENG_TGL then
    if value > 0 then
      dispatch_action(nil, iCommands.SYS_EnginesStart)
    else
      dispatch_action(nil, iCommands.SYS_EnginesStop)
    end

  -- Right-click to turn the sight off and go to Nav mode
  elseif command == device_commands.MM_AA and value < 0 then
    dispatch_action(nil, iCommands.MM_Nav)
    f86_mode = 1

  -- Left-click to cycle A/A Missile and Guns modes
  elseif command == device_commands.MM_AA and value > 0 then
    dispatch_action(nil, iCommands.MM_FI0)
    if f86_mode == 2 then
      dispatch_action(nil, iCommands.W_Cannon)
    end
    f86_mode = 2

  -- Right-click to toggle A/G Guns on and off
  elseif command == device_commands.MM_AG and value < 0 then
    dispatch_action(nil, iCommands.MM_Ground)
    dispatch_action(nil, iCommands.W_Cannon)
    f86_mode = 3

  -- Left-click to cycle A/G weapons
  elseif command == device_commands.MM_AG and value > 0 then
    dispatch_action(nil, iCommands.MM_Ground)
    if f86_mode == 3 then
      dispatch_action(nil, iCommands.W_ChangeWeapon)
    end
    f86_mode = 3

  elseif command == device_commands.ADI_RESET then
    if value > 0 then
      -- This command has to be sent to device 24, guess it's not listening for the command code
      dispatch_action(24, iCommands.SYS_ResetADI, 1)
    else
      dispatch_action(24, iCommands.SYS_ResetADI, 0)
    end

  end

end

-- This gets called every update_time_step
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_f86 INIT")
end

need_to_be_closed = false
