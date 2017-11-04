if false; then
Nove备份的操作叫snapshot，其工作原理是对instance的镜像文件（系统盘）进行全量备份，
生成一个类型为snapshot的image，然后将其保存到Glance上。

如果instance损坏了，可以通过snapshot恢复，这个恢复的操作就是Rebuild。

instance被Suspend后虽然处于ShutDown状态，但Hypervisor依然在宿主机上为其预留了资源，
以便在以后能够成功Resume。

如果希望释放这些预留资源，可以使用Shelve操作。
Shelve会将instance作为image保存到Glance中，然后在宿主机上删除该instance。
instance unshelve后可能运行在与shelve之前不同的计算节点上，但instance的其他属性不会改变。

Migrate操作的作用是将instance从当前的计算节点迁移到其他节点上。
Migrate 不要求源和目标节点必须共享存储，当然共享存储也是可以的。 
Migrate 前必须满足一个条件：计算节点间需要配置 nova 用户无密码访问。
fi

if false; then
Resize的作用是调整instance的vCPU、内存和磁盘资源。
Instance需要多少资源是定义在flavor中的，resize操作是通过为了instance选择新的flavor来调整资源的分配。

Resize 分两种情况：
1、nova-scheduler 选择的目标节点与源节点是不同节点。
操作过程跟上一节 Migrate 几乎完全一样，只是在目标节点启动 instance 的时候按新的 flavor 分配资源。
同时，因为要跨节点复制文件，也必须要保证 nova-compute 进程的启动用户（通常是 nova，也可能是 root，可以通过 ps 命令确认）能够在计算节点之间无密码访问。
2、目标节点与源节点是同一个节点。则不需要 migrate。
fi