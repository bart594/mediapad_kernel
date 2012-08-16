export KBUILD_BUILD_VERSION="3.0.38"
export KBUILD_BUILD_USER="Mediapad EX"
export CROSS_COMPILE="/home/ubu/arm-eabi-4.4.3/bin/arm-eabi-"

ROOTFS_PATH="/home/ubu/mediapad/ramdisk"
ramdisk_dir=/home/ubu/mediapad/ramdisk/ramdisk.gz
CMDLINE="console=console=ttyHSL0,115200,n8 androidboot.hardware=hws7300u vmalloc=578M kgsl.ptcount=16"
BASE="0x40300000"

# Do not modify below this line

NB_CPU=`grep processor /proc/cpuinfo | wc -l`

let NB_CPU+=1

CONFIG=$1

make $CONFIG

make ARCH=arm -j$NB_CPU CROSS_COMPILE=$CROSS_COMPILE

cp arch/arm/boot/zImage .

find -name '*.ko' -exec cp -av {} $ROOTFS_PATH/lib/modules/ \;

# Make boot.img

./mkbootimg --cmdline "$CMDLINE" --base $BASE --kernel zImage --ramdisk $ramdisk_dir -o boot_new.img
