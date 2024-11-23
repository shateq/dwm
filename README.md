# dwm - dynamic window manager

dwm is an extremely fast, small, and dynamic window manager for X.
This is my spin of it, I left [default config](config.def.h) so as to make this build more reusable.

# Patches

All patches are in [patches](patches) directory, wherein we keep them.

- pertag, apply layout per tag
- attachaside, new clients won't replace master
- [statuscmd](dwmblocks) and dwmblocks paired with cool-autostart
- [shiftview](shiftview.c), cycle through tags
- vanitygaps, very much useless, but VISUALS

### Configuration

Check [config.h](config.h) for my bindings.
Yes, the configuration of dwm is done by editing code, gotcha!

## Installation

- In order to build dwm you need the Xlib header files.

Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):

    make clean install

### Running dwm

Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that
the DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

In order to display status info in the bar, we use [dwmblocks](dwmblocks)-clone in this repo.
