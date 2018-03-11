#!/bin/bash

# Check if env set with RHSM credentials
[[ -z "$RHSM_USERNAME" ]] && logts "RHSM_USERNAME not set"
[[ -z "$RHSM_PASSWORD" ]] && logts "RHSM_PASSWORD not set"


###############################################################
# Alt terminals on Windows (assumes vagrant/packer are in PATH
###############################################################
VAGRANT_CMD=vagrant
PACKER_CMD=packer
case "$(uname -s)" in
  *CYGWIN*|MSYS*|MINGW*)
  VAGRANT_CMD=vagrant.exe
  PACKER_CMD=packer.exe
  ;;
  *)
  ;;
esac
###############################################################

#######################
# ANSI Colors
#######################
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
#######################

# Potentially args to script ?
IMG="rhel_7.4_base"
VM_TYPE="virtualbox"
BOX_NAME="base-rhel-7.4-vbox"

PACKER_TEMPLATE="template_${IMG}.json"


function logInfo {
  echo -e "`date +%Y-%m-%dT%H:%M:%S` baker [${GREEN}INFO${NC}] $@"
}

function logErr {
  echo -e "`date +%Y-%m-%dT%H:%M:%S` baker [${RED}ERROR${NC}] $@"
}

#################################################################
logInfo "Validating Packer template  ..."
${PACKER_CMD} validate packer/${PACKER_TEMPLATE}
if [ $? -ne 0 ]
then
  logErr "Invalid Packer template"
  exit 1
fi

#################################################################
logInfo "Baking ${IMG} Image ..."
${PACKER_CMD} build -force packer/${PACKER_TEMPLATE}
if [ $? -ne 0 ]
then
  logErr "Error baking image"
  exit 1
fi

#################################################################
logInfo "Adding Created Box ${BOX_NAME} Into Vagrant Box ..."
${VAGRANT_CMD} box add --force ${BOX_NAME} boxes/${BOX_NAME}.box
if [ $? -ne 0 ]
then
  logErr "Error adding box"
  exit 1
fi
