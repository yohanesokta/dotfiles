#!/bin/bash

echo "Configuring GNOME settings..."

# 1. Disable "Switch to Application" for Super + 1-9
# and map Super + 1-9 to "Switch to Workspace" 1-9
for i in {1..9}; do
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
done

# 2. Map Super + M to Maximize Window and Super + X to Move Window
# Note: We disable Super + M from opening the calendar/message tray to avoid conflict
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>v']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>m']"
gsettings set org.gnome.desktop.wm.keybindings begin-move "['<Super>x']"

# 3. Disable Super + Left and Super + Right (Tile window left/right)
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "[]"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "[]"

# 3. Map Super + E to launch Dolphin File Manager
KEYPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-dolphin/"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYPATH name 'Dolphin'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYPATH command 'dolphin'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYPATH binding '<Super>e'

# Add custom-dolphin to the custom-keybindings list if not already present
current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
if [[ "$current_bindings" == "@as []" || "$current_bindings" == "[]" ]]; then
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KEYPATH']"
elif [[ "$current_bindings" != *"$KEYPATH"* ]]; then
    # Clean up the list format and append the new path
    new_bindings=$(echo "$current_bindings" | sed "s|\]|, '$KEYPATH'\]|")
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"
fi

# 4. Disable Super + Space from switching input sources to avoid conflict with Ulauncher
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['XF86Keyboard']"

# 5. Map Super + Space to launch Ulauncher
ULAUNCHER_KEYPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-ulauncher/"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ULAUNCHER_KEYPATH name 'Ulauncher'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ULAUNCHER_KEYPATH command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$ULAUNCHER_KEYPATH binding '<Super>space'

# Add custom-ulauncher to the custom-keybindings list if not already present
current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
if [[ "$current_bindings" == "@as []" || "$current_bindings" == "[]" ]]; then
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$ULAUNCHER_KEYPATH']"
elif [[ "$current_bindings" != *"$ULAUNCHER_KEYPATH"* ]]; then
    # Clean up the list format and append the new path
    new_bindings=$(echo "$current_bindings" | sed "s|\]|, '$ULAUNCHER_KEYPATH'\]|")
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"
fi

# 6. Set window button layout (minimize, maximize, close on the right)
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# 7. Set keyboard key repeat rate and delay (delay: 200ms, repeat rate: 80 Hz -> interval: 12ms)
# Note: If you meant a repeat interval of 80ms (slower, ~12 Hz), change 12 to 80.
gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 12

echo "GNOME settings applied successfully."
