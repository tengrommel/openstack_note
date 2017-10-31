# 用于管理连接到实例的卷和卷快照
openstack volume create --size SIZE_IN_GB NAME
openstack volume create --size 1 MyFirstVolume
# 启动实例并将它链接到卷上
openstack server create --image cirros-qcow2 --flavor m1.tiny MyVolumeInstance
openstack volume list
# 当实例为正常状态且卷为可用状态时，将卷连接到实例。
penstack server add volume INSTANCE_ID VOLUME_ID
openstack server add volume MyVolumeInstance 573e024d-5235-49ce-8332-be1576d323f8

fdisk -l