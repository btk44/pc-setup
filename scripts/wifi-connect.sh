# list wifi networks in range and connect to selected one

# command listing networks
commandOutput=$(nmcli -f BSSID,SSID,BARS,IN-USE dev wifi list | awk '{ printf "%s;",$0;}')

# get each line separately
IFS=$';'
lines=($commandOutput)
unset IFS

networksSSID=()
i=0

echo -e "----------------------------------"
IFS=' '
for line in "${lines[@]}"
do
    if [ $i -ge 1 ]
    then
        echo -e "$i.\t${lines[$i]}"
        lineArgs=(${lines[$i]})
	networksSSID+=(${lineArgs[0]})
    else
        echo -e "\t${lines[$i]}"
    fi
    ((i+=1))
done
unset IFS
echo -e "----------------------------------"
echo -e "select network number: "
read selection
selectedValue="${networksSSID[$selection-1]}"
if [ -z $selection ] || [ $selection -le 0 ] || [ -z $selectedValue ]
then
    echo -e "nothing selected"
else
    echo -e "your selection: ${lines[$selection]}"
    nmcli --ask dev wifi connect "$selectedValue" 
fi
