#!/bin/bash
#set -x
# Define variables

tempfile="/tmp/veeam.pkg"
weburl="https://testbmyqa-my.sharepoint.com/:u:/g/personal/admin_testbmyqa_onmicrosoft_com/Efu-Pff22DhPtj5L0Ih3yXUB6FHc8qCq5TqfUc67GoRqNQ?e=fJoT9w&download=1"
appname="Veeam"
log="/var/log/installVeeam.log"

# start logging

exec 1>> $log 2>&1

# Begin Script Body

echo ""
echo "##############################################################"
echo "# $(date) | Starting install of $appname"
echo "############################################################"
echo ""

# Let's download the files we need and attempt to install...

echo "$(date) | Downloading $appname"
curl -L -f -o $tempfile $weburl

echo "$(date) | Installing $appname"
installer -dumplog -pkg $tempfile -target /Applications
if [ "$?" = "0" ]; then
   echo "$(date) | $appname Installed"
   echo "$(date) | Cleaning Up"
   exit 0
else
  # Something went wrong here, either the download failed or the install Failed
  # intune will pick up the exit status and the IT Pro can use that to determine what went wrong.
  # Intune can also return the log file if requested by the admin
   echo "$(date) | Failed to install $appname"
   exit 1
fi
