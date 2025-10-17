# Installing Arch Linux

## Steps for installing arch in my pc

### Step 1: Check Internet
```sh
ip a
```

### Step 2: Sync Time
```sh
timedatectl set-ntp true
```

### Step 3: Disk Management and Partitioning
```sh
lsblk
cfdisk /dev/nvme0n1
```
Select partition sizes for EFI, root, and home.

### Step 4: Formatting Disks
```sh
mkfs.fat -F32 /dev/nvme0n1p1    # EFI
mkfs.ext4 /dev/nvme0n1p2        # root
mkfs.ext4 /dev/nvme0n1p3        # home
```

### Step 5: Mounting disks
```sh
mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
mkdir -p /mnt/home
mount /dev/nvme0n1p3 /mnt/home
```

### Step 6: Base Installation
```sh
pacstrap /mnt linux linux-lts linux-zen linux-headers linux-firmware base base-devel efibootmgr networkmanager neovim grub os-prober intel-ucode intel-media-driver vulkan-intel intel-gmmlib sof-firmware
```

### Step 7: Generate fstab
```sh
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
```

### Step 8: arch-chroot
```sh
arch-chroot /mnt
```

### Step 9: System Time
```sh
ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
```

### Step 10: Locale
```sh
nvim /etc/locale.gen
# uncomment en_US.UTF-8 UTF-8
locale-gen
nvim /etc/locale.conf
# add LANG=en_US.UTF-8
```

### Step 11: Hostname
```sh
nvim /etc/hostname
# set hostname
```

### Step 12: Setting up hosts
```sh
nvim /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   <host name>.localdomain  <host name>
```

### Step 13: Root Password
```sh
passwd
```

### Step 14: User Creation
```sh
useradd -mG wheel <user_name>
passwd <user_name>
EDITOR=nvim visudo
# uncomment %wheel ALL=(ALL) ALL
```

### Step 15: Setting up Bootloader
#### GRUB
```sh
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```
#### systemd-boot
```sh
bootctl --path=/boot install
# edit /boot/loader/loader.conf and entries
```

### Step 16: Final
```sh
exit
umount -a
```