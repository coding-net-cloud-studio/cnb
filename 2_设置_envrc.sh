# export PS1="\u@\H: "
# PS1="\u@\H: " bash

#!/bin/bash
# 修改提示符脚本

# 新的提示符格式
# export PS1="\u@\H: "

# linux配置./bashrc来修改PS1美化命令行提示符
# https://blog.csdn.net/qq_26039331/article/details/107709560
# export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;31m\][\T]\[\033[00m\]\[\033[01;32m\][\u]\[\033[00m\]\[\033[01;33m\][\#]\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# Ubuntu 修改 PS1 美化命令提示符
# https://www.jianshu.com/p/d4b905e76528
# export PS1="[${debian_chroot:+($debian_chroot)}\u@\h:\W][\#]\$"
# export PS1="[${debian_chroot:+($debian_chroot)}\u@\h:\W]\[\033[01;33m\][\#]\[\033[00m\]:\$"
export PS1="[${debian_chroot:+($debian_chroot)}\u@\h:[\033[01;32m\]\W\[\033[00m\]]\[\033[01;33m\][\#]\[\033[00m\]\$"
# [\033[01;32m\][\u]\[\033[00m\]
# [\033[01;32m\][\W]\[\033[00m\]

# 打印新的提示符格式,用于确认更改
echo "更新后的提示符格式为: $PS1"

# region
    # 具体的提示符,按分类含义如下:
    #   主要信息:
    #   /u 当前登录用户名
    #   /h 当前计算机名称(譬如ubuntu)
    #   /H 当前计算机的域名全程,譬如(ubuntu.ubuntu.com)
    #   /w 当前目录的完整路径.家目录会以~代替
    #   /W 利用basename取得工作目录名称,所以只会列出最后一个目录
    #   /,root用户为>
    #   时间显示
    #   /t 当前时间(24小时制,HH:MM:SS 分别代表 小时:分钟:秒)
    #   /T 当前时间(12小时制)
    #   /@ 当前时间(AM/PM显示)
    #   /d 当前日期
    #   Shell信息:
    #   /v Bash版本
    #   /V Bash的发布版本号
    #   /S Shell名称
    #   /! Bash命令的历史编号
    #   /j job序号
    #   /l Shell的终端名称

    # 作者:HongXunPan
    # 链接:https://www.jianshu.com/p/d4b905e76528
    # 来源:简书
    # 著作权归作者所有.商业转载请联系作者获得授权,非商业转载请注明出处.
# endregion

# ubuntu修改Bash命令行提示符
# https://www.cnblogs.com/hupeng1234/p/6736141.html
# export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
