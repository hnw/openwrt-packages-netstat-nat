# openwrt-packages-netstat-nat [![Build Status](https://secure.travis-ci.org/hnw/openwrt-packages-netstat-nat.svg?branch=master)](https://travis-ci.org/hnw/openwrt-packages-netstat-nat)

This is [netstat-nat](http://tweegy.nl/projects/netstat-nat/) package for OpenWrt, tested on OpenWrt 15.05.1 / LEDE 17.01.4.

# How to install binary package

See [hnw/openwrt-packages](https://github.com/hnw/openwrt-packages).

# How to build

To build these packages, add the following line to the feeds.conf in the OpenWrt buildroot:

```
$ cp feeds.conf.default feeds.conf # if needed
$ echo 'src-git hnw_netstat_nat https://github.com/hnw/openwrt-packages-netstat-nat.git' >> feeds.conf
```

Then you can build packages as follows:

```
$ ./scripts/feeds update -a
$ ./scripts/feeds install netstat-nat
$ make defconfig
$ make package/toolchain/compile
$ make package/netstat-nat/compile
```
