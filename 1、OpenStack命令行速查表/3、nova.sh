# 计算（nova）
# 列出实例，核实实例状态
openstack server list
# Create a flavor named m1.tiny
openstack flavor create --ram 512 --disk 1 --vcpus 1 m1.tiny
# 列出规格类型
openstack flavor list
# 用类型和镜像名称(如果名称唯一)来启动云主机
openstack server create --image IMAGE --flavor FLAVOR INSTANCE_NAME
openstack server create --image cirrors-0.3.5-x86-uec --flavor m1.tiny MyFirstInstance

ip netns
ip netns exec NETNS_NAME ssh USER@SERVER
ip netns exec qdhcp-6021a3b4-8587-4f9c-8064-0103885dfba2 ssh cirros@10.0.0.2
# Log in to the instance with a public IP address(from Mac)
ssh cloud-user@128.107.37.150
# 显示实例详细信息
openstack server show NAME
openstack server show MyFirstInstance
openstack console log show MyFirstInstance
nova meta volumeTwoImage set newmeta='my meta data'
openstack image create volumeTwoImage snapshotOfVolumeImage
openstack image show snapshotOfVolumeImage
# 实例的暂停、挂起、停止、救援、调整规格、重建、重启¶
openstack server pause NAME
openstack server pause volumeTwoImage
# 取消挂起
openstack server unpause NAME
# 挂起
openstack server suspend NAME
# Unsuspend
openstack server resume NAME
# 关机
openstack server stop NAME
# 开始
openstack server start NAME
# 恢复
openstack server resume NAME
openstack server rescue NAME --rescue_image_ref RESCUE_IMAGE
# 调整大小
openstack server resize NAME FLAVOR
openstack server resize my-pem-server m1.small
openstack server resize --confirm my-pem-server1
# 重建
openstack server rebuild NAME IMAGE
openstack server rebuild newtinny cirrors-qcow2
# 重启
openstack server reboot NAME
openstack server reboot newtinny
# 将用户数据和文件注入到实例
openstack server create --user-data FILE INSTANCE
openstack server create --user-data userdata.txt --image cirrors-qcows --flavor m2.tiny MyUserdataInstance2
# 创建秘钥对
openstack keypair create test > test.pem
chmod 600 test.pem
# 启动实例
openstack server create --image cirrors-0.3.5-x86_64 --flavor m1.small --key-name test MyFirstServer
# 使用ssh连接到实例
ip netns exec qdhcp-98f09f1e-64c4-4301-a897-5067ee6d544f ssh -i test.pem cirros@10.0.0.4
# 管理安全组
# 在默认的安全组中，添加ping和SSH规则
openstack security group rule create default --remote-group default --protocol icmp
openstack security group rule create default --remote-group default --dst-port 22