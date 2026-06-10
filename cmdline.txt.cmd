
setenv cbootargs console=ttyS0,115200 androidboot.presilicon=true firmware_class.path=/etc/firmware root=/dev/mmcblk0p1 rw rootwait rootfstype=ext4 console=ttyS0,115200n8 console=tty0 fbcon=map:0 net.ifnames=0  video=tegrafb earlycon=uart8250,mmio32,0x3100000 nvdumper_reserved=0x2772e0000 gpt rootfs.slot_suffix= usbcore.old_scheme_first=1 tegraid=18.1.2.0.0 maxcpus=6 no_console_suspend boot.slot_suffix= boot.ratchetvalues=0.2031647.1 vpr_resize bl_prof_dataptr=0x10000@0x275840000 sdhci_tegra.en_boot_part_access=1
saveenv
