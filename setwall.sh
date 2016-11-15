#!/usr/bin/env bash
if [ $# -eq 0 ] || [ $# -gt 3 ]; then
	echo "Invalid number of arguments!"
	exit
fi
reverse=false
if [ "$2" == "-r" ]; then
	reverse=true
fi
show_panel=true
if [ "$3" == "-n" ]; then
	show_panel=false
fi

for filename in /home/daemoz/Pictures/Wallpapers/$1/*; do
	Files=(${Files[@]} $filename)
done

read count < /home/daemoz/.config/setwall/$1
if [ $reverse == true ]; then
	count=$(($count-1))
	echo "hmmm"
else
	count=$(($count+1))
fi
wallpapernum=$(ls /home/daemoz/Pictures/Wallpapers/$1 | wc -l)
i=$(($count%$wallpapernum))
echo "${count}" > /home/daemoz/.config/setwall/$1
read pid < /home/daemoz/.config/setwall/pid
#if process name contains "feh", kill it and continue
if [ "$(ps -p $pid -o comm=)" == "feh" ]; then
	kill $pid
fi
feh --bg-fill ${Files[i]}
if [ $show_panel == true ]; then
	pidwrap "feh -g 1x1 --zoom fill ${Files[i]}" /home/daemoz/.config/setwall/pid&
fi
