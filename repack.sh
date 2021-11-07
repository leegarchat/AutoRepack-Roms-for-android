#!/bin/sh

EXTRACTED="./extracted/"
OUT=""
dfe=""
method=""

unpack_payload(){
    rm -rf extracted/*
    rm -rf output/*
    echo -e "\e[1;32m -------------------------------------------------------------\e[0m"
    echo "\e[1;32m              Extracting images from payload.bin\e[0m"
    echo -e "\e[1;32m -------------------------------------------------------------\e[0m"
    python39 bin_payload/extract_payload-master/extract_payload.py /sdcard/payload.bin extracted/
}

vendor_dfe(){
    rm -rf tmp/vendor/ & rm -rf tmp/config/
    img2simg extracted/vendor.img vendor.img
    mkdir tmp && mkdir tmp/vendor
    python39 imgextractor.py vendor.img tmp/
    rm vendor.img && rm vendor.raw.img
    sh dfe.sh tmp/vendor/
    FILESIZE=$(stat -c%s extracted/vendor.img)
    vendor_size=$( expr $FILESIZE + 3500000)
    make_ext4fs -s -J -T -1 -S ./tmp/config/vendor/vendor_file_contexts -C ./tmp/config/vendor/vendor_fs_config -l $vendor_size -a /vendor "$1"/vendor.img tmp/vendor
    echo 'resize vendor_a '$vendor_size'' >> ''$1'/dynamic_partitions_op_list'
}

filezise(){
    FILESIZE=$(stat -c%s 'extracted/'$prt'.img')
}
convert_img(){
    for file in $(ls -1 extracted/*.img | xargs -n1 basename)  
    do
        if ! case "$file" in ($2.img|$3.img|$4.img|$5.img|$6.img|$7.img) false; esac; then
            echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
            echo "\e[1;34mConverting ${file}...\e[0m"
            echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
            FILESIZE=$(stat -c%s extracted/$file)
            echo 'resize '$file'_a '$FILESIZE'' >> ''$1'/dynamic_partitions_op_list'
            sed -i 's|.img||' ''$1'/dynamic_partitions_op_list'
            img2simg ''$EXTRACTED''$file'' ''$1'/'$file'' 4096
            echo -e "\e[1;32m${file} successfully converted.\e[0m"
            continue
        fi
    done
        if [ -f  $1/odm.new.dat ] || [ -f $1/odm.new.dat.br ]; then
        echo 'fine'
        else
        sed -i '/add odm_a qti_dynamic_partitions_a/d' ''$1'/dynamic_partitions_op_list'
        sed -i '/add odm_b qti_dynamic_partitions_b/d' ''$1'/dynamic_partitions_op_list'
        fi
}    
add_scrip_info(){
    echo 'ui_print("*****************************");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("*****************************");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("*****************************");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("                         ");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("     --  '$1'        ");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("     --  '$2'        ");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("     --  REPACK        ");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("                         ");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("*****************************");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("*****************************");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("*****************************");' >> $OUT/META-INF/com/google/android/updater-script
}           
move_img(){
    img_fw_add=($2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20})
    nam=0
    for file in $(ls -1 extracted/*.img | xargs -n1 basename)  
    do
        if ! case "$file" in ($2.img|$3.img|$4.img|$5.img|$6.img|$7.img|$8.img|$9.img|${10}.img|${11}.img|${12}.img|${13}.img|${14}.img|${15}.img|${16}.img|${17}.img|${18}.img|${19}.img|${20}.img) false; esac; then
            fileimg=$file
            filenonimg=${fileimg::${#fileimg}-4}
            img_del_arr[$nam]=$filenonimg
            nam=$( expr $nam + 1)
            cp extracted/$file ''$OUT'/'$1/''
            echo 'package_extract_file("'$1'/'$file'", "/dev/block/bootdevice/by-name/'$file'_a");' >> $OUT/META-INF/com/google/android/updater-script && sed -i 's|img._a|_a|' ''$OUT'/META-INF/com/google/android/updater-script'
            echo 'package_extract_file("'$1'/'$file'", "/dev/block/bootdevice/by-name/'$file'_b");' >> $OUT/META-INF/com/google/android/updater-script && sed -i 's|img._b|_b|' ''$OUT'/META-INF/com/google/android/updater-script'
            continue 
        fi
    done
    for del in ${img_del_arr[@]}
    do
        img_fw_add=('${img_fw_add[@]/'$del'}')
    done
    for add in ${img_fw_add[@]}
    do
        if [ -f 'files/firmware-update/'$add'.img' ]; then
        cp 'files/firmware-update/'$add'.img' ''$OUT'/'$1'/'$add'.img'
        echo 'package_extract_file("'$1'/'$add'.img", "/dev/block/bootdevice/by-name/'$add'_a");' >> $OUT/META-INF/com/google/android/updater-script
        echo 'package_extract_file("'$1'/'$add'.img", "/dev/block/bootdevice/by-name/'$add'_b");' >> $OUT/META-INF/com/google/android/updater-script
        continue
        fi
    done
}
convert_img_dat(){
    for sparse in $(ls -1 $1/*.img | xargs -n1 basename) 
    do
        echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
        echo "\e[1;34mConverting $sparse into ${sparse%.*}.new.dat...\e[0m"
        echo -e "\e[1;32m-------------------------------------------------------------\e[0m"
        python39 img2sdat.py ''$1'/'$sparse'' -v 4 -o $1/ -p ${sparse%.*} && echo -e "\e[1;32m$sparse has been successfully converted into ${sparse%.*}.new.dat.\e[0m"
        rm ''$1'/'$sparse''
    done
}
addscrip_dat(){
    echo 'assert(update_dynamic_partitions(package_extract_file("dynamic_partitions_op_list")));' >> $OUT/META-INF/com/google/android/updater-script
    echo 'ui_print("Flashing partition...");' >> $OUT/META-INF/com/google/android/updater-script  
    for file in $(ls -1 $OUT/*.new.* | xargs -n1 basename)  
    do
        echo 'ui_print("Flashing '$file' partition...");' >> ''$OUT'/META-INF/com/google/android/updater-script'
        echo 'show_progress(0.100000, 0);' >> ''$OUT'/META-INF/com/google/android/updater-script'
        echo 'block_image_update(map_partition("'$file'_a"), package_extract_file("'$file'.transfer.list"), "'$file'", "'$file'.patch.dat");' >> ''$OUT'/META-INF/com/google/android/updater-script'
        sed -i 's|.new.dat partition| partition|' ''$OUT'/META-INF/com/google/android/updater-script' && sed -i 's|.new.dat_a|_a|' ''$OUT'/META-INF/com/google/android/updater-script' && sed -i 's|.new.dat.transfer.list|.transfer.list|' ''$OUT'/META-INF/com/google/android/updater-script' && sed -i 's|.new.dat.patch.dat|.patch.dat|' ''$OUT'/META-INF/com/google/android/updater-script'
        sed -i 's|.new.dat.br partition| partition|' ''$OUT'/META-INF/com/google/android/updater-script' && sed -i 's|.new.dat.br_a|_a|' ''$OUT'/META-INF/com/google/android/updater-script' && sed -i 's|.new.dat.br.transfer.list|.transfer.list|' ''$OUT'/META-INF/com/google/android/updater-script' && sed -i 's|.new.dat.br.patch.dat|.patch.dat|' ''$OUT'/META-INF/com/google/android/updater-script'
        continue
    done
}
convert_dat_br(){    
    for dat in $(ls $OUT/*.new.dat) 
    do
        echo -e "\e[1;34m-------------------------------------------------------------\e[0m"
        echo -e "\e[1;34mConverting $dat into ${dat%.*}.br...\e[0m"
        echo -e "\e[1;34m-------------------------------------------------------------\e[0m"
        brotli -$1 -j $dat && echo -e "\e[1;32m$dat converted into ${dat%.*}.new.dat.br\e[0m"
    done
}


lastscript_add(){
    echo 'package_extract_file("'boot'/'boot'.img", "/dev/block/bootdevice/by-name/'boot'_a");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'package_extract_file("'boot'/'boot'.img", "/dev/block/bootdevice/by-name/'boot'_b");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'run_program("/system/bin/bootctl", "set-active-boot-slot", "0");' >> $OUT/META-INF/com/google/android/updater-script
    echo 'set_progress(1.000000);' >> $OUT/META-INF/com/google/android/updater-script
}
addqti(){
    cp files/update-binary $OUT/META-INF/com/google/android/
    rm $OUT/META-INF/com/google/android/updater-script
    rm ''$OUT'/dynamic_partitions_op_list'
    if [ $1 == AOSP ] || [ $1 == MIUI ]; then
        echo "remove_all_groups" >> $OUT/dynamic_partitions_op_list
        echo "add_group qti_dynamic_partitions_a 9122611200" >> $OUT/dynamic_partitions_op_list
        echo "add_group qti_dynamic_partitions_b 9122611200" >> $OUT/dynamic_partitions_op_list
        echo "add system_a qti_dynamic_partitions_a" >> $OUT/dynamic_partitions_op_list
        echo "add system_b qti_dynamic_partitions_b" >> $OUT/dynamic_partitions_op_list
        echo "add system_ext_a qti_dynamic_partitions_a" >> $OUT/dynamic_partitions_op_list
        echo "add system_ext_b qti_dynamic_partitions_b" >> ./$OUT/dynamic_partitions_op_list
        echo "add product_a qti_dynamic_partitions_a" >> ./$OUT/dynamic_partitions_op_list
        echo "add product_b qti_dynamic_partitions_b" >> ./$OUT/dynamic_partitions_op_list
        echo "add odm_a qti_dynamic_partitions_a" >> ./$OUT/dynamic_partitions_op_list
        echo "add odm_b qti_dynamic_partitions_b" >> ./$OUT/dynamic_partitions_op_list
    fi
    if [ $1 == MIUI2 ]; then
        echo "remove vendor_a" >> ./$OUT/dynamic_partitions_op_list
        echo "remove vendor_b" >> ./$OUT/dynamic_partitions_op_list
    fi
    if [ $1 == AOSP ] || [ $1 == MIUI2 ]; then 
        echo "add vendor_a qti_dynamic_partitions_a" >> ./$OUT/dynamic_partitions_op_list
        echo "add vendor_b qti_dynamic_partitions_b" >> ./$OUT/dynamic_partitions_op_list
    fi
}
start_aosp(){
    twrp=$1
    method=$2
    DFE=$3
    OUT="output/aosp"
    unpack_payload
    mkdir output mkdir output/aosp && mkdir output/aosp/META-INF && mkdir output/aosp/META-INF/com && mkdir output/aosp/META-INF/com/google && mkdir output/aosp/META-INF/com/google/android && mkdir output/aosp/boot && mkdir output/aosp/firmware-update
    addqti AOSP
    convert_img $OUT odm system system_ext product
    if [ $DFE == dfe_true ]; then
        vendor_dfe $OUT
        else
        convert_img $OUT vendor
    fi
    convert_img_dat $OUT
    add_scrip_info 'NameRom' '#### - include'
    move_img firmware-update xbl_config cmnlib64 cmnlib bluetooth abl aop imagefv keymaster modem qupfw tz uefisecapp xbl dsp devcfg featenabler hyp
    addscrip_dat
    move_img boot vendor_boot vbmeta vbmeta_system dtbo
    path=$(realpath './'$OUT'/'boot/boot.img'') && sh twrp-magisk.sh $path $twrp $method
    lastscript_add
    #size=$1, OUT=$2, path_OUT=$3, name=$4:
    sh ziping.sh 3 $OUT '/sdcard' 'aosprom_'$method'_'$DFE''
}

quick_aosp(){
    clear
    echo "\e[1;31mWhat ROM are you repacking?:"
	echo "\e[1;32m 1) Other"
	echo "\e[1;32m 2) Hentai OS"
	echo "\e[1;32m 3) Return menu"
	echo "\e[1;32m 4) Exit"
    echo -n "\e[1;31mMake your pick: \e[1;32m"
    read SEL
    if [ "$SEL" == "1" ]; then
        clear
        echo "\e[1;31mWhat TWRP are you have use?:"
        echo "\e[1;32m 1) Nebrassy"
        echo "\e[1;32m 2) Vashy"
        echo "\e[1;32m 3) Return menu"
        echo "\e[1;32m 4) Exit"
        echo -n "\e[1;31mMake your pick: \e[1;32m"
        read SEL
        clear
        if [ "$SEL" == "1" ]; then
            twrp="files/nebrassy.cpio"
            start_aosp twrp 'twrp-root' dfe_true
        elif [ "$SEL" == "2" ]; then
            twrp="files/vashi.cpio"
            start_aosp twrp 'twrp-root' dfe_true
        elif [ "$SEL" == "3" ]; then
            start_menu
        elif [ "$SEL" == "4" ]; then
            exit 0
        else
            quick_aosp
        fi
    elif [ "$SEL" == "2" ]; then
        path_twrp="files/vashi.cpio"
        start_aosp
    elif [ "$SEL" == "3" ]; then
        start_menu
    elif [ "$SEL" == "4" ]; then
        exit 0
    else
        quick_aosp
    fi
}

quick_miui(){
    twrp=$1
    method=$2
    DFE=$3
    unpack_payload
    mkdir output/miui && mkdir output/miui/step1 && mkdir output/miui/step1/META-INF && mkdir output/miui/step1/META-INF/com && mkdir output/miui/step1/META-INF/com/google && mkdir output/miui/step1/META-INF/com/google/android
    mkdir output/miui && mkdir output/miui/step2_dfe && mkdir output/miui/step2_dfe/META-INF && mkdir output/miui/step2_dfe/META-INF/com && mkdir output/miui/step2_dfe/META-INF/com/google && mkdir output/miui/step2_dfe/META-INF/com/google/android && mkdir output/miui/step2_dfe/firmware-update && mkdir output/miui/step2_dfe/boot
    OUT="output/miui/step1" && addqti MIUI
    OUT="output/miui/step2_dfe" && addqti MIUI2
    OUT="output/miui/step1" && convert_img $OUT odm system system_ext product
    if [ $DFE == dfe_true ]; then
        vendor_dfe 'output/miui/step2_dfe' && dfe="DFE"
        else
        convert_img 'output/miui/step2_dfe' vendor
    fi
    convert_img_dat 'output/miui/step1' && convert_img_dat 'output/miui/step2_dfe'
    convert_dat_br 3 && OUT="output/miui/step2_dfe" && convert_dat_br 3
    OUT="output/miui/step1" && add_scrip_info 'miui' '#### - include' && OUT="output/miui/step2_dfe" && add_scrip_info 'miui' 'DFE,MAGISK,TWRP - include'
    move_img firmware-update xbl_config cmnlib64 cmnlib bluetooth abl aop modem qupfw tz uefisecapp xbl dsp devcfg featenabler keymaster hyp imagefv 
    addscrip_dat && OUT="output/miui/step1" && addscrip_dat
    move_img boot vendor_boot vbmeta vbmeta_system dtbo 
    path=$(realpath './'$OUT'/'boot/boot.img'') && sh twrp-magisk.sh $path $twrp $method
    lastscript_add 
    #size=$1, OUT=$2, path_OUT=$3, name=$4:
    sh ziping.sh 3 'output/miui/step1' '/sdcard' 'step1_miuirom_'$method'_'$DFE''
    sh ziping.sh 3 'output/miui/step2_dfe' '/sdcard' 'step2_miuirom_'$method'_'$DFE''
}
storege_path(){
    clear
	echo -n "\e[1;31mMake your pick: \e[1;32m" 
	read PATH
	if [ "$ARG" == "1" ]; then
	echo ""
	fi
}
detal_menu(){
    clear
    rom_type=""
	echo "\e[1;31mWhat ROM are you repacking?:"
	echo "\e[1;32m 1) MIUI"
	echo "\e[1;32m 2) AOSP"
	echo "\e[1;32m 3) PORT (soon)"
	echo "\e[1;32m 4) Return menu"
	echo "\e[1;32m 5) Exit"
    echo -n "\e[1;31mMake your pick: \e[1;32m"
    read SEL
    if [ "$SEL" == "1" ]; then
        rom_type="miui"
        detal_menu2
        elif [ "$SEL" == "2" ]; then
        rom_type="aosp"
        detal_menu2
        elif [ "$SEL" == "3" ]; then
        detal_menu
        elif [ "$SEL" == "4" ]; then
        start_menu
        elif [ "$SEL" == "5" ]; then
        exit 0
        else
        detal_menu
    fi
}
detal_menu2(){
clear
	echo "\e[1;31mWhat ROM are you repacking?:"
	echo "\e[1;32m 1) DFE+TWRP+MAGISK"
	echo "\e[1;32m 2) DFE+MAGISK"
	echo "\e[1;32m 3) DFE+TWRP"
    echo "\e[1;32m 4) DFE only"
    echo "\e[1;32m 5) TWRP+MAGISK"
    echo "\e[1;32m 6) TWRP only"
    echo "\e[1;32m 7) MAGISK only"
    echo "\e[1;32m 8) Original repack"
	echo "\e[1;32m 9) Return menu"
	echo "\e[1;32m 10) Exit"
    echo -n "\e[1;31mMake your pick: \e[1;32m"
    read SEL
    if [ "$SEL" == "1" ]; then
        DFE=dfe_true
        method='twrp-root'
        detal_menu3
        elif [ "$SEL" == "2" ]; then
        DFE=dfe_true
        method='root'
        images_menu
        elif [ "$SEL" == "3" ]; then
        DFE=dfe_true
        method='twrp'
        detal_menu3
        elif [ "$SEL" == "4" ]; then
        DFE=dfe_true
        method='original'
        images_menu
        elif [ "$SEL" == "5" ]; then
        DFE=dfe_false
        method='twrp-root'
        detal_menu3
        elif [ "$SEL" == "6" ]; then
        DFE=dfe_false
        method='twrp'
        detal_menu3        
        elif [ "$SEL" == "7" ]; then
        DFE=dfe_false
        method='root'
        images_menu
        elif [ "$SEL" == "8" ]; then
        DFE=dfe_false
        method='original'
        images_menu
        elif [ "$SEL" == "9" ]; then
        images_menu
        elif [ "$SEL" == "10" ]; then
        exit 0
        else
        detal_menu2
    fi
}
detal_menu3(){
        clear
        echo "\e[1;31mWhat TWRP are you have use?:"
        echo "\e[1;32m 1) Nebrassy"
        echo "\e[1;32m 2) Vashy"
        echo "\e[1;32m 3) Return menu"
        echo "\e[1;32m 4) Exit"
        echo -n "\e[1;31mMake your pick: \e[1;32m"
        read SEL
        if [ "$SEL" == "1" ]; then     
        twrp="files/nebrassy.cpio"
        images_menu
        elif [ "$SEL" == "2" ]; then 
        twrp="files/vashi.cpio"
        images_menu
        elif [ "$SEL" == "3" ]; then
        detal_menu2
        elif [ "$SEL" == "4" ]; then
        start_menu
        elif [ "$SEL" == "5" ]; then
        exit 0
        else
        detal_menu
        fi
}
images_menu(){
    clear
	echo "\e[1;31mWhat image are you using?:"
	echo "\e[1;32m    1) Payload.bin (Need move payload.bin to internal storage /sdcard/payload.bin)"
	echo "\e[1;32m    2) Super.img and others .img (soon)" 
	echo "\e[1;32m    3) Naked .imgs (system.img, vendor.img and etc)(soon)"
	echo "\e[1;32m    4) Return menu"
	echo "\e[1;32m    5) Exit"
	echo -n "\e[1;31mMake your pick: \e[1;32m"
    read SEL
    if [ "$SEL" == "1" ]; then
        if [ $rom_type == miui ]; then
        quick_miui
        elif [ $rom_type == aosp ]; then
        start_aosp $twrp $method $DFE
        else
        echo ""
        fi
        elif [ "$SEL" == "2" ]; then 
        images_menu
        elif [ "$SEL" == "3" ]; then
        images_menu
        elif [ "$SEL" == "4" ]; then
        start_menu
        elif [ "$SEL" == "5" ]; then
        exit 0
        else
        detal_menu
    fi
}
start_menu(){
    clear
	echo "\e[1;31mPlease select the number of the rom type you want to convert:"
	echo "\e[1;32m    1) Quick repackaging AOSP (only for Payload.bin, DFE+MAGISK+TWRP)"
	echo "\e[1;32m    2) Quick repackaging MIUI (only for Payload.bin, DFE+MAGISK+TWRP)"
	echo "\e[1;32m    3) Detailed repackaging settings"
	echo "\e[1;32m    4) Exit"
	echo -n "\e[1;31mMake your pick: \e[1;32m"
	read SEL
    if [ "$SEL" == "1" ]; then
        quick_aosp
        elif [ "$SEL" == "2" ]; then
        twrp="files/nebrassy.cpio"
        method="twrp-root"
        quick_miui $twrp $method dfe_true
        elif [ "$SEL" == "3" ]; then
        detal_menu
        elif [ "$SEL" == "4" ]; then
        exit 0
        else
        StartMenu
    fi
}

if [ ! -d "/sdcard/Repacks" ]; then
    mkdir /sdcard/Repacks
fi

start_menu
