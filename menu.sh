AospQ(){
sh QuickRepackAOSP.sh
StartMenu
}
MiuiQ(){
sh QuickRepackMIUI.sh
StartMenu
}
StoregePath(){
	echo -n "\e[1;31mMake your pick: \e[1;32m" 
	read PATH
	if [ "$ARG" == "1" ]; then
	
	fi
}
DetalMenu(){
	echo "\e[1;31mWhat ROM are you using?:"
	echo "\e[1;32m    1) MIUI"
	echo "\e[1;32m    2) AOSP"
	echo "\e[1;32m    3) PORT"
	echo "\e[1;32m    4) Return menu"
	echo "\e[1;32m    5) Exit"
}
ImagesMenu(){
	echo "\e[1;31mWhat image are you using?:"
	echo "\e[1;32m    1) Payload.bin"
	echo "\e[1;32m    2) Super.img and others .img"
	echo "\e[1;32m    3) Naked .imgs (system.img, vendor.img and etc)"
	echo "\e[1;32m    4) Return menu"
	echo "\e[1;32m    5) Exit"
	echo -n "\e[1;31mMake your pick: \e[1;32m"
	if [ "$SEL" == "1" ]; then
	StoregePath
}
StartMenu(){
	echo "\e[1;31mPlease select the number of the rom type you want to convert:"
	echo "\e[1;32m    1) Quick repackaging AOSP (only for Payload.bin, DFE+MAGISK+TWRP_V)"
	echo "\e[1;32m    2) Quick repackaging MIUI (only for Payload.bin, DFE+MAGISK+TWRP_N)"
	echo "\e[1;32m    3) Detailed repackaging settings"
	echo "\e[1;32m    4) Exit"
	echo -n "\e[1;31mMake your pick: \e[1;32m"
	read SEL
if [ "$SEL" == "1" ]; then
	AospQ
	elif
	MiuiQ
	elif
	
	elif [ "$SEL" == "4" ]; then
	exit 0
	else
		StartMenu
fi
}
StartMenu


