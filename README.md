Toggle Mouse Acceleration State
===============================

About
-----
This is an AutoHotkey script which allows you to toggle the the
"Enhance pointer precision" option in Windows on or off

How to Use
----------
* Download and install [AutoHotkey](https://www.autohotkey.com/)
* Download and run `toggle_maccel.ahk`. You should (briefly) see a green "H" icon
  task tray / notification area. (NOTE for Windows 10 users: You'll need to enable
  notifications from this and other AutoHotkey scripts to know what the script is doing)
* Operate the script. By default the keys are:
  * <kbd>F12</kbd> Quits/terminates the script
  * <kbd>Pause</kbd> Restarts the script
  * <kbd>F11</kbd> Toggles mouse acceleration on or off.
  
How to Modify
-------------
Labels corresponding to hotkeys will have two colons after their name.
In this script, this will be `Pause::`, `F12::`, and `F11::`. You may substitute
any other key or other input device event.

Examples:
* `^RButton::` activates when you hold the <kbd>Ctrl</kbd> key while right-clicking.
* `NumpadSub::` activates when you push the <kbd>-</kbd> key but only on the numpad (far right on most keyboards)
* `!F1::` activates when you hold the <kbd>Alt</kbd> while pushing <kbd>F1</kbd>

A full listing of possible key (combinations) can be found [here](https://www.autohotkey.com/docs/KeyList.htm).
In order for changes in the script to take place, the script must be reloaded.
By default, <kbd>Pause</kbd> is used for this purpose.

Known Issues
------------
* If mouse acceleration was disabled before the script started, it is unable to
  retrieve and use MouseThreshold1 and MouseThreshold2 values from the registry
  as they're only stored to when you enable it via Windows settings.
* The script should display notifications to inform the user of actions but it
  isn't strictly necessary. You may need to manually enable notifications from
  AutoHotkey to see them. In Windows 10, you'll need to Google how to change
  them since MS likes to move things around, making any links on how to do that
  here possibly useless in the future.
  
More About
-------
My friend asked me if I could cobble together an AHK script to toggle the mouse
acceleration thing in Windows, then he later found 
[this](https://github.com/jan-glx/accelSwitch) tool, which seemed to work well
enough, but wanted to activate it via hotkey. I thought it would've been sufficient
to patch over a registry value to enable it but the system didn't seem to see it.
So he showed me
[this](https://github.com/jan-glx/accelSwitch/blob/master/accelSwitch/accelSwitch.cpp#L55)
chunk of code and I groaned because "yeah, of course it has to be a DllCall() thing".
So I had the time of my life turning the code in the link above to work. Truly,
the only reason my rendition of this function exists on GitHub is because he
told me others might want it and I should do it Do It DO IT DOOOO EEEET

License
-------
Do whatever.
