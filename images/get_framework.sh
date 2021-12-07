
### 使用方法 ###
#
# bash get_framework.sh
#
###


# 填写要生成的包的名字
FrameWorkName="JDViewKit"

# 设置输出包的文件路径
OutputDir=${SRCROOT}/VKOutput
# Working dir will be deleted after the framework creation.
buildDir=build
DEVICE_DIR=${buildDir}/Release-iphoneos
SIMULATOR_DIR=${buildDir}/Release-iphonesimulator/${FrameWorkName}.framework

#编译真机和模拟器的两种架构
# -configuration ${CONFIGURATION}
# Clean and Building both architectures.

xcodebuild -configuration "Release" -target "${FrameWorkName}" -sdk iphoneos clean build
xcodebuild -configuration "Release" -target "${FrameWorkName}" -sdk iphonesimulator clean build


# 把旧的输出文件包删除掉
if [ -d "${OutputDir}" ]
then
sudo rm -rf "${OutputDir}"
fi

# 创建输出包
sudo mkdir -p "${OutputDir}"
sudo cp -R "${DEVICE_DIR}/" "${OutputDir}/"

# 使用 lipo工具合并通用包（(i386 + armv6/armv7)）
sudo lipo -create "${DEVICE_DIR}/${FrameWorkName}.framework/${FrameWorkName}" "${SIMULATOR_DIR}/${FrameWorkName}" -output "${OutputDir}/${FrameWorkName}.framework/${FrameWorkName}"

# 删除build包  打开输出包文件夹
sudo rm -r "${buildDir}"
open "${OutputDir}"