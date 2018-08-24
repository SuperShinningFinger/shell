# SHELL脚本

`#!/bin/bash`：放在第一行，指定解释器

`#`：注释

`chmod a+x`：授予a(all,所有人) x权限

`-rw-rw-r--  1 max max   36 8月  12 09:48 FirstShell.sh`：对文件创造者有前三个权限，对组内成员有中间三个权限，其余人有后三个权限

`｀pwd｀`：命令替换符，pwd可替代当前目录

`$`：变量

`:`：拼接字符串



参数：用$1,$2....表示，不包括0，传参时在sh后空格加变量



#### 特殊变量

`$0`：获取脚本文件名，包括路径

`$n`：获取脚本第n个参数

`$*`：所有参数合成字符串

`$#`：获取参数个数

`$@`：获取所有参数并保留空白

`$?`：上条语句的值



`${!word*}`:word开头的所有参数

`${!word@}`：word开头的所有参数，分条



`read`：输入 。option：-a , -d , -e ....

`echo`：输出。option：-e(开启转义)

`printf`：输出。printf    "%s"    "参数"





#### 函数定义

```shell
function 函数名{

	函数体

}  

函数名(){

    函数体

}

function 函数名（）｛

	函数体

｝
```

#### 流程控制

condition前后有两个空格，if开始，fi结束

```shell
#if 语句
if [[  condition  ]]; then
elif [[  condition  ]]; then
	else
fi


#for 循环
for xx in `seq 1 100`; do
	echo "123"
done


#C风格for 循环
for ((i = 0; i < 10; i++));do
	echo "123"
done

#while 循环
while [[  condition  ]];do
	echo "123"
done


#until 循环
until [[  condition  ]]; do
	echo "123"
done

#case 分支
case word in
	condition 1) echo "123" ;;
	condition 2) echo "123" ;;
	condition 3) echo "123" ;;
esac
```





#### 数组

shell数组可以定义１与５位置数组，其余不定义

`declare -a nam`或`name=(1 2 3)`:定义名字为name的数组

`${arry[*]}`:全部元素，@同理

`${#a[@]}`:长度

`${!a[@]}`:遍历下标

`arry+=(a b c)`:追加数组

`unset`：清空元素





`source`可用`.`替代，如`. .bash`





#### 配置vim

用`command W :w`可在`.vimrc`中为`:w`起别名







`source `放在脚本中可以当做Ｃ中 



#### ping

不带输出的ping写法：`        ping -c 2 -t 1 IP > /dev/null 2>&1`

`-c` 后面为尝试次数，`-t`后面为尝试时间，`/dev/null`与`/dev/zero`为特殊设备，重定向到这两个设备不会有输出。

`2>&1`是





#### dirname与basename

路径前缀与路径后缀



#### more与less

都是多页显示结果

区别在于`less`可以翻页,`more`不能翻页；

`less` 搜索有高亮，`more`没有



#### nl

选项众多，复习



####　head与tail





#### cat与tat







1. uid > 1000的用户为自己创建的用户
2. 判断管理员权限即判断groups中是否有sudo字符



邮件：脚本与脚本截图