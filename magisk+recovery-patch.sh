dir=$1
twrp=$2
if [ "$twrp" == 1 ]; then
    cp twrp/vashi.cpio /data/adb/magisk/ramdisk.cpio.patched
else
    cp twrp/nebrassy.cpio /data/adb/magisk/ramdisk.cpio.patched
fi
cp extracted/boot.img /data/adb/magisk/
cd /data/adb/magisk/
./magiskboot --unpack boot.img
rm ramdisk.cpio && mv ramdisk.cpio.patched ramdisk.cpio
./magiskboot cpio ramdisk.cpio sha1
./magiskboot cpio ramdisk.cpio restore
./magiskboot --repack boot.img
rm boot.img && mv new-boot.img boot.img
sh boot_patch.sh boot.img
rm ramdisk.cpio
rm stock_boot.img
mv new-boot.img $dir