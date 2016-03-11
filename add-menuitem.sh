#!/bin/bash
#
# Resolve the location of the Pycharm installation.
# This includes resolving any symlinks.
PRG=$0
while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '^.*-> \(.*\)$' 2>/dev/null`
    if expr "$link" : '^/' 2> /dev/null >/dev/null; then
        PRG="$link"
    else
        PRG="`dirname "$PRG"`/$link"
    fi
done

PYCHARM_BIN=`dirname "$PRG"`

# absolutize dir
oldpwd=`pwd`
cd "${PYCHARM_BIN}"
PYCHARM_BIN=`pwd`
cd "${oldpwd}"

ICON_FILE_NAME=pycharm_eap.png
XDG_ICON_NAME=pycharm-eap
TMP_DIR=`mktemp --directory`
DESKTOP_FILE=$TMP_DIR/jetbrains-pycharm-eap.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=PycharmEAP
Type=Application
Categories=Development;IDE;
Terminal=false
StartupNotify=true
StartupWMClass=jetbrains-pycharm
Exec="$PYCHARM_BIN/pycharm.sh" %u
MimeType=x-scheme-handler/$XDG_ICON_NAME;
Icon=$XDG_ICON_NAME.png
EOF

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --size 128 "$PYCHARM_BIN/$ICON_FILE_NAME" $XDG_ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR



