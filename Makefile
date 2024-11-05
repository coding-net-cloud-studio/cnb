#!/usr/bin/make -f

# makefile中使用echo -e引发的思考(涉及dash和bash)
# https://blog.csdn.net/benkaoya/article/details/12410295
SHELL=/bin/bash

# 设置编译器
CC = gcc

# 设置编译选项和头文件路径
CFLAGS = -Wall -I./include

# 子目录列表
SUBDIRS = ch03 ch04 ch05 ch06 ch07 ch08 ch09 ch10 ch11 ch12 ch13 ch14 ch15 ch06/app ch07/app ch08/app ch13/app ch14/app

default: help

# 0_更新到最新版本
0_更新到最新版本:
	-@ [[ -f $$(which cloudstudio) ]] && git stash || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn wmstudy_cn           || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git switch wmstudy_cn || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git pull origin wmstudy_cn || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git switch cloudstudio_刚刚下拉 || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git pull origin wmstudy_cn || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git switch wmstudy_cn || exit 0

# 这里是 0_更新到最新版本 的便捷方式
0: 0_更新到最新版本

# 默认目标
23_build_all : $(SUBDIRS)

# 递归规则,用于遍历每个子目录并调用其 Makefile
$(SUBDIRS):
	$(MAKE) -C $@

# 清理目标
7_clean_all:
	for dir in $(SUBDIRS); do \
			$(MAKE) -C $$dir clean; \
	done

# 快捷名称
clean: 7_clean_all

# 通过git clean -xdf -n 查看构建了哪些_可执行文件
5_show:
	-@git clean -xdf -n

# 便捷名称
show: 5_show

# 使用bash执行脚本_安装一下需要用到的软件
12_init_for_cloudstudio_main:
	-@echo -e "$$(pwd)/Makefile wmtask_[12_init_for_cloudstudio]_目标_被运行\n"
	-@ [[ -f $$(which cloudstudio) ]] && git remote remove  origin  || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git remote add     origin https://cnb.cool/8888/c/linux_c.git || exit 0
	@# -@ [[ -f $$(which cloudstudio) ]] && git remote add     cnb    https://cnb.cool/8888/c/linux_c.git || exit 0
	@# -@ [[ -f $$(which cloudstudio) ]] && git remote add     github https://github.com/coding-net-cloud-studio/linux_c.git || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git checkout -b cloudstudio_刚刚下拉 || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && touch README.md
	-@ [[ -f $$(which cloudstudio) ]] && git add -A || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git commit -m "进入cloudstudio首次提交" || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git checkout -b cloudstudio_运行中 || exit 0
	@# -@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn cloudstudio_运行中    || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn cloudstudio_刚刚下拉  || exit 0
	-@ [[ -f $$(which cloudstudio) ]] && git branch --set-upstream-to=origin/wmstudy_cn wmstudy_cn           || exit 0
	-@bash ab10_wmscript_init_this.sh || exit 0
	-@make  23_build_all
	-@clear
	-@make help

12_init_for_cloudstudio: 12_init_for_cloudstudio_main 0_更新到最新版本
	-@clear
	-@make help

# 快捷名称
cs: 12_init_for_cloudstudio

# NOTE 这里给club增加一个独立的初始化快捷方式
# 这里仅仅安装几个构建apue需要用到的软件与库文件
install_lib_for_club:
	-@ [[ -f $$(which cloudstudio) ]] && echo "cloudstudio 已经安装" || echo "cloudstudio 未安装 无需执行_本目标"
	-@ [[ -f $$(which cloudstudio) ]] && apt update && apt install -y libbsd-dev libgdbm-dev libgdbm-compat-dev libmysqlclient-dev electric-fence || echo "cloudstudio 未安装 无需执行_本目标"

# 快捷名称
11_install_lib_for_club: install_lib_for_club

# 快捷名称
club: install_lib_for_club

ab08_install_vscode_extensions:
	-@clear
	-@ [[ -f $$(which cloudstudio) ]] && bash ab10_wmscript_init_this.sh f27_38_install_some_vs_ext_quick || exit 0


8_安装本仓库需要用的vscode扩展: ab08_install_vscode_extensions

vscode: 8_安装本仓库需要用的vscode扩展

.PHONY: vscode 8_安装本仓库需要用的vscode扩展 ab08_install_vscode_extensions

.PHONY: 0_更新到最新版本 0

# 定义伪目标,防止 make 时没有指定目标而报错
.PHONY: 23_build_all clean $(SUBDIRS) 5_show show setup 7_clean_all

.PHONY: help

.PHONY: 12_init_for_cloudstudio_main

.PHONY: install_lib_for_club 11_install_lib_for_club 12_init_for_cloudstudio cs club

# help:
# 	@echo "Makefile 帮助信息:"
# 	@echo ""
# 	@echo "可用的构建目标:"
# 	@echo "  0_更新到最新版本            : 与git仓库同步最新内容(首先执行这里)"
# 	@echo "  23_build_all              : 构建项目(默认) "
# 	@echo "  11_install_lib_for_club   : 本目标只是在club教程中运行_快速安装构建需要用到的几个库"
# 	@echo "  12_init_for_cloudstudio   : 本目标只是在cloudstudio工作空间中运行_只需要运行1次就可以了"
# 	@echo "  5_show                    : 通过git clean -xdf -n 查看构建了哪些_可执行文件 "
# 	@echo "  7_clean_all               : 清理生成的文件"
# 	@echo "  help                      : 显示此帮助信息"
# 	@echo ""
# 	@echo "示例命令:"
# 	@echo "  make: 构建项目"
# 	@echo "  make  7_clean_all         : 清理生成的文件"
# 	@echo "  make  help                : 显示此帮助信息"

help:
	@echo "Makefile 帮助信息:"
	@echo ""
	@echo "0_更新到最新版本"
	@echo "    : 与git仓库同步最新内容(首先执行这里)"
	@echo "23_build_all"
	@echo "    : 构建项目"
	@echo "11_install_lib_for_club"
	@echo "    : 本目标只是在club教程中运行"
	@echo "      快速安装构建需要用到的几个库"
	@echo "12_init_for_cloudstudio"
	@echo "    :本目标只在cloudstudio空间中运行"
	@echo "     只需要运行1次就可以了"
	@echo " 5_show"
	@echo "   : 通过git clean -xdf -n"
	@echo "     查看构建了哪些_可执行文件"
	@echo " 7_clean_all"
	@echo "   : 清理生成的文件"
	@echo " 8_安装本仓库需要用的vscode扩展"
	@echo "   : 安装本仓库需要用的vscode扩展"
	@echo " help"
	@echo "   : 显示此帮助信息"
	@echo ""
	@echo "示例命令:"
	@echo " make: 构建项目"
	@echo " make  7_clean_all"
	@echo "         : 清理生成的文件"
	@echo " make  help"
	@echo "       : 显示此帮助信息"


