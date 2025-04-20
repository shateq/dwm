# wdwm - my go-to dwm build

dwm is an extremely fast, small, and dynamic window manager for X, but it's better when patched.

Check `Patches` file for applied patches.


### Configuration

The configuration of dwm is done by creating a custom config.h
and (re)compiling the source code.

### Installation

> Requirements: In order to build dwm you need the Xlib header files.

Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):

```
make clean install
```

## Running dwm

- **display manager**

Copy [dwm.desktop] file to `/usr/share/xsessions/` directory

- **.xinitrc**

Add the following line to your .xinitrc to start dwm using startx:

```
exec dwm
```

In order to connect dwm to **a specific display**, make sure that
the DISPLAY environment variable is set correctly, e.g.: `DISPLAY=foo.bar:1 exec dwm`
(This will start dwm on display :1 of the host foo.bar.)
