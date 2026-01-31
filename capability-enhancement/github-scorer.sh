#!/bin/bash
# GitHub 项目质量评分器
# 根据标准评估搜索结果的质量

# 用法: ./github-scorer.sh "项目stars" "更新时间(天前)" "fork数" "issues数"

STARS=$1
DAYS_AGO=$2
FORKS=$3
ISSUES=$4

# 默认值（如果未提供）
STARS=${STARS:-0}
DAYS_AGO=${DAYS_AGO:-365}
FORKS=${FORKS:-0}
ISSUES=${ISSUES:-0}

# 计算各维度分数（满分100）

# Star 分数 (40分)
if [ $STARS -ge 10000 ]; then
    STAR_SCORE=40
elif [ $STARS -ge 5000 ]; then
    STAR_SCORE=35
elif [ $STARS -ge 1000 ]; then
    STAR_SCORE=25
elif [ $STARS -ge 500 ]; then
    STAR_SCORE=20
elif [ $STARS -ge 100 ]; then
    STAR_SCORE=15
else
    STAR_SCORE=10
fi

# 更新活跃度分数 (30分)
if [ $DAYS_AGO -le 7 ]; then
    UPDATE_SCORE=30
elif [ $DAYS_AGO -le 30 ]; then
    UPDATE_SCORE=25
elif [ $DAYS_AGO -le 90 ]; then
    UPDATE_SCORE=20
elif [ $DAYS_AGO -le 180 ]; then
    UPDATE_SCORE=15
elif [ $DAYS_AGO -le 365 ]; then
    UPDATE_SCORE=10
else
    UPDATE_SCORE=5
fi

# Fork 分数 (15分)
if [ $FORKS -ge 1000 ]; then
    FORK_SCORE=15
elif [ $FORKS -ge 500 ]; then
    FORK_SCORE=12
elif [ $FORKS -ge 100 ]; then
    FORK_SCORE=10
elif [ $FORKS -ge 50 ]; then
    FORK_SCORE=8
else
    FORK_SCORE=5
fi

# Issues 处理分数 (15分)
if [ $ISSUES -le 10 ]; then
    ISSUE_SCORE=15
elif [ $ISSUES -le 50 ]; then
    ISSUE_SCORE=12
elif [ $ISSUES -le 100 ]; then
    ISSUE_SCORE=10
elif [ $ISSUES -le 500 ]; then
    ISSUE_SCORE=7
else
    ISSUE_SCORE=5
fi

# 总分
TOTAL=$((STAR_SCORE + UPDATE_SCORE + FORK_SCORE + ISSUE_SCORE))

echo "=== GitHub 项目质量评分 ==="
echo "Star 分数:      $STAR_SCORE/40 ⭐"
echo "更新活跃度:     $UPDATE_SCORE/30 📅"
echo "Fork 分数:      $FORK_SCORE/15 🔀"
echo "Issues 处理:    $ISSUE_SCORE/15 🐛"
echo "---------------------------"
echo "总分:           $TOTAL/100"
echo ""

# 质量等级
if [ $TOTAL -ge 85 ]; then
    echo "质量等级: 🟢 优秀 - 强烈推荐"
elif [ $TOTAL -ge 70 ]; then
    echo "质量等级: 🔵 良好 - 推荐使用"
elif [ $TOTAL -ge 50 ]; then
    echo "质量等级: 🟡 一般 - 可作参考"
else
    echo "质量等级: 🔴 较弱 - 谨慎使用"
fi
