#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "bootstrap.sh must be run as root"
  exit 1
fi

echo "Gathering system information"
sleep 1

BOOTSTRAP_LOG="./bootstrap.log"

# Get disto
if [[ -f /etc/lsb-release ]]; then
  OS_DISTRO="ubuntu";
  PKG="apt"
  PKGREPO="apt-add-repository"
elif [[ -f /etc/redhat-release ]]; then
  OS_DISTRO="redhat"
  source /etc/os-release
  if [[ $ID == "centos" || $ID = "fedora" ]]; then
    PKG="dnf";
  else
    PKG="yum";
  fi
else
  echo "Unsupported distribution"
  exit 1;
fi

echo "Installing system requirements"
touch $BOOTSTRAP_LOG

sleep 1
# Install ansible
echo -en "\033[0;32m Ansible: \033[0m"
if [[ $OS_DISTRO == "ubuntu" ]]; then
  sleep 1
  $PKG install software-properties-common &>> $BOOTSTRAP_LOG
  $PKGREPO --yes --update ppa:ansible/ansible &>> $BOOTSTRAP_LOG
elif [[ $ID == "centos" ]]; then
  $PKG install epel-release -y &>> $BOOTSTRAP_LOG
fi
$PKG install ansible -y &>> $BOOTSTRAP_LOG

echo -e "\xE2\x9C\x94"
echo "Running ansible"

ansible-playbook setup.yml -K -v --step
