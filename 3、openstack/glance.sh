if false; then
理解Image
云环境下需要更高效的解决方案，这就是 Image。
Image 是一个模板，里面包含了基本的操作系统和其他的软件。

举例来说，有家公司需要为每位员工配置一套办公用的系统，一般需要一个 Win7 系统再加 MS office 软件。
    1、先手工安装好一个虚拟机
    2、然后对虚拟机执行snapshot，这样就得到了一个image
    3、当有新员工入职需要办公环境时，立马启动一个或多个该image的instance(虚拟机)就可以了

理解 Image Service
Image Service 的功能是管理 Image，让用户能够发现、获取和保存 Image。

在 OpenStack 中，提供 Image Service 的是 Glance，其具体功能如下：

    1、提供 REST API 让用户能够查询和获取 image 的元数据和 image 本身
    2、支持多种方式存储 image，包括普通的文件系统、Swift、Amazon S3 等
    3、对 Instance 执行 Snapshot 创建新的 image

    glance image-list
    glance image-delete id
fi

glance image-create
glance image-delete
glance image-update
glance image-list
glance image-show
# neutron 管理的是子网和网络
neutron net-create
neutron net-list
neutron net-update
neutron net-show
neutron net-delete

neutron subnet-create
neutron subnet-delete
neutron subnet-list
neutron subnet-show

