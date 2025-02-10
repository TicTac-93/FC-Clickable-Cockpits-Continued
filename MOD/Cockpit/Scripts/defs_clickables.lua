-- Defines handler functions for clickable points in the cockpit
-- ie, momentary switch, dial, rotary knob...
--
-- Used by clickabledata.lua, bound as handlers to cockpit elements
-- These are lifted from the Community A-4E mod, and will be largely unchanged due to lack of documentation.
--
-- Return tables seem to be pretty consistent across their range of functions,
-- and it should be possible to re-implement some of these if need be with different behavior.
-- But due to the nature of the FC Clickable mod, I doubt we'll need to add new features.

-- A-4E default button for reference
--
-- function default_button(hint_, device_, command_, arg_, arg_val_, arg_lim_, sound_)
--   local arg_val_ = arg_val_ or 1
--   local arg_lim_ = arg_lim_ or {0, 1}

--   return {
--       class = {class_type.BTN},  -- Presumably an internal EDGE class
--       hint = hint_,  -- Hover hint displayed to the user in-game
--       device = device_,  -- The .lua device to connect to
--       action = {command_},  -- The command value to send to device, calling SetCommand(command_)
--       stop_action = {command_},  -- Unknown
--       arg = {arg_},  -- The animation arg
--       arg_value = {arg_val_},  -- The animation progress, possible values -1 - 1 
--       arg_lim = {arg_lim_},  -- Probably the used range of animation for this element, eg {0, 1}
--       use_release_message = {true},  -- Unknown
--       sound = sound_ and {{sound_}, {sound_}} or nil  -- Sound to play on activation
--   }
-- end

---A simple click handler, useful for push-buttons and other momentary actions.
---@function default_button A simple handler for simple buttons.
---@param hint_ string Text to display when hovering the button
---@param device_ integer .lua device to connect this handler to
---@param command_ integer Command value to send to the device, evaluated by SetCommand()
---@return table
function default_button(hint_, device_, command_)
  local arg_ = 0
  local arg_val_ = 1
  local arg_lim_ = {0, 1}

  return {
      class = {class_type.BTN},  -- Presumably an internal EDGE class
      hint = hint_,  -- Hover hint displayed to the user in-game
      device = device_,  -- The .lua device to connect to
      action = {command_},  -- The command value to send to device, calling SetCommand(command_)
      stop_action = {command_},  -- Unknown
      arg = {arg_},  -- The animation arg
      arg_value = {arg_val_},  -- The animation progress, possible values -1 - 1 
      arg_lim = {arg_lim_},  -- Probably the used range of animation for this element, eg {0, 1}
      use_release_message = {true},  -- Unknown
      sound = nil  -- Sound to play on activation
  }
end
