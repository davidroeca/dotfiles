## The following document outlines how to transfer files and music to/from an iPhone in Linux

[Credit for the file portion goes to samrocketman](https://gist.github.com/samrocketman/70dff6ebb18004fc37dc5e33c259a0fc).

I made some minor changes but it's mostly his awesome gist that I copied.

### File Portion

1. Add the following lines to bashrc
```bash

############################################################
# build for libimobiledevice
############################################################
export PKG_CONFIG_PATH="${HOME}/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
export CPATH="${HOME}/usr/include:${CPATH}"

export MANPATH="${HOME}/usr/share/man:${MANPATH}"

export PATH="${HOME}/usr/bin:${PATH}"

LD_FOR_LIBI="${HOME}/usr/lib"
if [ -z "$LD_LIBRARY_PATH" ];
then
  export LD_LIBRARY_PATH="${LD_FOR_LIBI}"
else
  export LD_LIBRARY_PATH="${LD_FOR_LIBI}:${LD_LIBRARY_PATH}"
fi
```

2. Install the following dependencies:
```bash
sudo apt-get install\
  automake\
  libtool\
  pkg-config\
  libplist-dev\
  libplist++-dev\
  python-dev\
  libssl-dev\
  libusb-1.0-0-dev\
  libfuse-dev
```
3. Clone sources
```bash
cd ~/
mkdir -p ~/usr/src
cd ~/usr/src

git clone https://github.com/libimobiledevice/libusbmuxd.git
git clone https://github.com/libimobiledevice/usbmuxd .git
git clone https://github.com/libimobiledevice/ifuse.git
git clone https://github.com/libimobiledevice/libimobiledevice.git
```
4. Build libusbmuxd
```bash
cd ~/usr/src/libusbmuxd
./autogen.sh --prefix="$HOME/usr"
make && make install
```
5. Build libimobiledevice
```bash
cd ~/usr/src/libimobiledevice
./autogen.sh --prefix="$HOME/usr"
make && make install
```
6. Build usbmuxd
```bash
cd ~/usr/src/usbmuxd
./autogen.sh --prefix="$HOME/usr"
make && make install
```
7. Build ifuse
```bash
cd ~/usr/src/ifuse
./autogen.sh --prefix="$HOME/usr"
make && make install
```
8. Verify
```bash
mkdir -p ~/usr/mnt

type -p ifuse
# /home/david/usr/bin/ifuse

type -p idevicepair
# /home/david/usr/bin/idevicepair
```
9. Pair
```bash
idevicepair pair
# SUCCESS: Paired with device <device_id>
ls ~/usr/mnt/
# Should include iphone files including DCIM, your photo files
```
10. Unmount when done
```bash
fusermount -u ~/usr/mnt
```

With the above completed, iphone mounts should work! Back up your photos, etc.

### Music portion

Apple keeps music access restricted to iTunes. This makes adding music from
linux nearly impossible, or so I thought.

Here's one hack I've found: download a third party music app that supports usb
file storage access.

I'm currently using [flacbox](https://itunes.apple.com/us/app/flacbox-flac-mp3-music-player-audio-streamer/id1097564256?ls=1&mt=8)
as my music player.

Steps to get music into the app:

1. Download app.
2. Retrieve the app's bundleId using the [apple search api](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/).
  * Type the following into a browser `https://itunes.apple.com/search?term=flacbox&country=us&entity=software` and hit enter (or use wget or something)
    * Replace `flacbox` with whichever app you're using
  * You should have received a file, with one or more entries
  * Find your app's entry and search for the `bundleId`. Save this
    * For `flacbox` this is `com.leshko.flap`
3. Now, mount the app's documents directory:
```bash
# create a mount directory somewhere
mkdir -p ~/mnt/appdocuments/

# Mount the documents directory of the app using the bundleid
ifuse --documents com.leshko.flap ~/mnt/appdocuments/

# Now the system should be mounted, so copy a file or two and see if they
# show up in-app

# When finished:
fusermount -u ~/mnt/appdocuments
```

### TODO
I still have yet to figure out how to transfer playlists to an iPhone with this
strategy. It seems that most apps use a database that is not accessible by
users, which is understandable, and text playlists don't seem to be a highly
prioritized feature since most users are on itunes anyway.
