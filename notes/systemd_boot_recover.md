- Use cfdisk to drive
- Delete the boot partition and create a new EFI system
- Format EFI partition:
  ```sh
  mkfs.fat -F32 /dev/nvme0n1p1
  ```
- Mount root and home:
  ```sh
  mount /dev/nvme0n1p2 /mnt
  mount /dev/nvme0n1p3 /mnt/home
  ```
- Prepare /boot:
  ```sh
  mkdir -p /mnt/boot
  mount /dev/nvme0n1p1 /mnt/boot
  ```
- Install base system:
  ```sh
  pacstrap /mnt ...
  ```
- Generate fstab:
  ```sh
  genfstab -U /mnt > /mnt/etc/fstab
  ```
- arch-chroot:
  ```sh
  arch-chroot /mnt
  ```
- Install bootctl:
  ```sh
  bootctl --path=/boot install
  ```
- Edit loader configs:
  - `/boot/loader/loader.conf`
  - `/boot/loader/entries/arch.conf`