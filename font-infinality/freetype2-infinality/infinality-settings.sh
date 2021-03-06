#!/bin/bash

###          freetype2-infinality-ultimate settings          ###
###           rev. 0.4.9.0, for freetype2 v.2.6.2            ###
###                                                          ###
###                Copyright (c) 2015 bohoomil               ###
### The MIT License (MIT) http://opensource.org/licenses/MIT ###
###      part of infinality-bundle  http://bohoomil.com      ###


### As of version 2.6.2-1, freetype2-infinality-ultimate comes with
### the "ultimate3" rendering style enabled internally by default.
### It is still possible to use the optional "infinality-settings.sh"
### script to switch between additional built-in rendering schemes and
### create custom ones if necessary. Once modified, "infinality-settings.sh"
### needs to be copied to "/etc/X11/xinit/xinitrc.d/".
###
### There are three basic levels of customization available to a user:
###
### 1. A set of 7 preconfigured styles selectable by name.

### Available styles:
### ultimate1 <> extra sharp
### ultimate2 <> sharper & lighter ultimate
### ultimate3 <> ultimate: well balanced (default)
### ultimate4 <> darker & smoother
### ultimate5 <> darkest & heaviest ("MacIsh")
### osx       <> Apple OS X
### windowsxp <> MS Windows XP
### custom    <> user defined

### If you want to use a style from the list, uncomment the variable below
### and set its name as the value.


#export INFINALITY_FT="ultimate3"


### 2. Additionally, the chosen style can be adjusted by setting custom
###    filter parameters. If you want to use this functionality, uncomment
###    the variable below and enter custom values.


#export INFINALITY_FT_FILTER_PARAMS="08 24 36 24 08"


### 3. Setting the rendering style to "custom" lets you create custom styles
###    from scratch. Uncomment the variables below and enter the values
###    of your choice.


#export INFINALITY_FT_FILTER_PARAMS="08 24 36 24 08"
#export INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH="0"
#export INFINALITY_FT_FRINGE_FILTER_STRENGTH="25"
#export INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="0"
#export INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="25"
#export INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="25"
#export INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH="0"
#export INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="15"
#export INFINALITY_FT_STEM_FITTING_STRENGTH="15"
#export INFINALITY_FT_GAMMA_CORRECTION="0 100"
#export INFINALITY_FT_BRIGHTNESS="0"
#export INFINALITY_FT_CONTRAST="0"
#export INFINALITY_FT_USE_VARIOUS_TWEAKS="true"
#export INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="false"
#export INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="0"
#export INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="0"
#export INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="false"


### Please refer to "infinality-settings-generic" file for detailed explanation
### of customization options and provided examples.

XFT_SETTINGS="
Xft.antialias:  1
Xft.autohint:   0
Xft.dpi:        96
Xft.hinting:    1
Xft.hintstyle:  hintfull
Xft.lcdfilter:  lcddefault
Xft.rgba:       rgb
"

echo "$XFT_SETTINGS" | xrdb -merge > /dev/null 2>&1

### Available styles:
### 1 <> extra sharp
### 2 <> sharper & lighter ultimate
### 3 <> ultimate: well balanced (default)
### 4 <> darker & smoother
### 5 <> darkest & heaviest ("MacIsh")

USE_STYLE="3"

if [ "$USE_STYLE" = "1" ]; then
  export INFINALITY_FT_FILTER_PARAMS="04 22 38 22 04"
elif [ "$USE_STYLE" = "2" ]; then
  export INFINALITY_FT_FILTER_PARAMS="06 22 36 22 06"
elif [ "$USE_STYLE" = "3" ]; then
  export INFINALITY_FT_FILTER_PARAMS="08 24 36 24 08"
elif [ "$USE_STYLE" = "4" ]; then
  export INFINALITY_FT_FILTER_PARAMS="10 25 37 25 10"
elif [ "$USE_STYLE" = "5" ]; then
  export INFINALITY_FT_FILTER_PARAMS="12 28 42 28 12"
fi

export INFINALITY_FT_FRINGE_FILTER_STRENGTH="25"
export INFINALITY_FT_USE_VARIOUS_TWEAKS="true"
export INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="25"
export INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="15"
export INFINALITY_FT_STEM_FITTING_STRENGTH="15"


# vim:ft=sh:
