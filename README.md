# openwrt-packages-netstat-nat

This is `netstat-nat` package for OpenWrt, tested on CC(15.05.1).

# How to install binary package

```
$ opkg update
$ opkg install openssl-util
$ echo 'src/gz hnw https://dl.bintray.com/hnw/openwrt-packages/15.05.1/ar71xx' >> /etc/opkg/customfeeds.conf
$ cat > /tmp/public.key
untrusted comment: public key ad619e57963caac
RWQK1hnleWPKrKzKxpRlpYZVtkWvCVmw7HbukOaGFqeJg8o01UTv7RML
$ opkg-key add /tmp/public.key
$ opkg update
$ opkg install netstat-nat
```

# How to build

To build these packages, add the following line to the feeds.conf in the OpenWrt buildroot:

```
$ echo 'src-git hnw_netstat-nat https://github.com/hnw/openwrt-packages-netstat-nat.git' >> feeds.conf
```

Then you can build packages as follows:

```
$ ./scripts/feeds update -a
$ ./scripts/feeds install netstat-nat
$ make packages/netstat-nat/compile
```
