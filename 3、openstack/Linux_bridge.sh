if false; then
Linux Bridge基本概念
假设宿主机有1块与外网连接的物理网卡eth0，上面跑了1个虚拟机VM1，现在有个问题是：如何让VM1能够访问外网
1、将物理网卡eth0直接分配给VM1，但随之带来的问题很多：宿主机就没有网卡，无法访问了； 新的虚机，比如 VM2 也没有网卡。
2、给VM1分配一个虚拟网卡vnet0，通过Linux Bridge br0将eth0和vnet0连接起来

Linux Bridge是Linux上用来做TCP/IP二层协议交换的设备，其功能大家可以简单的理解为是一个二层交换机或者 Hub。
多个网络设备可以连接到同一个 Linux Bridge，当某个设备收到数据包时，Linux Bridge 会将数据转发给其他设备。

Linux如何实现VLAN
VLAN 的隔离是二层上的隔离，A 和 B 无法相互访问指的是二层广播包（比如 arp）无法跨越 VLAN 的边界。
但在三层上（比如IP）是可以通过路由器让 A 和 B 互通的。概念上一定要分清。
fi
