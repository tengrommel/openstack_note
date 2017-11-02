if false; then
nova的有些命令可以省略
nova boot
nova delete
nova list
nova show

Compute Service Nove 是 OpenStack最核心的服务，负责维护和管理云环境的计算资源
OpenStack作为Iaas的云操作系统，虚拟机生命周期管理也就是通过Nove来实现。
fi

# API
# nova-api 
if false; then
接收和响应客户的API调用

Compute Core
nove-scheduler
虚拟机调度服务，负责决定在哪个计算节点上运行虚拟机

nova-compute
管理虚拟机的核心服务，通过调用Hypervisor API实现虚拟机生命周期管理

Hypervisor 
计算节点上跑的虚拟化管理程序，虚拟机管理最底层的程序
不同虚拟化技术提供自己的Hypervisor
常用的Hypervisor有KVM,Xen,VMWare等

nove-conductor
nova-compute经常需要更新数据库，比如更新虚拟机的状态
出于安全性和伸缩性的考虑，nova-compute并不会直接访问数据库，而是将这个任务委托给nova-conductor。

fi