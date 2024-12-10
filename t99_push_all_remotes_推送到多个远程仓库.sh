#!/bin/bash

# 检查是否在git仓库中
if [ ! -d ".git" ]; then
    echo "错误: 当前目录不是一个git仓库."
    exit 1
fi

# 获取所有的git remote名称
remotes=$(git remote -v | awk '{print $1}' | sort -u)

# 遍历每个remote并推送
for remote in $remotes; do


    if [[ ${remote} == "github" ]]; then
        echo "遇到远程仓库 $remote 跳过该远程仓库_由于网络问题_不进行推送..."
        # NOTE 无奈之举_如果是github_有的时候由于网络问题_就不推送了
        continue
    fi

    echo "正在向远程仓库 $remote 推送所有分支..."
    git push --all  "$remote"
    git push --tags "$remote"
    if [ $? -ne 0 ]; then
        echo "错误: 推送 $remote 失败."
    else
        echo "成功: 推送 $remote 完成."
    fi
done

echo "所有远程仓库的推送操作已完成."

