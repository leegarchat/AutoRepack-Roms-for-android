#$1 repack path
#$2 twrp path
#$3 method pathing
dir=$1
	cp extracted/boot.img /data/adb/magisk/
if [ $3 == 'root' ]; then
	cd /data/adb/magisk/
	sh boot_patch.sh boot.img
	mv new-boot.img $dir
elif [ $3 == 'twrp' ]; then
	cp $2 /data/adb/magisk/ramdisk.cpio.patched
	cd /data/adb/magisk/
	./magiskboot --unpack boot.img
	rm ramdisk.cpio 
	mv ramdisk.cpio.patched ramdisk.cpio
	./magiskboot cpio ramdisk.cpio sha1
	./magiskboot cpio ramdisk.cpio restore
	./magiskboot --repack boot.img
	mv new-boot.img $dir
elif [ $3 == 'twrp-root' ]; then
	cp $2 /data/adb/magisk/ramdisk.cpio.patched
	cd /data/adb/magisk/
	./magiskboot --unpack boot.img
	rm ramdisk.cpio
	mv ramdisk.cpio.patched ramdisk.cpio
	./magiskboot cpio ramdisk.cpio sha1
	./magiskboot cpio ramdisk.cpio restore
	./magiskboot --repack boot.img
	rm boot.img && mv new-boot.img boot.img
	sh boot_patch.sh boot.img
	mv new-boot.img $dir
	else
	cp extracted/boot.img $dir
	echo "Original BOOT method"
fi

rm kernel
rm ramdisk.cpio
rm stock_boot.img