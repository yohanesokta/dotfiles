#!/bin/bash

echo "Resetting GNOME settings to defaults..."

# 1. Restore default "Switch to Application" and "Switch to Workspace" for 1-9
for i in {1..9}; do
    gsettings reset org.gnome.shell.keybindings switch-to-application-$i
    gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-$i
done

# 2. Restore default Maximize, Move Window, and Calendar shortcuts
gsettings reset org.gnome.desktop.wm.keybindings maximize
gsettings reset org.gnome.desktop.wm.keybindings begin-move
gsettings reset org.gnome.shell.keybindings toggle-message-tray

# 3. Remove Dolphin custom shortcut
KEYPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-dolphin/"

# Reset the custom keybinding settings
gsettings reset-recursively org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYPATH

# Remove it from the custom-keybindings list
current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
if [[ "$current_bindings" == *"$KEYPATH"* ]]; then
    # Replace our keypath and clean up any potential double commas or trailing commas
    new_bindings=$(echo "$current_bindings" | sed "s|'$KEYPATH',\? \?||g" | sed "s|,\? \?'$KEYPATH'||g" | sed "s|, *\]|\]|g" | sed "s|\[ *,|\[|g")
    # If the list becomes empty, set it to empty list
    if [[ "$new_bindings" == "[]" || "$new_bindings" == "['']" ]]; then
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "@as []"
    else
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"
    fi
fi

# 4. Restore default input source switching shortcut
gsettings reset org.gnome.desktop.wm.keybindings switch-input-source

# 5. Remove Ulauncher custom shortcut
ULAUNCHER_KEYPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-ulauncher/"

# Reset the custom keybinding settings
gsettings reset-recursively org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ULAUNCHER_KEYPATH

# Remove it from the custom-keybindings list
current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
if [[ "$current_bindings" == *"$ULAUNCHER_KEYPATH"* ]]; then
    # Replace our keypath and clean up any potential double commas or trailing commas
    new_bindings=$(echo "$current_bindings" | sed "s|'$ULAUNCHER_KEYPATH',\? \?||g" | sed "s|,\? \?'$ULAUNCHER_KEYPATH'||g" | sed "s|, *\]|\]|g" | sed "s|\[ *,|\[|g")
    # If the list becomes empty, set it to empty list
    if [[ "$new_bindings" == "[]" || "$new_bindings" == "['']" ]]; then
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "@as []"
    else
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"
    fi
fi

# 6. Restore default window button layout
gsettings reset org.gnome.desktop.wm.preferences button-layout

# 7. Restore default keyboard repeat and delay settings
gsettings reset org.gnome.desktop.peripherals.keyboard delay
gsettings reset org.gnome.desktop.peripherals.keyboard repeat-interval

echo "GNOME settings reset successfully."
