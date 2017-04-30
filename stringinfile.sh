#!/bin/bash
nd=0
nline=1
#function for help
help () {
echo -e "systax error:\nPlease, use: ./stringinfile.sh -f <file name> -s <string>\nor\n./stringinfile.sh -s <string> -f <file name>"
}
fshelp () {
echo -e "string is empty\nor\nfile can't read, not exist or empty"
}
#get date to variable
if [ $# -eq 4 ]
then
	while [ $1 ]
	do
		case $1 in
			"-f")f="$2";;
			"-s")s="$2";;
			*)help;exit 1;;
		esac
		shift 2
	done
else
	help
	exit 1
fi
#condition of variable
if [ -z "$s" ] || [ ! -r "$f" ] || [ `ls -l $f | awk '{print $5}'` -eq 0 ]
then
	fshelp
	exit 1
fi
#read line by line and find string
while read line
do
	ofs=$((${#line} - ${#s}))
	until [ "$ofs" -lt 0 ]
	do
		if [ "${line:$ofs:${#s}}" == "$s" ]
		then
			dong[$nd]="$nline |$line"
			nd=$(($nd + 1))
			break
		fi
		ofs=$(($ofs - 1))
	done
	nline=$(($nline + 1))
done <$f
#enjoy
echo "number line | line"
printf '%s\n' "${dong[@]}"

