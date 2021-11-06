#$1 repack path
#$2 twrp path
#$3 method pathing

if [ $3 == root ]; then
	cp extracted/boot.img /data/adb/magisk/
	cd /data/adb/magisk/
	sh boot_patch.sh boot.img
	mv new-boot.img ''$1'/boot/boot.img'
elif [ $3 == "twrp" ]; then
	cp $2 /data/adb/magisk/ramdisk.cpio.patched
	cp extracted/boot.img /data/adb/magisk/
	cd /data/adb/magisk/
	./magiskboot --unpack boot.img
	rm ramdisk.cpio && mv ramdisk.cpio.patched ramdisk.cpio
	./magiskboot cpio ramdisk.cpio sha1
	./magiskboot cpio ramdisk.cpio restore
	./magiskboot --repack boot.img
	mv new-boot.img ''$1'/boot/boot.img'
elif [ $3 == "twrp-root" ]; then
	cp $2 /data/adb/magisk/ramdisk.cpio.patched
	cp extracted/boot.img /data/adb/magisk/
	cd /data/adb/magisk/
	./magiskboot --unpack boot.img
	rm ramdisk.cpio && mv ramdisk.cpio.patched ramdisk.cpio
	./magiskboot cpio ramdisk.cpio sha1
	./magiskboot cpio ramdisk.cpio restore
	./magiskboot --repack boot.img
	rm boot.img && mv new-boot.img boot.img
	sh boot_patch.sh boot.img
	mv new-boot.img ''$1'/boot/boot.img'
	else
	echo "Original BOOT method"
fi
#rm kernel
#rm new-boot.img
#rm ramdisk.cpio
#rm stock_boot.img