#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

#755
chmod -R 755 files

#netdata
rm package/lean/luci-app-netdata -r

#jd
rm package/lean/luci-app-jd-dailybonus -r

# cd files/network/config
# git update-index --chmod=+x network
# git commit -am "chmod +x network"
# git update-index --chmod=+x firewall
# git commit -am "chmod +x firewall"

#busybox
sed -i 's/W I R E L E S S   F R E E D O M/H o m e R o u t e r   C e n t e r/g' package/base-files/files/etc/banner
sed -i 's/%D %V, %C/Openwrt Setting, Complied by biki/g' package/base-files/files/etc/banner

# Modify default IP
sed -i 's/192.168.1.1/10.10.10.11/g' package/base-files/files/bin/config_generate
sed -i 's/"192.168.$((addr_offset++)).1/"10.10.$((addr_offset++)).1/g' package/base-files/files/bin/config_generate 
sed -i 's/OpenWrt/HomeRouter/g' package/base-files/files/bin/config_generate

#theme
sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#biiki
sed -i 's/R21.12.1/R21.12.1 Complied by biki/g' package/lean/default-settings/files/zzz-default-settings

#poweroff
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

#software
cd package/lean/
rm -rf luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone https://github.com/jerrykuku/luci-app-argon-config
git clone https://github.com/tty228/luci-app-serverchan
git clone https://github.com/bikiz/package
git clone https://github.com/jerrykuku/lua-maxminddb.git  
git clone https://github.com/jerrykuku/luci-app-vssr.git
git clone https://github.com/rufengsuixing/luci-app-adguardhome
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git
git clone https://github.com/sirpdboy/luci-app-netdata
