#!/bin/sh
 
# these variables can be overridden on commandline
WORKDIR="$(pwd)"
DESKTOPFILE="$WORKDIR/steam.desktop"
LAUNCHSTEAMDIR=~/Steam
LAUNCHSTEAMPLATFORM=ubuntu12_32
LAUNCHSTEAMBIN=$LAUNCHSTEAMDIR/$LAUNCHSTEAMPLATFORM
LAUNCHSTEAMBOOTSTRAP=$LAUNCHSTEAMDIR/steam.sh
LAUNCHSTEAMBOOTSTRAPFILE="$WORKDIR/bootstraplinux_$LAUNCHSTEAMPLATFORM.tar.xz"
EXELINK=~/.steampath # full path of steam (~/Steam/ubuntu12_32/steam)
STEAMROOTLINK=~/.steam/root # used by games to find the steam install directory (~/Steam)
 
if ! [ -x "$LAUNCHSTEAMBOOTSTRAP" ]; then
        # user does not have steam set up yet, do some sanity checks and set it up
        echo "Setting up steam platform in $LAUNCHSTEAMDIR"
        mkdir -p "$LAUNCHSTEAMDIR"
        cd "$LAUNCHSTEAMDIR"
        tar -xvJf "$LAUNCHSTEAMBOOTSTRAPFILE" ||
                { echo "Failed to extract $LAUNCHSTEAMBOOTSTRAPFILE, aborting installation."
                exit 1 ;}
 
        # create the symlinks in the user's home directory
        [ -e ~/.steam ] || mkdir ~/.steam
       
        rm -f ${EXELINK} && ln -s "${LAUNCHSTEAMBIN}"/steam ${EXELINK}
        rm -f ${STEAMROOTLINK} && ln -s "${LAUNCHSTEAMDIR}" ${STEAMROOTLINK}
 
        # put the Steam icon on the user's desktop
        # try to read ~/.config/user-dirs.dirs to get the current desktop directory
        # http://www.freedesktop.org/wiki/Software/xdg-user-dirs
        test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
        DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
       
        cp "${DESKTOPFILE}" "${DESKTOP_DIR}"
        chmod +x "${DESKTOP_DIR}/steam.desktop"
fi
 
# go to the install directory and run the client
LAUNCHSTEAMDIR=`readlink -e $STEAMROOTLINK`
cd $LAUNCHSTEAMDIR
exec "$LAUNCHSTEAMDIR/steam.sh" $*
