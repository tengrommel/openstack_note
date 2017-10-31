# 网络(neutron)
openstack network create NETWORK_NAME
# 创建子网
openstack subnet create --subnet-pool SUBNET --network NETWORK SUBNET_NAME
openstack subnet create --subnet-pool 10.0.0.0/29 --network net1 subnet1

