# 理解Block Storage
if false; then
操作系统获得存储空间的方式一般有两种：
    1、通过某种协议(SAS,SCSI,SAN,iSCSI等)挂接裸硬盘，然后分区、格式化、创建文件系统；
        或者直接使用裸硬盘存储数据(数据库)
    2、通过NFS、CIFS等协议，mount远程的文件系统
第一种裸硬盘的方式叫做Block Storage(块存储)，每个裸硬盘通常也称作Volume(卷)第二种叫做文件系统存储。
NAS和NFS服务器，以及各种分布式文件系统提供的都是这种存储。

Openstack提供Block Storage Service的是Cinder，其具体功能是：
    1、提供REST API使用户能够查询和管理volume、volume snapshot以及volume type
    2、提供scheduler调度volume创建请求，合理优化存储资源的分配
    3、通过driver架构支持多种back-end（后端存储方式）包括LVM,NFS,Ceph和其他诸如 EMC、IBM 等商业存储产品和方案

cinder-api
cinder-schedule
cinder-volume

fi