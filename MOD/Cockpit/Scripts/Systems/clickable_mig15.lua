-- This handles behavior specific to the MiG-15bis

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

local self = GetSelf()
local sensor_data = get_base_data()

-- Timestep has to be fairly small, otherwise view adjustments will stutter
local update_time_step = 0.02  -- Update will be called 50 times per second
make_default_activity(update_time_step)

local mig15_mode = 1  -- 1 == Nav, 2 == A/A, 3 == A/G
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
    mig15_mode = 1

  -- Left-click to cycle Cannons selection
  elseif command == device_commands.MM_AA and value > 0 then
    dispatch_action(nil, iCommands.MM_FI0)
    if mig15_mode == 2 then
      dispatch_action(nil, iCommands.W_RippleQuantityCycle)
    end
    mig15_mode = 2

  -- Arm / Disarm bombs
  elseif command == device_commands.MM_AG then
    if mig15_mode ~= 3 then
      dispatch_action(nil, iCommands.MM_Ground)
      mig15_mode = 3
    else
      dispatch_action(nil, iCommands.MM_FI0)
      mig15_mode = 2
    end

  elseif command == device_commands.ADI_RESET then
    if value > 0 then
      -- This command has to be sent to device 25, guess it's not listening for the command code
      dispatch_action(25, iCommands.SYS_ResetADI, 1)
    else
      dispatch_action(25, iCommands.SYS_ResetADI, 0)
    end

  elseif command == device_commands.HUD_SIGHT then
    dispatch_action(nil, iCommands.MM_Gunsight)

  elseif command == device_commands.HUD_FILTER then
    dispatch_action(nil, iCommands.SYS_HUDFilter)

  elseif command == device_commands.RDR_HORZ then
    if value > 0 then
      dispatch_action(nil, iCommands.TGT_WingspanInc)
    else
      dispatch_action(nil, iCommands.TGT_WingspanDec)
    end

  end

end

-- This gets called every update_time_step
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_mig15 INIT")
end

need_to_be_closed = false
