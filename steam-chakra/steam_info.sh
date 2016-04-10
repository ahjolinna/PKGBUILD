#!/usr/bin/env bash
#
# This script it used to display a warning to the user about:
# - chakra not being officially supported by Steam, so ask for helping on the forum
# - a link to the wiki
#
# also a "don't show this message again" checkbox is present
# then start steam normally
#
# if you are a Catalyst user this hack will be used to make steam works for you
# see here https://chakraos.org/wiki/index.php?title=Steam#Missing_Direct_Rendering

kdialog --dontagain steam_warnings_chakra:nofilemsg --msgbox \
"Chakra Linux is not officially supported by Valve.
For help visit the wiki page of Steam https://chakraos.org/wiki/index.php?title=Steam
or ask for help in the forum"

exec /usr/bin/steam %U