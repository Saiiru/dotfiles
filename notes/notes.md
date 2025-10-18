# Some notes and commands

## Theme and icon for flatpak apps
```sh
sudo flatpak override --system --reset
sudo flatpak override --filesystem=$HOME/.themes/
sudo flatpak override --filesystem=$HOME/.icons/
sudo flatpak override --env=GTK_THEME=Orchis-Grey-Dark-Compact
sudo flatpak override --env=ICON_THEME=Papirus
```

## xfce minimal install
- xfce4-session
- xfce4-panel
- xfwm4
- xfce4-settings
- xfce4-pulseaudio-plugin
- xfce4-cpufreq-plugin
- xfce4-sensors-plugin

## Set default file manager
```sh
xdg-mime default pcmanfm.desktop inode/directory
xdg-user-dirs-update # or xdg-user-dirs-update --force
```

## Artix (runit) exclusive things to do
### basestrap instead of pacstrap
```sh
basestrap /mnt linux linux-firmware linux-headers base base-devel vim runit elogind-runit grub efibootmgr networkmanager networkmanager-runit dosfstools dbus xdg-utils
```
### Services
```sh
sudo ln -s /etc/runit/sv/[service_name] /run/runit/service
```
Enable on first boot: networkmanager, dbus, elogind, lightdm (optional)

### Adding Arch repos
Install:
- artix-archlinux-support
- archlinux-keyring
- archlinux-mirrorlist

Add "extra" repo under all artix repos in `/etc/pacman.conf` and use `rate-mirrors` to populate `/etc/pacman.d/mirrorlist-arch`

## Starting window managers with dbus
```sh
exec dbus-run-session i3
```
Or edit `/etc/lightdm/Xsession` to launch with dbus.

## Power management
```sh
loginclt poweroff
loginclt reboot
loginclt suspend
```

## Laptop settings

### Drivers
- xorg
- intel-media-driver
- vulkan-intel
- intel-gmmlib

### Bluetooth
- blueman
- bluez
- bluez-utils
- gnome-bluetooth

### Brightnessctl
Create `/etc/udev/rules.d/backlight.rules`:
```sh
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
sudo usermod -aG video $USER
```

### Misc
- lshw
- auto-cpufreq
- xss-lock
- betterlockscreen

### Important commands
Check bluetooth:
```sh
bluetoothctl info
```

### Enable touchpad gestures
Create `/etc/X11/xorg.conf.d/90.touchpad.conf`:
```
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
EndSection
```

### Set up environment variables
Edit `/etc/environment`:
```
QT_QPA_PLATFORMTHEME=gtk3
BROWSER=firefox-developer-edition
EDITOR=nvim
```

### sddm theme
Edit `/etc/sddm.conf`:
```
[Theme]
Current=sugar-candy
```

### Splash screen: plymouth
```sh
sudo plymouth-set-default-theme -l
sudo plymouth-set-default-theme -R solar
sudo nvim /etc/mkinitcpio.conf
# add plymouth hook
HOOKS=(base udev plymouth autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
sudo mkinitcpio -p linux
```

### Chromium-based browser flags
Create the following files in .config directory:
- brave-flags.conf
- chrome-flags.conf
- chromium-flags.conf

Contents:
```
--ignore-gpu-blocklist
--enable-zero-copy
--enable-features=VaapiVideoDecodeLinuxGL
--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE
```

### Disable gtk rounded corners
Edit `.config/gtk-version/gtk.css` to remove border-radius.

### Always YouTube theatre mode
Run in browser console:
```js
document.cookie = 'wide=1; expires='+new Date('3099').toUTCString()+'; path=/';
```