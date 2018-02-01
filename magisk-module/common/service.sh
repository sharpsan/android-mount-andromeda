#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread


##Automount Andromeda on your phone
##Source obtained from https://github.com/GabMus/start_andromeda_locally_root
##andromeda_local.sh version: commit 0503df7

sleep 15

pkg=$(pm path projekt.andromeda)

echo "pkg:    $pkg"

echo "Cutting pkg"
echo $pkg | cut -d : -f 2 | sed s/\\r//g
echo "pkg:    $pkg"

tokill=$(pidof andromeda)

if [[ "$tokill" == "" ]]
then echo
am force-stop projekt.substratum
appops set projekt.andromeda RUN_IN_BACKGROUND allow
appops set projekt.substratum RUN_IN_BACKGROUND allow
CLASSPATH=$pkg app_process /system/bin --nice-name=andromeda projekt.andromeda.Andromeda &
echo "Done"
else echo
am force-stop projekt.substratum
kill -9 $kill
appops set projekt.andromeda RUN_IN_BACKGROUND allow
appops set projekt.substratum RUN_IN_BACKGROUND allow
CLASSPATH=$pkg app_process /system/bin --nice-name=andromeda projekt.andromeda.Andromeda &
echo "Done"
fi
