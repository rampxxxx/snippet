#!/bin/bash
#set -x

#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}


# Crear imagen/disco duro local
# qemu-img create -f qcow2 tumbleweed.qcow2 70G
# Montar cdrom para lanzar la instalacion
# qemu-system-x86_64 -usb -cdrom ~/Descargas/openSUSE-Tumbleweed-DVD-x86_64-Current.iso -m 1024 -hda ./tumbleweed.img
# o mejor esta
# qemu-kvm -boot d -cdrom ~/Downloads/openSUSE-Tumbleweed-DVD-x86_64-Snapshot20200107-Media.iso -m 1024 -hda ./tumbleweed.qcow2
#qemu-system-x86_64 -enable-kvm -usb -cdrom ~/Descargas/openSUSE-Tumbleweed-DVD-x86_64-Current.iso -m 1024 -hda ./tumbleweed.img
# Arrancar imagen './tumbleweed.img'
# Utilizar kvm es MUCHO más rapido '-enable-kvm'
#qemu-system-x86_64 -enable-kvm -usb -cdrom ~/Descargas/openSUSE-Tumbleweed-DVD-x86_64-Current.iso -m 1024 -hda ./tumbleweed.img
# Tras convertir con:
# qemu-img convert -f raw -O qcow2 ./tumbleweed.img ./tumbleweed.qcow2
#qemu-system-x86_64 -enable-kvm -usb  -m 1024 -hda ./tumbleweed.qcow2


# PROPER WORKING -> qemu-system-x86_64 -enable-kvm -usb  -m 1024 -drive file=tumbleweed.qcow2,cache-size=2621440

#qemu-system-x86_64 -enable-kvm -usb -m 1024 -drive file=./tumbleweed.qcow2,cache-size=2621440 -device virtio-serial-pci -spice port=5930,disable-ticketing -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent
## CONF #######

# CONSTS
readonly SUDO="sudo -sE "
readonly QEMU_PAR=" -enable-kvm "
readonly QEMU_BIG=" -m 8192 -smp 6 "
readonly QEMU_VERY=" -m 10240 -smp 6 "
readonly QEMU_MEDIUM=" -m 4096 -smp 4 "
readonly QEMU_SMALL=" -m 1024 "
# Port 5555 used by mldonkey (mlnet server) , old comment?
# Allow ssh to 2222
readonly QEMU_SSH="  -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2222-:22"
# SMB
# nic1 to not class with already using nic0
# Inside the guest mount smb://10.0.2.4/qemu , in dolphin for example.
readonly QEMU_SMB_HOME_SHARE="  -nic user,id=net1,smb=/home/ramp " 
#### DEPRECATED -bt options readonly QEMU_BLUETOOTH=" -bt hci,host:hci0"

# GLOBAL VARS
QEMU_CMD=" qemu-system-x86_64 "
QEMU_SPICE_SUPPORT="-display spice-app -device virtio-serial-pci -spice port=5930,disable-ticketing=on -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent " # SPICE seems to not work with this config
QEMU_HD=""
QEMU_USB=""


# FUNCTIONS
#
function _usage(){
	echo "usage : " "$0" " ./file.qcow2 [very|big|medium|small] "
	exit 1
}

function _check_params(){

if [ $# -lt 1 ]; then
	_usage
else
	QEMU_HD="  -drive file=$1,cache-size=2621440"
fi

if [ $# -lt 2 ]; then
	SIZE="medium" # Default
else
	SIZE="$2"
fi

if [ $# -lt 3 ]; then
	SPICE="spice" # Default
else
	SPICE="$3"
fi

}

function _select_usb_to_passthrough(){

	# Hay que ejecutar con root para acceder al hostdevice
	# Ver usb con "lsusb -t"
	# qemu-xhci da soporte a usb2, usb3
	# solo he conseguido que funcionara con hostdevice=/path/al/que/quiero
	echo "Automatic select and passthrough to vm"
	lsusb| awk '{ print NR " " $0}'
	echo
	echo "Select number of device you want or enter to continue:"
	read -r usb_dev_number
	if [ "$usb_dev_number" != "" ];then
		usb_bus=$(lsusb| awk '{ print NR " " $0}'|grep "^$usb_dev_number"| awk '{print $3}')
		usb_dev=$(lsusb| awk '{ print NR " " $0}'|grep "^$usb_dev_number"| awk '{print $5}'| awk -F: '{print $1}' )
		QEMU_USB=" -usb -device qemu-xhci -device usb-host,hostdevice=/dev/bus/usb/$usb_bus/$usb_dev"
		QEMU_CMD="$SUDO $QEMU_CMD" # Add perms if want acccess usb devices.
	else
		QEMU_USB=""
	fi

}

function _run(){
	echo "$*"
	eval "$*"
}

function _main(){

	_check_params "$@"
	_select_usb_to_passthrough




if [ "$SPICE" == "spice" ]
then
	echo "Using spice"
	echo "Using spice :  In Guest 'spice-vdagent' (or other similar) must be running"
else
	echo "spice OFF"
	QEMU_SPICE_SUPPORT=""
fi



echo " Access to ssh host with 10.0.2.2 or port 2222 to localhost!!!!"
case "$SIZE" in
	"small")
		eval "$QEMU_CMD $QEMU_SMALL $QEMU_PAR $QEMU_SPICE_SUPPORT $QEMU_HD $QEMU_SSH $QEMU_USB $QEMU_SMB_HOME_SHARE"
		;;
	"medium")

		_run "$QEMU_CMD $QEMU_MEDIUM $QEMU_PAR $QEMU_SPICE_SUPPORT $QEMU_HD $QEMU_SSH $QEMU_USB $QEMU_SMB_HOME_SHARE "
		#eval "$QEMU_CMD $QEMU_MEDIUM $QEMU_PAR $QEMU_SPICE_SUPPORT $QEMU_HD $QEMU_SSH $QEMU_USB"
		# Alternative way of exe the cmd.
		#cmds=$(printf "%s %s %s %s %s %s %s" "$QEMU_CMD" "$QEMU_MEDIUM $QEMU_PAR $QEMU_SPICE_SUPPORT $QEMU_HD $QEMU_SSH $QEMU_USB")
		#$cmds
		;;
	"big")
		eval "$QEMU_CMD $QEMU_BIG $QEMU_PAR $QEMU_SPICE_SUPPORT $QEMU_HD $QEMU_SSH $QEMU_USB $QEMU_SMB_HOME_SHARE"
		;;
	"very")
		eval "$QEMU_CMD $QEMU_VERY $QEMU_PAR $QEMU_SPICE_SUPPORT $QEMU_HD $QEMU_SSH $QEMU_USB $QEMU_SMB_HOME_SHARE"
		;;
	*)
		echo "Invalid option"
		_usage
		;;
esac

}


# MAIN 
#


_main "$@"


