#!/bin/bash
XDG_ICON_NAME=pycharm-eap
xdg-desktop-menu uninstall jetbrains-pycharm-eap.desktop
xdg-icon-resource uninstall --size 128 $XDG_ICON_NAME

