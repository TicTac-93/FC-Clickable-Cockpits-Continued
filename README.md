# Flaming Cliffs: Clickable Cockpits Continued
#### A mod for DCS by TicTac, original CLICKABLE-FC3 mod by RedK0d
#### Licensed under GNU-GPL-3.0

<br>


## About
This mod aims to add basic clickable functionality to all Flaming Cliffs aircraft in DCS, including FC24, with a later goal being to enhance some of it where possible.  PDFs showing clickable points for each aircraft are in the **FC-Clickable-Cockpits-Continued\Doc** folder, and try to be as accurate to the real aircraft as possible. Enhancements range from fixing some selectors that would only scroll one way to adding in unused animations for switches, and will likely come in per-aircraft updates down the line.

Due to the lack of licensing on the original mod, and to my lack of experience with DCS modding, I have rebuilt this from scratch.
**This mod, *Clickable Cockpits Continued* is licensed under GNU-GPL-3.0,** meaning that it is open source and will always be open source.  Anyone is free to copy this and work on it as long as they keep it open, and I hope that the work I've done here can help others learn how to write plugins and mods for DCS -- I'm trying to document the code as thoroughly as I can so that this project might centralize some of the knowledge floating around in the community.  If you're interested in working on the mod, there is a rough description of how it works at the end of this README.

## Installation
- Download the latest Release, either from **[DCS User Files](https://www.digitalcombatsimulator.com/en/files/3347588/)** or from **[GitHub](https://github.com/TicTac-93/FC-Clickable-Cockpits-Continued/releases)**.
- Copy the entire **FC-Clickable-Cockpits-Continued** folder to your **%UserProfile%/Saved Games/DCS/Mods/tech/** directory, NOT to your DCS installation directory.
  - You should now have **Saved Games/DCS/Mods/tech/FC-Clickable-Cockpits-Continued/...** with the mod files inside.
- If installed correctly, you should see an **FC Clickable Cockpits** menu under **Options** > **Special**
  - You don't need to do anything else, the mod will load when you enter a FC aircraft!  See the PDFs in **FC-Clickable-Cockpits-Continued\Doc** for clickable spots.
  - If you want to disable the mod for a specific aircraft, you can **uncheck** it in this options menu.
  - This menu will also show the currently installed version.

## Troubleshooting
- I haven't tested it, but I suspect that this mod will **NOT** work well with the original RedK0d mod.  You should install one or the other, but not both.
- If you're in a supported aircraft and can't click anything:
  - Try pressing your bind for "Force cursor to show" (default LALT+C)
  - Check that the aircraft is enabled in the **FC Clickable Cockpits** Options menu
  - Check the PDF for your aircraft in **FC-Clickable-Cockpits-Continued\Doc** to see what points are clickable.  Some functions are split between LMB and RMB, eg Left Click will RAISE landing gear, while Right Click will LOWER it.
- If you're still having issues, please post on the **[DCS forum thread](https://forum.dcs.world/topic/370597-flaming-cliffs-clickable-cockpits-continued/)**.

## Original CLICKABLE-FC3 mod

RedK0d's original mod was a big help in getting me into DCS and combat flight sims, it bridged a very important gap between the FC aircraft and the much more expensive, and difficult to learn, full-fidelity aircraft that the game is known for. Simply being able to interact with each jet in a more natural way made the game so much more enjoyable to me, and so much easier to get accustomed to. Unfortunately, RedK0d hasn't been active on discord, youtube, or github in a while, and even before the release of FC24 there were some compatibility issues with the mod as ED updates older cockpit models in the game. Because of that, I wanted to take over maintaining the mod.

If you're looking for RedK0d's original mod, you can find the **[github repo here](https://github.com/RedK0d/CLICKABLE-FC3)**, and their **[Gumroad page here](https://redk0d.gumroad.com/l/fvkodo)**.

## Mod Structure

This was my first mod for DCS, and the lack of documentation made it quite difficult.  Doubly so because this mod works as a *plugin* and not as an *aircraft*, which is what most people have experience with.  If you want to work on this, or are working on something similar, this section will help you get your footing.

A plugin, in DCS, is something that can be loaded in on top of an aircraft.  The only official example of this is the Garmin GPS unit, and fundamentally this mod works the same way.  Our clickable model gets loaded into the cockpit after you enter an aircraft, and provides all the points and animations needed for the user to interact with.  The mod's Lua scripts then handle converting clicks into commands for the game, essentially simulating the user pressing a keybind.  The general flow is this:
- DCS loads, the mod is detected and loaded with `entry.lua`.  This sets some metadata for the mod, as well as declaring asset paths (in our case, only one for cockpit shapes) and connecting the mod to aircraft using the `add_plugin_systems()` call.
- The Options menu is loaded using `optionsDb.lua`, which in turn uses `options.dlg` to lay out the menu.  I did not find any documentation on this, and had to infer it from the A-4E mod.
- When an aircraft is loaded, the plugin is loaded with it.  DCS calls `Cockpit/Scripts/device_init.lua` to start this off, where we first double-check that we are in a supported aircraft, and then load a few more scripts:
  - `mainpanel_init.lua`, which loads the model for our clickable points and sets up some globals for the mod
  - `Systems/clickable_animator.lua`, which is responsible for synchronizing animation between the aircraft and our mod (mainly canopy position, but some other elements as well)
  - `Systems/clickable_common.lua`, which handles the basic, shared behavior for all aircraft.  Things like toggling mirrors, canopy, gear, etc that is the same for all
  - Finally, it loads one aircraft-specific script to handle special behaviors for the current aircraft.
- Next, DCS automatically runs `Cockpit/Scripts/clickabledata.lua` which takes named points (connectors) in our mod's models and makes them clickable by the user.  The `elements{}` table is what stores this information to be used by the game, and individual clickable elements are created using the helper functions in `clickable_defs.lua`.
  - The "devices" listed here are the same scripts we created in `device_init.lua`.  We are essentially sending command codes to them, to be processed and then sent to the game. All device scripts are located in `Cockpit/Scripts/Systems/`
  - Quite a few of these elements are in conditional blocks and are only created if the current aircraft matches.  I don't believe there would be any fatal errors if we just tried to create all of them all the time, but it would fill the log with errors.
- Next, any "devices" that we created in `device_init.lua` are initialized.  There are a few specific functions used by these:
  - Presumably right after the aircraft and mod have loaded the rest of their data, each device's `post_initialize()` function is called.
  - Periodically the device's `update()` function is called.  The interval is set by calling a local function `make_default_activity(update_time_step)`, typically during initialization.
  - When a command is sent to the device, `SetCommand(command, value)` is called, where `command` is a code we've assigned and `value` is the value of the button/switch/knob/etc.  In this mod, it is typically -1/0/1, but can theoretically be anything depending on how you configure your clickable elements.
    - Typically, but not in this mod, DCS will use animation args to store the current state of buttons and knobs, allowing you to step through positions on a switch or slowly turn a dial.  Since we are interacting with the existing FC systems, all designed to work with simple keybinds, we do not use this feature.
    - Some commands need to emulate a user holding down a key, for this we use the `update()` function.  When a user clicks and holds on one of these, we repeat the game command every frame until they release.  When the user isn't interacting with one of these buttons, we can exit `update()` early.
- `Cockpit/Scripts/Systems/clickable_animator.lua` is unique, in that it doesn't wait for user input.  Instead this script runs every 0.1s (set using `make_default_activity()`) and synchronizes large animated elements to the main aircraft.  This is a two-part effort:
  - For FC3 aircraft, the gear lever and canopy are synchronized using the "Gauges" in `mainpanel_init.lua`.  These automatically keep our animation in sync with the internal data on canopy and gear lever position.
  - For FC24 aircraft, this does not work and we need to sync them manually.  This is done by reading the current value of the aircraft model's animation using `get_cockpit_draw_argument_value(arg_value)` and then applying it to our model using `mainpanel:set_argument_value(our_arg, arg_value)`.
  - Next we have to tell the clickable elements to update their position in case they've moved, using `:update()` calls on each of them.

That's a high-level overview of how the mod is structured.  Other files include:
- `clickable_defs.lua`: Helper functions for populating the `elements{}` table in `clickabledata.lua`, mostly copied from the A-4E mod.  Helper functions beginning with `fcc_` are simplified and modified for this mod.
- `device_commands.lua`: Two large tables of command codes, the first for internal use (ie the `command` sent to our devices) and the second for interacting with the game (ie, emulating keybinds).  This list is not exhaustive, a more substantial list can be found in `_utilities/iCommand enums/enumSorted.txt`
- `devices.lua`: Enums for our device scripts, for readability.  DCS uses integers to assign each script to a device.