#!/bin/bash
# 信息验证检查清单
# 对获取的信息进行多维度验证

# 用法: ./info-validator.sh "信息来源" "发布时间" "作者"

SOURCE=$1
DATE=$2
AUTHOR=$3

echo "=== 信息验证报告 ==="
echo "信息来源: $SOURCE"
echo "发布时间: ${DATE:-未知}"
echo "作者/机构: ${AUTHOR:-未知}"
echo ""

# 检查项
echo "--- 验证清单 ---"

# 1. 信息源权威性
echo ""
echo "1. 信息源权威性检查:"
if [[ "$SOURCE" == *"github.com"* ]]; then
    echo "   ✅ GitHub 平台 - 权威代码/项目平台"
elif [[ "$SOURCE" == *"zhihu.com"* ]]; then
    echo "   ⚠️  知乎 - 需要检查作者背景"
elif [[ "$SOURCE" == *"juejin.cn"* ]]; then
    echo "   ✅ 掘金 - 技术社区，较为权威"
elif [[ "$SOURCE" == *"medium.com"* ]]; then
    echo "   ⚠️  Medium - 需要检查作者背景"
else
    echo "   ❓ 未知来源，需要进一步验证"
fi

# 2. 时效性检查
echo ""
echo "2. 时效性检查:"
if [ -z "$DATE" ]; then
    echo "   ❌ 缺少发布时间，无法判断时效性"
else
    # 简化判断：假设DATE格式为 YYYY-MM-DD
    CURRENT_YEAR=$(date +%Y)
    YEAR_FROM_DATE=$(echo $DATE | cut -d'-' -f1)
    YEARS_AGO=$((CURRENT_YEAR - YEAR_FROM_DATE))
    
    if [ $YEARS_AGO -eq 0 ]; then
        echo "   ✅ 内容发布于今年，时效性良好"
    elif [ $YEARS_AGO -eq 1 ]; then
        echo "   ✅ 内容发布于去年，时效性尚可"
    elif [ $YEARS_AGO -le 2 ]; then
        echo "   ⚠️  内容发布于${YEARS_AGO}年前，部分信息可能过时"
    else
        echo "   ❌ 内容发布于${YEARS_AGO}年前，很可能已经过时"
    fi
fi

# 3. 交叉验证建议
echo ""
echo "3. 交叉验证建议:"
echo "   - 在 GitHub 上搜索相关关键词，对比多个项目"
echo "   - 查看项目的 Issues 和 Pull Requests，了解真实使用情况"
echo "   - 搜索其他平台（如知乎、Stack Overflow）是否有相关讨论"
echo "   - 检查是否有官方文档或权威媒体的报道"

# 4. 局限性标注
echo ""
echo "4. 信息局限性:"
echo "   ⚠️  本次验证仅基于公开可获得的信息"
echo "   ⚠️  未验证信息的准确性和完整性"
echo "   ⚠️  建议结合具体使用场景进行二次验证"

# 5. 置信度评估
echo ""
echo "5. 置信度评估:"
echo "   🔸 如果以上检查全部通过: 高置信度"
echo "   🔸 如果有1-2项警示: 中等置信度"
echo "   🔸 如果有多项问题: 低置信度，建议寻找其他来源"
