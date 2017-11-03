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

if false; then
Message Queue
    在前面我们了解到Nova包含众多的子服务，这些子服务之间需要相互协调和通信。
    为了解耦各个子服务，Nova通过Message Queue作为子服务的信息中转站。
    MQ是OpenStack的核心基础组件。
fi

ps -e | grep nova

if false; then
14313 ?        00:07:42 nova-api
14347 ?        00:00:00 nova-api
14358 ?        00:04:00 nova-api
14359 ?        00:04:19 nova-api
14366 ?        00:00:33 nova-api
15225 ?        00:01:44 nova-novncproxy
15257 ?        00:04:11 nova-scheduler
15285 ?        00:02:50 nova-consoleaut
15289 ?        00:02:50 nova-cert
fi

#  nova service-list 查看 nova-* 子服务都分布在哪些节点上 
nova service-list

if false; then
+----+------------------+--------------------+---------------------------+---------+-------+----------------------------+-----------------+
| Id | Binary           | Host               | Zone                      | Status  | State | Updated_at                 | Disabled Reason |
+----+------------------+--------------------+---------------------------+---------+-------+----------------------------+-----------------+
| 1  | nova-cert        | ironic-compute     | internal                  | enabled | up    | 2017-11-03T05:13:12.000000 | -               |
| 4  | nova-consoleauth | ironic-compute     | internal                  | enabled | up    | 2017-11-03T05:13:12.000000 | -               |
| 7  | nova-scheduler   | ironic-compute     | internal                  | enabled | up    | 2017-11-03T05:13:12.000000 | -               |
| 10 | nova-compute     | scrumr1-computer-5 | cluster                   | enabled | up    | 2017-11-03T05:13:24.000000 | -               |
| 13 | nova-compute     | scrumr1-computer-7 | cluster                   | enabled | up    | 2017-11-03T05:13:27.000000 | -               |
| 16 | nova-compute     | scrumr1-computer-8 | a                         | enabled | up    | 2017-11-03T05:13:28.000000 | -               |
| 19 | nova-compute     | scrumr1-computer-6 | a                         | enabled | up    | 2017-11-03T05:13:16.000000 | -               |
| 22 | nova-compute     | scrumr1-computer-9 | default_availability_zone | enabled | up    | 2017-11-03T05:13:33.000000 | -               |
+----+------------------+--------------------+---------------------------+---------+-------+----------------------------+-----------------+
fi

# 从虚拟机创建流程看nova-* 子服务如何协同工作

if false; then
1、客户（可以是Openstack最终用户，也可以是其他程序）向API(nova-api)发送请求：“帮我创建一个虚拟机”
2、API对请求做一些必要处理后，向Messaging(RabbitMQ)发送了一条消息：“让Schedule创建一个虚拟机”
3、Scheduler(nova-scheduler)从Messaging获取到API发给它的消息，然后执行调度算法，从若干计算节点中选出节点 A
4、Scheduler向Messaging发送了一条消息：“在计算节点A上创建这个虚拟机”
5、计算节点A的Compute(nova-compute)从Messaging中获取到Scheduler发给它的消息，然后在本节点的Hypervisor上启动虚拟机
6、在虚机创建的过程中，Compute 如果需要查询或更新数据库信息，会通过 Messaging 向 Conductor（nova-conductor）发送消息，Conductor 负责数据库访问。
fi

if false; then
API前端服务
    每个OpenStack组件可能包含若干子服务，其中必定有一个API服务负责接收客户请求
    以 Nova 为例，nova-api 作为 Nova 组件对外的唯一窗口，向客户暴露 Nova 能够提供的功能。
    当客户需要执行虚机相关的操作，能且只能向 nova-api 发送 REST 请求。 这里的客户包括终端用户、命令行和 OpenStack 其他组件。 
    设计 API 前端服务的好处在于： 
        1. 对外提供统一接口，隐藏实现细节 
        2. API 提供 REST 标准调用服务，便于与第三方系统集成 
        3. 可以通过运行多个 API 服务实例轻松实现 API 的高可用，比如运行多个 nova-api 进程 
fi

if false; then
Scheduler 调度服务
    对于某项操作，如果有多个实体都能够完成任务，那么通常会有一个 scheduler 负责从这些实体中挑选出一个最合适的来执行操作。 
    在前面的例子中，Nova 有多个计算节点。 
    当需要创建虚机时，nova-scheduler 会根据计算节点当时的资源使用情况选择一个最合适的计算节点来运行虚机。 
    调度服务就好比是一个开发团队中的项目经理，当接到新的开发任务时，项目经理会评估任务的难度，考察团队成员目前的工作负荷和技能水平，然后将任务分配给最合适的开发人员。 
fi

if false; then
Worker工作服务
    调度服务只管分配任务，真正执行任务的是Worker工作服务。
    在Nova中，这个Worker就是nova-compute了。将Scheduler和Worker从职能上进行划分使得openstack非常容易扩展
        1、当计算资源不够了无法创建虚拟机，可以增加计算节点（增加Worker）
        2、当客户的请求量太大调度不过来时，可以增加Scheduler
fi

if false; then
Driver 框架
OpenStack 作为开放的 Infrastracture as a Service 云操作系统，支持业界各种优秀的技术。
这些技术可能是开源免费的，也可能是商业收费的。 
这种开放的架构使得 OpenStack 能够在技术上保持先进性，具有很强的竞争力，同时又不会造成厂商锁定（Lock-in）。
那 OpenStack 的这种开放性体现在哪里呢？ 一个重要的方面就是采用基于 Driver 的框架。 
以 Nova 为例，OpenStack 的计算节点支持多种 Hypervisor。 包括 KVM, Hyper-V, VMWare, Xen, Docker, LXC 等。 
fi
openstack endpoint show nova
if false; then
+--------------+-------------------------------------------+
| Field        | Value                                     |
+--------------+-------------------------------------------+
| adminurl     | http://172.16.92.32:8774/v2/%(tenant_id)s |
| enabled      | True                                      |
| group_by     | 1                                         |
| id           | abc76f826c6b49d393b5c15e73b00bec          |
| internalurl  | http://172.16.92.32:8774/v2/%(tenant_id)s |
| publicurl    | http://172.16.92.32:8774/v2/%(tenant_id)s |
| region       | BJPOC-REGION2                             |
| service_id   | 74165b6478a748208e2effcad051ae19          |
| service_name | nova                                      |
| service_type | compute                                   |
| type         | baremetal                                 |
| verbose_name | 比尔吉沃特                                 |
+--------------+-------------------------------------------+

客户端就可以将请求发送到 endponits 指定的地址，向 nova-api 请求操作。

Nova-api 对接收到的 HTTP API 请求会做如下处理：
1.	检查客户端传人的参数是否合法有效
2.	调用 Nova 其他子服务的处理客户端 HTTP 请求
3.	格式化 Nova 其他子服务返回的结果并返回给客户端
fi

if false; then
nova-conductor
nova-compute 需要获取和更新数据库中 instance 的信息。
但 nova-compute 并不会直接访问数据库，而是通过 nova-conductor 实现数据的访问。
这样做的原因：
1、更高的系统安全性
2、更好的系统伸缩性
fi

if false; then
nova-scheduler的调度机制和实现方法：即解决如何选择在哪个计算节点上启动instance的问题。
创建 Instance 时，用户会提出资源需求，例如 CPU、内存、磁盘各需要多少。
OpenStack 将这些需求定义在 flavor 中，用户只需要指定用哪个 flavor 就可以了。

Flavor 主要定义了 VCPU，RAM，DISK 和 Metadata 这四类。
nova-scheduler 会按照 flavor 去选择合适的计算节点。 
VCPU，RAM，DISK 比较好理解，而 Metatdata 比较有意思，我们后面会具体讨论。
在/etc/nova/nova.conf中，nova通过scheduler_dirver，scheduler_available_filters和scheduler_default_filters 这三个参数来配置 nova-scheduler。 

Filter scheduler
Filter scheduler是 nova-scheduler 默认的调度器，调度过程分为两步：
    1、通过过滤器(filter)选择满足条件的计算节点(运行nova-compute)
    2、通过权重计算(weighting)选择在最优(权重值最大)的计算节点上创建Instance。
Filter
当Filter scheduler需要执行调度操作时，会让filter对计算节点进行判断，filter返回True或者False。
Nova.conf中的scheduler_available_filters选项用于配置scheduler可用的filter，默认是所有nova自带的filter都可以用于过滤操作。
    scheduler_available_filters = nova.scheduler.filters.all_filters
另外还有一个选项 scheduler_default_filters，用于指定 scheduler 真正使用的 filter，默认值如下 
    scheduler_default_filters = RetryFilter, AvailabilityZoneFilter, RamFilter, DiskFilter, ComputeFilter, ComputeCapabilitiesFilter, ImagePropertiesFilter, ServerGroupAntiAffinityFilter, ServerGroupAffinityFilter
Filter scheduler将按照列表中的顺序依次过滤
    RetryFilter
    RetryFilter 的作用是刷掉之前已经调度过的节点。 
AvailabilityZoneFilter
    为提高容灾性和提供隔离服务，可以将计算节点划分到不同的Availability Zone中。
RamFilter
    RamFilter 将不能满足 flavor 内存需求的计算节点过滤掉。 
DiskFilter
    DiskFilter将不能满足flavor磁盘需求的计算节点过滤掉
CoreFilter
    CoreFilter将不能满足flavor vCPU需求的计算节点过滤掉。
ComputeFilter
    ComputeFilter 保证只有 nova-compute 服务正常工作的计算节点才能够被 nova-scheduler调度。
    ComputeFilter 显然是必选的 filter。
ComputeCapabilitiesFilter
    ComputeCapabilitiesFilter 根据计算节点的特性来筛选。
ImagePropertiesFilter
    ImagePropertiesFilter 根据所选 image 的属性来筛选匹配的计算节点。
fi