#!/bin/sh
mkdir /sdcard/RepacksRoms/
mkdir /sdcard/RepacksRoms/step1/
mkdir /sdcard/RepacksRoms/step1/META-INF/
mkdir /sdcard/RepacksRoms/step1/META-INF/com/
mkdir /sdcard/RepacksRoms/step1/META-INF/com/google/
mkdir /sdcard/RepacksRoms/step1/META-INF/com/google/android/
mkdir /sdcard/RepacksRoms/step2/
mkdir /sdcard/RepacksRoms/step2/META-INF/
mkdir /sdcard/RepacksRoms/step2/META-INF/com/
mkdir /sdcard/RepacksRoms/step2/META-INF/com/google/
mkdir /sdcard/RepacksRoms/step2/META-INF/com/google/android/
mkdir /sdcard/RepacksRoms/step2/firmware-update/
mkdir /sdcard/RepacksRoms/step2/boot/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/firmware-update/
mkdir /sdcard/RepacksRoms/step2_dfe_twrp/boot/
cp files/update-binary /sdcard/RepacksRoms/step1/META-INF/com/google/android/update-binary
cp files/update-binary /sdcard/RepacksRoms/step2/META-INF/com/google/android/update-binary
cp files/update-binary /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/update-binary
rm /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
rm /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
rm /sdcard/RepacksRoms/step2/dynamic_partitions_op_list
rm /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
rm /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list
rm /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script

echo "remove_all_groups" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add_group qti_dynamic_partitions_a 9122611200" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add_group qti_dynamic_partitions_b 9122611200" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add system_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add system_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add system_ext_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add system_ext_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add product_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add product_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add vendor_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add vendor_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add odm_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
echo "add odm_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list

echo "remove vendor_a" >> /sdcard/RepacksRoms/step2/dynamic_partitions_op_list
echo "remove vendor_b" >> /sdcard/RepacksRoms/step2/dynamic_partitions_op_list
echo "add vendor_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step2/dynamic_partitions_op_list
echo "add vendor_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step2/dynamic_partitions_op_list

echo "remove vendor_a" >> /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list
echo "remove vendor_b" >> /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list
echo "add vendor_a qti_dynamic_partitions_a" >> /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list
echo "add vendor_b qti_dynamic_partitions_b" >> /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list


echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("**                         **");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("**    Repack rom_step1     **");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("**    Repack rom_step1     **");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("**    Repack rom_step1     **");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("**                         **");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script

echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("**                         **");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("**    Repack rom_step2     **");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("**    Repack rom_step2     **");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("**    Repack rom_step2     **");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("**                         **");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script

echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*                           *");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("* Repack rom_step2_dfe_twrp *");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("* Repack rom_step2_dfe_twrp *");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("* Repack rom_step2_dfe_twrp *");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*                           *");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("*****************************");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script

ImgsC(){
echo 'the '$namimg' is copied' 
if [ -f '/data/local/UnpackerPayload/'$namimg'.img' ]; then
AddS
else
AddS2
fi
}
AddS(){
cp '/data/local/UnpackerPayload/'$namimg'.img' '/sdcard/RepacksRoms/step2/firmware-update/'$namimg'.img'
cp '/data/local/UnpackerPayload/'$namimg'.img' '/sdcard/RepacksRoms/step2_dfe_twrp/firmware-update/'$namimg'.img'
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_a");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_b");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_a");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_b");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
}
AddS2(){
cp 'FW/'$namimg'.img' '/sdcard/RepacksRoms/step2/firmware-update/'$namimg'.img'
cp 'FW/'$namimg'.img' '/sdcard/RepacksRoms/step2_dfe_twrp/firmware-update/'$namimg'.img'
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_a");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_b");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_a");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("firmware-update/'$namimg'.img", "/dev/block/bootdevice/by-name/'$namimg'_b");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
}
echo "copy fw in /sdcard/RepacksRoms/step2/firmware-update/ and /sdcard/RepacksRoms/step2_dfe_twrp/firmware-update/"
echo 'ui_print("Flashing firmware images...");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("Flashing firmware images...");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
namimg=xbl_config && ImgsC
namimg=cmnlib64 && ImgsC
namimg=cmnlib && ImgsC
namimg=bluetooth && ImgsC
namimg=abl && ImgsC
namimg=aop && ImgsC
namimg=imagefv && ImgsC
namimg=keymaster && ImgsC
namimg=modem && ImgsC
namimg=qupfw && ImgsC
namimg=tz && ImgsC
namimg=uefisecapp && ImgsC
namimg=xbl && ImgsC
namimg=dsp && ImgsC
namimg=devcfg && ImgsC
namimg=featenabler && ImgsC
namimg=hyp && ImgsC
DatC(){
FILESIZE=$(stat -c%s '/data/local/UnpackerPayload/'$namdat'.img')
if [ -f '/data/local/UnpackerPayload/'$namdat'.new.dat.br' ] || [ -f '/data/local/UnpackerPayload/'$namdat'.new.dat' ]; then
echo 'the '$namdat' is copied' 
if [ -f '/data/local/UnpackerPayload/'$namdat'.new.dat.br' ]; then
AddD2
return
fi
if [ -f '/data/local/UnpackerPayload/'$namdat'.new.dat' ]; then
AddD
fi
else
echo ''$namdat'.new.dat.br or '$namdat'.new.dat not detected'
fi
}
AddD(){
cp '/data/local/UnpackerPayload/'$namdat'.transfer.list' '/sdcard/RepacksRoms/step1/'$namdat'.transfer.list'
cp '/data/local/UnpackerPayload/'$namdat'.new.dat' '/sdcard/RepacksRoms/step1/'$namdat'.new.dat'
cp '/data/local/UnpackerPayload/'$namdat'.patch.dat' '/sdcard/RepacksRoms/step1/'$namdat'.patch.dat'
echo 'ui_print("Flashing '$namdat' partition...");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 0);' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'block_image_update(map_partition("'$namdat'_a"), package_extract_file("'$namdat'.transfer.list"), "'$namdat'.new.dat", "'$namdat'.patch.dat");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'resize '$namdat'_a '$FILESIZE'' >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
}
AddD2(){
cp '/data/local/UnpackerPayload/'$namdat'.transfer.list' '/sdcard/RepacksRoms/step1/'$namdat'.transfer.list'
cp '/data/local/UnpackerPayload/'$namdat'.new.dat.br' '/sdcard/RepacksRoms/step1/'$namdat'.new.dat.br'
cp '/data/local/UnpackerPayload/'$namdat'.patch.dat' '/sdcard/RepacksRoms/step1/'$namdat'.patch.dat'
echo 'ui_print("Flashing '$namdat' partition...");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 0);' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'block_image_update(map_partition("'$namdat'_a"), package_extract_file("'$namdat'.transfer.list"), "'$namdat'.new.dat.br", "'$namdat'.patch.dat");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'resize '$namdat'_a '$FILESIZE'' >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
}
echo 'assert(update_dynamic_partitions(package_extract_file("dynamic_partitions_op_list")));' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'ui_print("Flashing partition...");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
namdat=odm && DatC
namdat=system && DatC
namdat=product && DatC
namdat=system_ext && DatC
DatCDFE(){
if [ -f '/data/local/UnpackerSystem/'$namdat'.new.dat.br' ] || [ -f '/data/local/UnpackerSystem/'$namdat'.new.dat' ]; then
echo 'the '$namdat' is copied' 
if [ -f '/data/local/UnpackerSystem/'$namdat'.new.dat.br' ]; then
AddD2DFE
return
fi
if [ -f '/data/local/UnpackerSystem/'$namdat'.new.dat' ]; then
AddDDFE
fi
else
echo ''$namdat'.new.dat.br or '$namdat'.new.dat not detected'
fi
}
AddD2DFE(){
cp '/data/local/UnpackerSystem/'$namdat'.transfer.list' '/sdcard/RepacksRoms/step2_dfe_twrp/'$namdat'.transfer.list'
cp '/data/local/UnpackerSystem/'$namdat'.new.dat.br' '/sdcard/RepacksRoms/step2_dfe_twrp/'$namdat'.new.dat.br'
cp '/data/local/UnpackerSystem/'$namdat'.patch.dat' '/sdcard/RepacksRoms/step2_dfe_twrp/'$namdat'.patch.dat'
cp '/data/local/UnpackerPayload/'$namdat'.transfer.list' '/sdcard/RepacksRoms/step2/'$namdat'.transfer.list'
cp '/data/local/UnpackerPayload/'$namdat'.new.dat.br' '/sdcard/RepacksRoms/step2/'$namdat'.new.dat'
cp '/data/local/UnpackerPayload/'$namdat'.patch.dat' '/sdcard/RepacksRoms/step2/'$namdat'.patch.dat'
echo 'ui_print("Flashing '$namdat' partition...");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 0);' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'block_image_update(map_partition("'$namdat'_a"), package_extract_file("'$namdat'.transfer.list"), "'$namdat'.new.dat.br", "'$namdat'.patch.dat");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("Flashing '$namdat' partition...");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 0);' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'block_image_update(map_partition("'$namdat'_a"), package_extract_file("'$namdat'.transfer.list"), "'$namdat'.new.dat.br", "'$namdat'.patch.dat");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'resize '$namdat'_a '$FILESIZE'' >> /sdcard/RepacksRoms/step2/dynamic_partitions_op_list
h=$( expr $FILESIZE + 500000000 ) 
echo 'resize '$namdat'_a '$h'' >> /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list
}
AddDDFE(){
cp '/data/local/UnpackerSystem/'$namdat'.transfer.list' '/sdcard/RepacksRoms/step2_dfe_twrp/'$namdat'.transfer.list'
cp '/data/local/UnpackerSystem/'$namdat'.new.dat' '/sdcard/RepacksRoms/step2_dfe_twrp/'$namdat'.new.dat'
cp '/data/local/UnpackerSystem/'$namdat'.patch.dat' '/sdcard/RepacksRoms/step2_dfe_twrp/'$namdat'.patch.dat'
cp '/data/local/UnpackerPayload/'$namdat'.transfer.list' '/sdcard/RepacksRoms/step2/'$namdat'.transfer.list'
cp '/data/local/UnpackerPayload/'$namdat'.new.dat' '/sdcard/RepacksRoms/step2/'$namdat'.new.dat'
cp '/data/local/UnpackerPayload/'$namdat'.patch.dat' '/sdcard/RepacksRoms/step2/'$namdat'.patch.dat'
echo 'ui_print("Flashing '$namdat' partition...");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 0);' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'block_image_update(map_partition("'$namdat'_a"), package_extract_file("'$namdat'.transfer.list"), "'$namdat'.new.dat", "'$namdat'.patch.dat");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("Flashing '$namdat' partition...");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 0);' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'block_image_update(map_partition("'$namdat'_a"), package_extract_file("'$namdat'.transfer.list"), "'$namdat'.new.dat ", "'$namdat'.patch.dat");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'resize '$namdat'_a '$FILESIZE'' >> /sdcard/RepacksRoms/step2/dynamic_partitions_op_list
h=$( expr $FILESIZE + 500000000 )
echo 'resize '$namdat'_a '$h'' >> /sdcard/RepacksRoms/step2_dfe_twrp/dynamic_partitions_op_list
}
echo 'assert(update_dynamic_partitions(package_extract_file("dynamic_partitions_op_list")));' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'ui_print("Flashing partition...");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'assert(update_dynamic_partitions(package_extract_file("dynamic_partitions_op_list")));' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'ui_print("Flashing partition...");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
namdat="vendor"
FILESIZE=$(stat -c%s '/data/local/UnpackerPayload/'$namdat'.img')
echo 'resize '$namdat'_a '$FILESIZE'' >> /sdcard/RepacksRoms/step1/dynamic_partitions_op_list
DatCDFE
ImgsB(){
echo 'the '$namimgb' is copied'
if [ -f '/data/local/UnpackerPayload/'$namimgb'.img' ]; then
AddB
fi
}
AddB(){
cp '/data/local/UnpackerPayload/'$namimgb'.img' '/sdcard/RepacksRoms/step2_dfe_twrp/boot/'$namimgb'.img'
cp '/data/local/UnpackerPayload/'$namimgb'.img' '/sdcard/RepacksRoms/step2/boot/'$namimgb'.img'
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_a");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_b");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_a");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_b");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
}
namimgb=vendor_boot && ImgsB
namimgb=vbmeta && ImgsB
namimgb=vbmeta_system && ImgsB
namimgb=dtbo && ImgsB
magisk_twrpN(){
cp TWRPN/ramdisk.cpio.gz /data/adb/magisk/
cp /data/local/UnpackerPayload/boot.img /data/adb/magisk/
cp '/data/local/UnpackerPayload/'$namimgb'.img' '/sdcard/RepacksRoms/step2/boot/'$namimgb'.img'
cd /data/adb/magisk/
./magiskboot --unpack boot.img
rm ramdisk.cpio
gzip -d ramdisk.cpio.gz
./magiskboot cpio ramdisk.cpio sha1
./magiskboot cpio ramdisk.cpio restore
./magiskboot --repack boot.img
mv new-boot.img twrp.img
sh boot_patch.sh twrp.img
rm boot.img
rm kernel
rm twrp.img
rm ramdisk.cpio
rm stock_boot.img
mv new-boot.img /sdcard/RepacksRoms/step2_dfe_twrp/boot/boot.img
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_a");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_b");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_a");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_b");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
}
magisk_twrpV(){
cp ./TWRPV/ramdisk.cpio.gz /data/adb/magisk/
cp /data/local/UnpackerPayload/boot.img /data/adb/magisk/
cp '/data/local/UnpackerPayload/'$namimgb'.img' '/sdcard/RepacksRoms/step2/boot/'$namimgb'.img'
cd /data/adb/magisk/
./magiskboot --unpack boot.img
rm ramdisk.cpio
gzip -d ramdisk.cpio.gz
./magiskboot cpio ramdisk.cpio sha1
./magiskboot cpio ramdisk.cpio restore
./magiskboot --repack boot.img
mv new-boot.img twrp.img
sh boot_patch.sh twrp.img
rm boot.img
rm kernel
rm twrp.img
rm ramdisk.cpio
rm stock_boot.img
mv new-boot.img /sdcard/RepacksRoms/step2_dfe_twrp/boot/boot.img
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_a");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_b");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_a");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'package_extract_file("boot/'$namimgb'.img", "/dev/block/bootdevice/by-name/'$namimgb'_b");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
}
#namimgb=boot && magisk_twrpV
namimgb=boot && magisk_twrpN
echo 'show_progress(0.100000, 10);' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'run_program("/system/bin/bootctl", "set-active-boot-slot", "0");' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'set_progress(1.000000);' >> /sdcard/RepacksRoms/step1/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 10);' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'run_program("/system/bin/bootctl", "set-active-boot-slot", "0");' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'set_progress(1.000000);' >> /sdcard/RepacksRoms/step2/META-INF/com/google/android/updater-script
echo 'show_progress(0.100000, 10);' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'run_program("/system/bin/bootctl", "set-active-boot-slot", "0");' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script
echo 'set_progress(1.000000);' >> /sdcard/RepacksRoms/step2_dfe_twrp/META-INF/com/google/android/updater-script