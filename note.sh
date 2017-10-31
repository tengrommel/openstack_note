if false; then
1、sh  跟上SH脚本，直接运行。
2、chmod 给SH脚本加上X权限，然后直接输入SH脚本文件名，就可以运行。

我原来一直是这两种方法，没有碰见过错误，
你的问题，可以把脚本发出来，或把错误提示发来



sh  xxx
用 sh 这个shell  (sh一般指系统默认shell,比如 bash, ksh, Csh 等都有可能) 来解释和运行 xxx 这个脚本。xxx 文件不必具有可执行属性（chmod +x)

./xxx    xxx必须具备可执行属性，如果此时的 xxx 是一个文本文件（脚本），那么按照 xxx 的第一行所指定的命令来解释和执行 xxx， 如果xxx 文件中没有指定，默认按照 /bin/sh 来解释和执行。  xxx 需要在第一行用
#!/path/to/mmm   
的方法来说明要用 mmm 命令来解释和执行 自身。
比如如果是 bash 脚本，为  #!/bin/bash
perl脚本,  #!/usr/bin/perl
python脚本,  #!/usr/bin/python
fi

. .admin-openrc.sh

if false; then
.admin-openrc.sh文件的内容



fi
