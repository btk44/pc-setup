#!/bin/bash
# list wifi networks in range and connect to selected one

# command listing networks
commandOutput=$(nmcli -f BSSID,SSID,BARS,IN-USE dev wifi list | awk '{ printf "%s;",$0;}')

# get each output line separately
IFS=$';'
lines=($commandOutput)
unset IFS

# prepare array with network bssids
networksBSSID=()
i=0

#display all the networks and get their bssids
echo -e "----------------------------------"
IFS=' '
for line in "${lines[@]}"
do
    if [ $i -ge 1 ]
    then
        echo -e "$i.\t${lines[$i]}"
        lineArgs=(${lines[$i]})
	networksBSSID+=(${lineArgs[0]}) # take bssid only
    else
        echo -e "\t${lines[$i]}" # header line
    fi
    ((i+=1))
done
unset IFS
echo -e "----------------------------------"

# get feedback from the user
echo -e "select network number: "
read selection

# connect to selected network
selectedValue="${networksBSSID[$selection-1]}"
if [ -z $selection ] || [ $selection -le 0 ] || [ -z $selectedValue ]
then
    echo -e "nothing selected"
else
    echo -e "your selection: ${lines[$selection]}"
    nmcli --ask dev wifi connect "$selectedValue" # this will always ask for password
fi
