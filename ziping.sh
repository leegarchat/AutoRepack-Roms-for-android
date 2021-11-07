    size=$1
	OUT=$2
	path_OUT=$3
	name=$4
	echo -e "\e[1;34mPacking rom files...\e[0m"
    echo
    cd $OUT
    zip -$size -r $name *
    mv *.zip ''$path_OUT'/'$name'.zip'