#!/bin/sh
if [ ! -d "/sdcard/Repacks" ]; then
    mkdir /sdcard/Repacks
fi
echo "\e[1;34mPlease select the number of the rom type you want to convert:"
echo -n "\e[1;32m    1) MIUI        "
echo -n "\e[1;32m    2) AOSP        "
echo "\e[1;32m    3) HentaiOS"
echo -n "\e[1;34mMake your pick: \e[1;32m"
read ROMTYPE
find output -maxdepth 5 -type f -delete &> /dev/null
if [ "$ROMTYPE" == "1" ]; then
    echo "\e[1;32mYou chose poorly, repacking for MIUI..."
    OUT="./output/MIUI/rom/"
    OUTFW="./output/MIUI/fw/"
    unzip -o -q bin_payload/MIUI.zip -d output/MIUI/
elif [ "$ROMTYPE" == "2" ]; then
   echo "\e[1;32mYou chose wisely, repacking for AOSP..."
   OUT="./output/AOSP/"
   OUTFW="./output/AOSP/"
   unzip -o -q bin_payload/AOSP.zip -d output/AOSP/
elif [ "$ROMTYPE" == "3" ]; then
   echo "\e[1;32mYou chose... you just chose, repacking for HentaiOS..."
   OUT="./output/HentaiOS/"
   OUTFW="./output/HentaiOS/"
   unzip -o -q bin_payload/HentaiOS.zip -d output/HentaiOS/
else
    echo "\e[1;32mOMAE WA MOU SHINDEIRU\e[0m"
    exit
fi
sleep .5
clear
echo "\e[1;34mPlease select the number of the recovery:"
echo -n "\e[1;32m    1) Vashi        "
echo "\e[1;32m    2) Nebrassy        "
echo -n "\e[1;34mMake your pick: \e[1;32m"
read twrp
if [ "$twrp" == "1" ]; then
    echo "\e[1;32mVashi is picked."
    unzip -o -q bin_payload/MIUI.zip -d output/MIUI/
elif [ "$twrp" == "2" ]; then
    echo "\e[1;32mNebrassy is picked."
else
    echo "\e[1;32mNeither is picked. Going with Vashi as default."
fi
sleep .5
clear
EXTRACTED="./extracted/"
patchpath=""
loop=$(losetup -f)
loop=$(losetup -f)
#find extracted -maxdepth 1 -type f -delete &> /dev/null
echo -e "\e[1;32m -------------------------------------------------------------\e[0m"
echo "\e[1;32m              Extracting images from payload.bin\e[0m"
echo -e "\e[1;32m -------------------------------------------------------------\e[0m"
echo
#python39 bin_payload/extract_payload-master/extract_payload.py /sdcard/payload.bin extracted/
VENDOR=$(du -sb extracted/vendor.img | cut -f1)
length=$(echo -n $VENDOR | wc -m) && length=$(echo $length-2 | bc) && vendorincrement=$(echo 10^$length | bc) && VENDOR=$(echo $VENDOR+$vendorincrement+$vendorincrement | bc)
SYSTEM="$(du -sb extracted/system.img | cut -f1)"
length=$(echo -n $SYSTEM | wc -m) && length=$(echo $length-2 | bc) && increment=$(echo 10^$length | bc) && SYSTEM=$(echo $SYSTEM+$increment | bc)
SYSTEMEXT="$(du -sb extracted/system_ext.img | cut -f1)"
length=$(echo -n $SYSTEMEXT | wc -m) && length=$(echo $length-2 | bc) && increment=$(echo 10^$length | bc) && SYSTEMEXT=$(echo $SYSTEMEXT+$increment | bc)
PRODUCT="$(du -sb extracted/product.img | cut -f1)"
length=$(echo -n $PRODUCT | wc -m) && length=$(echo $length-2 | bc) && increment=$(echo 10^$length | bc) && PRODUCT=$(echo $PRODUCT+$increment | bc)
ODM="$(du -sb extracted/odm.img | cut -f1)"
length=$(echo -n $ODM | wc -m) && length=$(echo $length-2 | bc) && increment=$(echo 10^$length | bc) && ODM=$(echo $ODM+$increment | bc)
if ! case "vendor.img: data" in ($file) false; esac; then
    echo -e "\e[1;34m Mounting vendor.img is possible Patching vendor through mount...\e[0m"
    losetup $loop extracted/vendor.img
    mount -t ext4 $loop /cache/
    patchpath="/cache/"
    echo -e "\e[1;34m Vendor image has temporarily been mounted.\e[0m"
else
    echo -e "\e[1;34m Mounting vendor.img is not possible. Patching vendor through unpack & repack...\e[0m"
    rm -rf tmp/
    img2simg extracted/vendor.img vendor.img
    mkdir tmp && mkdir tmp/vendor
    python39 imgextractor.py vendor.img tmp/
    rm vendor.img && rm vendor.raw.img
    echo -e "\e[1;34m Vendor image has temporarily been extracted.\e[0m"
    patchpath="tmp/vendor/"
fi
if [[ $ROMTYPE == "1" || $ROMTYPE == "3" ]]; then
    SIZE=$(echo $VENDOR+$vendorincrement | bc)
    VENDOR=$(echo $SIZE+$vendorincrement+$vendorincrement | bc)
else
    SIZE=$(echo $VENDOR-$vendorincrement | bc)
fi
sh dfe.sh $patchpath
echo "Repacking vendor image..."
echo $SIZE
make_ext4fs -s -J -T -1 -S ./tmp/config/vendor/vendor_file_contexts -C ./tmp/config/vendor/vendor_fs_config -l $SIZE -a /vendor "$OUT"vendor.img $patchpath
echo -e "\e[1;34m Vendor image has been successfully created.\e[0m"
if [ $patchpath == "/cache/" ]; then
    umount $patchpath
fi
echo -e "\e[1;34m Vendor image is unmounted.\e[0m"
echo "Converting raw image into sparse format."
echo
for file in $(ls -1 extracted/*.img | xargs -n1 basename)
do
    if ! case "$file" in (system.img|product.img|system_ext.img|odm.img) false; esac; then
        echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
        echo "\e[1;34mConverting ${file}...\e[0m"
        echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
        img2simg $EXTRACTED""$file $OUT""$file 4096
        echo -e "\e[1;32m${file} successfully converted.\e[0m"
        continue
    fi
    if ! case "$file" in (vendor_boot.img|dtbo.img) false; esac; then
        if [ "$ROMTYPE" == "1" ]; then 
            cp extracted/$file $OUTFW"boot/"
            continue
        else
            cp extracted/$file $OUT"boot/"
            continue
        fi
    fi
    if [[ $file == "vendor.img" || $file == "boot.img" ]]; then
        continue
    fi
    cp extracted/$file $OUTFW"firmware-update/"
done

echo
echo

for sparse in $(ls -1 $OUT/*.img | xargs -n1 basename)
do
    echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
    echo "\e[1;34mConverting $sparse into ${sparse%.*}.new.dat...\e[0m"
    echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
    python39 img2sdat.py $OUT""$sparse -v 4 -o $OUT -p ${sparse%.*}
    rm $OUT""$sparse
    echo -e "\e[1;32m$sparse has been successfully converted into ${sparse%.*}.new.dat.\e[0m"
    echo
done

if [[ $ROMTYPE == "1" || $ROMTYPE == "3" ]]; then
    for dat in $(ls $OUT""*.new.dat)
    do
        echo -e "\e[1;34m-------------------------------------------------------------\e[0m"
        echo -e "\e[1;34mConverting $dat into ${dat%.*}.br...\e[0m"
        echo -e "\e[1;34m-------------------------------------------------------------\e[0m"
        echo
        brotli -3 -j $dat
        echo -e "\e[1;32m$dat converted into ${dat%.*}.new.dat.br\e[0m"
        echo
    done
fi

echo
echo
echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
echo "\e[1;32m Patching kernel with TWRP and Magisk...\e[0m"
echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
path=$(realpath $OUTFW)
sh magisk+recovery-patch.sh $path"/boot/boot.img" $twrp
echo "\e[1;32m Patch is done. Image is located in $OUTFW\b/boot/ \e[0m"
echo
echo -e "\e[1;32m -------------------------------------------------------------\e[0m"
echo "\e[1;32m            Creating flashable repack rom.\e[0m"
echo -e "\e[1;32m -------------------------------------------------------------\e[0m"
echo
echo "\e[1;34mAdding img sizes in dynamic partition list...\e[0m"
if [ $ROMTYPE == "1" ]; then
    echo "resize system_a $SYSTEM" >> $OUT"/dynamic_partitions_op_list"
    echo "resize system_ext_a $SYSTEMEXT" >> $OUT"/dynamic_partitions_op_list"
    echo "resize vendor_a $VENDOR" >> $OUTFW"/dynamic_partitions_op_list"
    echo "resize product_a $PRODUCT" >>  $OUT"/dynamic_partitions_op_list"
    echo "resize odm_a $ODM" >>  $OUT"/dynamic_partitions_op_list"
elif [ $ROMTYPE == "2" ]; then
    echo "resize system_a $SYSTEM" >> $OUT"/dynamic_partitions_op_list"
    echo "resize system_ext_a $SYSTEMEXT" >> $OUT"/dynamic_partitions_op_list"
    echo "resize vendor_a $VENDOR" >> $OUT"/dynamic_partitions_op_list"
    echo "resize product_a $PRODUCT" >> $OUT"/dynamic_partitions_op_list"
    echo "resize odm_a $ODM" >> $OUT"/dynamic_partitions_op_list"
else
    echo "resize system_a $SYSTEM" >> $OUT"/dynamic_partitions_op_list"
    echo "resize system_ext_a $SYSTEMEXT" >> $OUT"/dynamic_partitions_op_list"
    echo "resize vendor_a $VENDOR" >> $OUT"/dynamic_partitions_op_list"
    echo "resize product_a $PRODUCT" >> $OUT"/dynamic_partitions_op_list"
fi
if [ $ROMTYPE == "1" ]; then
    mv output/MIUI/rom/vendor* $OUTFW
    echo
    echo "\e[1;34mPacking MIUI firmware files...\e[0m"
    echo
    cd output/MIUI/fw
    zip -1 -r META-INF *
    mv *.zip Miui-Step2.zip
    echo "\e[1;34mPacking MIUI rom files...\e[0m"
    echo
    cd ../rom
    zip -1 -r META-INF *
    mv *.zip Miui-Step1.zip
    mv $(find ../ -name "*.zip") /sdcard/Repacks/
else
    echo "\e[1;34mPacking rom files...\e[0m"
    echo
    cd $OUT
    zip -1 -r META-INF *
    mv *.zip AOSP-repacked.zip
    mv $(find . -name "*.zip") /sdcard/Repacks/
fi
echo "\e[1;32mYour repacked rom is ready to flash. You can find it in /sdcard/Repacks/ \e[0m"