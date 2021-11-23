#!/bin/bash
#Elaboro: Edgar Francisco Mata Pérez

uname=$(yum list installed | grep '^clamav')
system=$(grep 'VERSION_ID' /etc/os-release)

####
#SO

echo 'Detecting operating system...'
if [[ $system = 'VERSION_ID="8"' ]];
then
  echo '[>] System: CentOS v8'
elif [[ $system = 'VERSION_ID="7"' ]];
then
  echo '[>] System: CentOS v7'
fi

####
#CLAMAV

if [[ $uname = "" ]];
then
  echo 'Clamav is not installed'
  yum -y install clamav
  echo 'Installation completed'
else
  echo 'CLAMAV is installed > Uninstallation in progress...'
  yum -y erase clamav*
  echo 'Installing clamav...'
  yum -y install clamav
  echo 'Installation completed successfully'
fi

####
#EPEL

if [[ $system = 'VERSION_ID="8"' ]];
then
echo 'EPEL NO INSTALL IN CENTOS 8'
elif [[ $system = 'VERSION_ID="7"' ]];
then
  echo 'CentOS 7 system detected, EPEL installed'
  yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
fi

#UPDATE

if [[ $(yum check-update -q | awk '{print $1}') = "" ]];
  then
    echo 'No need to update'
fi

for line in $(yum check-update -q | awk '{print $1}');
do
  echo 'Packages to update...'
  echo $line
  echo 'Packages updated with time'
  yum -y update $line
  echo 'Update completed, packages updated successfully'
done

exit 0
