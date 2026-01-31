#!/bin/bash
# 信息分析关键词生成器
# 根据用户需求生成多组搜索词

# 用法: ./keyword-generator.sh "用户需求"

INPUT="$1"

echo "=== 关键词生成报告 ==="
echo "输入需求: $INPUT"
echo ""

# 核心词提取（简化版：提取输入中的关键名词）
echo "建议搜索词组合:"
echo ""

# 技术类关键词组合
echo "1. 技术/代码类:"
echo "   - $INPUT github"
echo "   - $INPUT python"
echo "   - $INPUT crawler OR scraper"
echo ""

# 中文关键词组合
echo "2. 中文平台:"
echo "   - $INPUT 知乎"
echo "   - $INPUT 小红书"
echo "   - $INPUT github 中文"
echo ""

# 英文扩展
echo "3. 英文扩展:"
echo "   - $INPUT tutorial"
echo "   - $INPUT best practices"
echo "   - $INPUT open source"
echo ""

# API相关
echo "4. API/接口类:"
echo "   - $INPUT API"
echo "   - $INPUT REST API"
echo "   - $INPUT endpoint"
echo ""

echo "=== 建议验证方向 ==="
echo "- 优先查看 GitHub stars > 100 的项目"
echo "- 检查最近更新时间（3个月内为佳）"
echo "- 交叉验证：至少查看3个不同来源"
