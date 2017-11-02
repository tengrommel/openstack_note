if false; then
作为Openstack的基础支持服务，Keystone做下面这几件事情
    1、管理用户及其权限
    2、维护OpenStack Services的Endpoint
    3、Authentication(认证)和Authorizon(鉴权)
fi

if false; then
keystone中的概念
User
User指代任何使用Openstack的实体，可以是真正的用户，其他系统或者服务。

Credentials
Credentials是用户用来证明自己身份的信息，可以是：
    1、用户名/密码
    2、Token
    3、API key
    4、其他高级方式

Authentication
Authentication是Keystone验证User身份的过程
User访问OpenStack时向Keystone提交用户名和密码形式的Credentials，Keystone 验证通过后会给 User 签发一个 Token 作为后续访问的 Credential。

Token
Token是由数字和字母组成的字符串，User成功Authentication后由Keyston分配给User。
    1、Token用做访问Service的Credential
    2、Service会通过Keystone验证Token的有效性
    3、Token的有效期默认是24小时

Project
Project用于将Openstack的资源（计算、存储和网络）进行分组和隔离。
根据OpenStack服务的对象不同，Project可以不是一个客户（公有云，也叫租户）、部门或者项目组（私有云）。

Service
Openstack的Service包括Compute(Nove)、Block Storage(Cinder)、Object Storage(Swift)、Image Service(Glance)、Networking Service(Neutron)等
每个Service都会提供若干Endpoint, User通过Endpoint访问资源和执行操作。

Endpoint
    Endpoint是一个网络上可访问的地址，通常是一个URL。
    Service通过Endpoint暴露自己的API。
    Keystone负责管理和维护每个Service的End。
fi

openstack catalog list

if false; then
+------------------+-------------------------+-----------------------------------------------------------------------------+
| Name             | Type                    | Endpoints                                                                   |
+------------------+-------------------------+-----------------------------------------------------------------------------+
| cloudkitty       | rating                  | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8889                                       |
|                  |                         |   internalURL: http://172.16.92.30:8889                                     |
|                  |                         |   adminURL: http://172.16.92.30:8889                                        |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:8889                                       |
|                  |                         |   internalURL: http://172.16.92.32:8889                                     |
|                  |                         |   adminURL: http://172.16.92.32:8889                                        |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8889                                       |
|                  |                         |   internalURL: http://172.16.92.13:8889                                     |
|                  |                         |   adminURL: http://172.16.92.13:8889                                        |
|                  |                         |                                                                             |
| clog             | clog                    | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:9898/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.30:9898/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.30:9898/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:9898/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.32:9898/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.32:9898/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:9898/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.13:9898/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.13:9898/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         |                                                                             |
| nova             | compute                 | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8774/v2/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.30:8774/v2/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.30:8774/v2/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:8774/v2/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.32:8774/v2/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.32:8774/v2/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8774/v2/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.13:8774/v2/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.13:8774/v2/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         |                                                                             |
| neutron          | network                 | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:9696                                       |
|                  |                         |   internalURL: http://172.16.92.30:9696                                     |
|                  |                         |   adminURL: http://172.16.92.30:9696                                        |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.30:9696                                       |
|                  |                         |   internalURL: http://172.16.92.30:9696                                     |
|                  |                         |   adminURL: http://172.16.92.30:9696                                        |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:9696                                       |
|                  |                         |   internalURL: http://172.16.92.13:9696                                     |
|                  |                         |   adminURL: http://172.16.92.13:9696                                        |
|                  |                         |                                                                             |
| cinderv2         | volumev2                | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8776/v2/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.30:8776/v2/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.30:8776/v2/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8776/v2/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.13:8776/v2/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.13:8776/v2/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         |                                                                             |
| trove            | database                | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://t-svc:8779/v1.0/253a9e23972f4e7ba6fa8a17249b8053        |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://t-svc:8779/v1.0/253a9e23972f4e7ba6fa8a17249b8053        |
|                  |                         |                                                                             |
| glance           | image                   | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:9292                                       |
|                  |                         |   internalURL: http://172.16.92.30:9292                                     |
|                  |                         |   adminURL: http://172.16.92.30:9292                                        |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:9292                                       |
|                  |                         |   internalURL: http://172.16.92.32:9292                                     |
|                  |                         |   adminURL: http://172.16.92.32:9292                                        |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:9292                                       |
|                  |                         |   internalURL: http://172.16.92.13:9292                                     |
|                  |                         |   adminURL: http://172.16.92.13:9292                                        |
|                  |                         |                                                                             |
| ceilometer       | metering                | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8777                                       |
|                  |                         |   internalURL: http://172.16.92.30:8777                                     |
|                  |                         |   adminURL: http://172.16.92.30:8777                                        |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:8777                                       |
|                  |                         |   internalURL: http://172.16.92.32:8777                                     |
|                  |                         |   adminURL: http://172.16.92.32:8777                                        |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8777                                       |
|                  |                         |   internalURL: http://172.16.92.13:8777                                     |
|                  |                         |   adminURL: http://172.16.92.13:8777                                        |
|                  |                         |                                                                             |
| heat-cfn         | cloudformation          | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8000/v1                                    |
|                  |                         |   internalURL: http://172.16.92.30:8000/v1                                  |
|                  |                         |   adminURL: http://172.16.92.30:8000/v1                                     |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8000/v1                                    |
|                  |                         |   internalURL: http://172.16.92.13:8000/v1                                  |
|                  |                         |   adminURL: http://172.16.92.13:8000/v1                                     |
|                  |                         |                                                                             |
| cinder           | volume                  | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8776/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.30:8776/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.30:8776/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8776/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.13:8776/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.13:8776/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         |                                                                             |
| ironic           | baremetal               | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:6385                                       |
|                  |                         |   internalURL: http://172.16.92.32:6385                                     |
|                  |                         |   adminURL: http://172.16.92.32:6385                                        |
|                  |                         |                                                                             |
| heat             | orchestration           | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:8004/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.30:8004/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.30:8004/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://172.16.92.13:8004/v1/253a9e23972f4e7ba6fa8a17249b8053   |
|                  |                         |   internalURL: http://172.16.92.13:8004/v1/253a9e23972f4e7ba6fa8a17249b8053 |
|                  |                         |   adminURL: http://172.16.92.13:8004/v1/253a9e23972f4e7ba6fa8a17249b8053    |
|                  |                         |                                                                             |
| sahara           | data-processing         | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://t-svc:8386/v1.1/253a9e23972f4e7ba6fa8a17249b8053        |
|                  |                         | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://t-svc:8386/v1.1/253a9e23972f4e7ba6fa8a17249b8053        |
|                  |                         | BJPOC-REGION3                                                               |
|                  |                         |   publicURL: http://t-svc:8386/v1.1/253a9e23972f4e7ba6fa8a17249b8053        |
|                  |                         |                                                                             |
| ironic-inspector | baremetal-introspection | BJPOC-REGION2                                                               |
|                  |                         |   publicURL: http://172.16.92.32:5050                                       |
|                  |                         |   internalURL: http://172.16.92.32:5050                                     |
|                  |                         |   adminURL: http://172.16.92.32:5050                                        |
|                  |                         |                                                                             |
| keystone         | identity                | BJPOC-REGION1                                                               |
|                  |                         |   publicURL: http://172.16.92.30:5000/v2.0                                  |
|                  |                         |   internalURL: http://172.16.92.30:5000/v2.0                                |
|                  |                         |   adminURL: http://172.16.92.30:35357/v2.0                                  |
|                  |                         |                                                                             |
+------------------+-------------------------+-----------------------------------------------------------------------------+
fi

if false; then
Role
    安全包括两部分： Authentication(认证)和Authorization(鉴权)
    Authentication 解决的是“你是谁？”的问题 Authorization 解决的是“你能干什么？”的问题
    Keystone是借助Role来实现Authentication的：
        1.Keystone定义Role
+----------------------------------+------------------+
| ID                               | Name             |
+----------------------------------+------------------+
| 32ba9a9a1c6748c5bc9c6263ce8c1551 | heat_stack_user  |
| 3a30a32376a746dfa3e3b11762f7ee39 | admin            |
| 9fe2ff9ee4384b1894a90878d3e92bab | _member_         |
| ded206f3060f4163b7d1e4da089c630d | heat_stack_owner |
| e55a202d8012497aafc4c10ca72ab82f | rating           |
+----------------------------------+------------------+
fi

if false; then
什么是JWT
    Json web token (JWT), 是为了在网络应用环境间传递声明而执行的一种基于JSON的开放标准（(RFC 7519).
    该token被设计为紧凑且安全的，特别适用于分布式站点的单点登录（SSO）场景

基于token的鉴权机制
    基于token的鉴权机制类似于http协议也是无状态的，它不需要在服务端去保留用户的认证信息或者会话信息。
    这就意味着基于token认证机制的应用不需要去考虑用户在哪一台服务器登录了，这就为应用的扩展提供了便利。

流程上是这样的
    用户使用用户名密码来请求服务器
    服务器进行验证用户的信息
    服务器通过验证发送给用户一个token
    客户端存储token，并在每次请求时附送上这个token值
    服务端验证token值，并返回数据
这个token必须要在每次请求时传递给服务端，它应该保存在请求头里，另外，服务端要支持CORS（跨来源资源共享）策略，
一般我们在服务端这么做就可以了Access-Control-Allow-Origin。
fi