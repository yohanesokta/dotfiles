#!/bin/bash

echo "Resetting Super + Left/Right window tiling shortcuts..."

gsettings reset org.gnome.mutter.keybindings toggle-tiled-left
gsettings reset org.gnome.mutter.keybindings toggle-tiled-right

echo "Super + Left/Right tiling shortcuts reset successfully."
