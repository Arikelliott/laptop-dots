#!/bin/bash


# constants
FONT='-*-fixed-*-*-*-*-100-*-*-*-*-*-*-*'
COLOR="green"
DELAY=4
POS="bottom"
ALIGN="center"
BARMOD="percentage"
VOLTXT="Volume"
VOLMUTEDTXT="Muted"
VOLSTEP=5%



# kills an existing osd_cat process
# needed when holding down a key to force repaint of the onscreen message
preKill() {
        killall aosd_cat
}

isMute() {
        VOLMUTE="$(amixer sget Master,0 | grep "Front Left:" | awk '{print $6}')"
}

# gets the actual volume value
getVol() {
        VOL="$(amixer sget Master,0 | grep "Front Left:"|
         awk '{print $5}'|sed -r 's/[][]//g')"
}

# gets the actual volume value and prints is on the screen
# with a percent bar + a percent number
showVol() {
        getVol
        echo $VOL |  aosd_cat -p 1 --fore-color=green --shadow-color=\#006633 \
                                                  --font="Droid Sans Mono 32" \
                                                  --x-offset=50 --y-offset=-0 --transparency=2 \
                                                  --fade-in=0 --fade-out=0 --fade-full=1000
}

# reises the master channel by "VOLSTEP"
volUp() {
        amixer sset Master,0 "$VOLSTEP+"
}

# decreases the master channel by "VOLSTEP"
volDown() {
        amixer sset Master,0 "$VOLSTEP-"
}

# mutes the master channel
volMute() {
        amixer sset Master,0 toggle
}


# main part
preKill

case "$1" in
        "volup")
                volUp
                showVol
                ;;
        "voldown")
                volDown
                showVol
                ;;
        "mute")
                volMute
                showVol
                ;;
        "get")
                getVol
        isMute
        echo "$VOL $VOLMUTE"
                ;;
        *)
                ;;
esac