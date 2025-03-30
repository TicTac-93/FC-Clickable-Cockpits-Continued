-- This handles behavior specific to the A-10A

dofile(LockOn_Options.script_path.."/Utilities/logging.lua")
dofile(LockOn_Options.script_path.."device_commands.lua")

-- Localization function
local gettext = require("i_18n")
_ = gettext.translate

local self = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.1  -- Update will be called 10 times per second
make_default_activity(update_time_step)

local a10a_ap_mode = 1
local rip_sel_count = 0

---This is called by the elements assigned in clickabledata.lua
---@param command integer device_command code, what was interacted with
---@param value number The current value of the clickable element, specifically the arg tied to it
function SetCommand(command, value)
  FCCLOG.info("Command triggered: " .. command .. ", " .. value)

  if command == device_commands.AP_ARM then
    if value > 0 then
      dispatch_action(nil, iCommands.AP_EAC_Arm)
      print_message_to_user(_("EAC Armed"))
    else
      dispatch_action(nil, iCommands.AP_EAC_Off)
      print_message_to_user(_("EAC Off"))
    end

  elseif command == device_commands.AP_TGL then
    dispatch_action(nil, iCommands.AP_Toggle)

  elseif command == device_commands.AP_MODE then
    if value > 0 and a10a_ap_mode < 2 then
      a10a_ap_mode = a10a_ap_mode + 1
    elseif value < 0 and a10a_ap_mode > 0 then
      a10a_ap_mode = a10a_ap_mode - 1      
    end

    if a10a_ap_mode == 0 then
      dispatch_action(nil, iCommands.AP_AltBankMode)
      print_message_to_user(_("AP Mode: ALT"))
    elseif a10a_ap_mode == 1 then
      dispatch_action(nil, iCommands.AP_AltHdgMode)
      print_message_to_user(_("AP Mode: ALT/HDG"))
    else
      dispatch_action(nil, iCommands.AP_PathMode)
      print_message_to_user(_("AP Mode: PATH"))
    end

  elseif command == device_commands.MM_AG then
    if value > 0 then
      dispatch_action(nil, iCommands.MM_Ground)
    else
      dispatch_action(nil, iCommands.TGT_EOSOnOff)  -- This triggers CCRP Steering in the A-10A
    end

  elseif command == device_commands.WEP_RIP_QTY then
    if value > 0 then
      dispatch_action(nil, iCommands.W_RippleQuantityCycle)
    else
      -- Similar to the F-15C fuel selector, cycle backwards by going forwards
      rip_sel_count = 11
      while rip_sel_count > 0 do
        dispatch_action(nil, iCommands.W_RippleQuantityCycle)
        rip_sel_count = rip_sel_count - 1
      end
    end
  end

end

-- This gets called every update_time_step
function update()
end

-- Called automatically after the cockpit has been initialized, maybe?  Not sure on the exact timing
function post_initialize()
  FCCLOG.info("clickable_a10a INIT")
end

need_to_be_closed = false