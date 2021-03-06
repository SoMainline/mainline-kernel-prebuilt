set -e

if [ -z "$ANDROID_ROOT" ]; then
    ANDROID_ROOT="`realpath ../../../`"
    echo "WARNING: Guessing Android root at: $ANDROID_ROOT"
fi

kernel_top=$ANDROID_ROOT/kernel/mainline/
kernel_out=$ANDROID_ROOT/out/mainline-kernel

cd $kernel_top/kernel

echo "================================================="
echo "Your Environment:"
echo "ANDROID_ROOT: $ANDROID_ROOT"
echo "kernel_top  : $kernel_top"
echo "kernel_out  : $kernel_out"

ret=$(mkdir -p $kernel_out 2>&1);
if [ ! -d $kernel_out ] ; then
    echo "Failed to create output directory";
    echo "ERROR: $ret";
    exit 1;
fi

# Build command
build="make O=$kernel_out ARCH=arm64 -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-none-eabi-"

echo "$build"

echo "================================================="
echo "Building defconfig ..."
${build} defconfig

echo "The build may take up to 10 minutes. Please be patient ..."
echo "Building new kernel image ..."
${build} Image.gz dtbs

echo "Copying new kernel image ..."
cp $kernel_out/arch/arm64/boot/Image.gz $kernel_top/common-kernel/Image.gz
cp $kernel_out/arch/arm64/boot/dts/qcom/*-sony-xperia-*.dtb $kernel_top/common-kernel/

echo "================================================="
echo "Done!"
