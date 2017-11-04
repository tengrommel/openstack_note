# 理解Block Storage
if false; then
操作系统获得存储空间的方式一般有两种：
    1、通过某种协议(SAS,SCSI,SAN,iSCSI等)挂接裸硬盘，然后分区、格式化、创建文件系统；
        或者直接使用裸硬盘存储数据(数据库)
    2、通过NFS、CIFS等协议，mount远程的文件系统
fi