#!/bin/bash

# One Mgmnt and One Master Node - TODO: Multi-master

SCRIPT_NAME="$(basename $0)"
p_unknown () {
  echo "Parameter error: $1"
  exit 1
}

usage () {
  cat << EOF

This script is to launch local cluster through Vagrant

Usage:
  $SCRIPT_NAME  [--mgmnt_ip mgmnt_ip] [--num_workers num_workers] [--vagrant_box base_vagrant_box_name]

Options:
  -h | --help
  Print help screen
  -w | --num_workers
  No.of workers (eg: "2")
  -b | --vagrant_box
  Base box name for Vagrant (eg: "base-rhel-7.5-vbox")

EOF
exit 0
}

while [ "$1" ]; do
  case "$1" in
   -h|--help) usage; shift;;
   -w|--num_workers)
   if [ -n "$2" ] ; then
   num_workers="$2"
   shift 2
   else
   p_unknown "missing argument, see $SCRIPT_NAME -h for help"
   fi
   ;;
   -b|--vagrant_box)
   if [ -n "$2" ] ; then
   base_vagrant_box_name="$2"
   shift 2
   else
   p_unknown "missing argument, see $SCRIPT_NAME -h for help"
   fi
   ;;
   *)  p_unknown "Internal error";;
  esac
done

if [ -z "$num_workers" ] || [ -z "$base_vagrant_box_name" ]; then
  p_unknown "Unknown/invalid argument, see $SCRIPT_NAME -h for help"
fi

export num_workers=$num_workers
export box_name=$base_vagrant_box_name

vagrant up
