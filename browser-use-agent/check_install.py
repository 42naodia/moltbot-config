#!/usr/bin/env python3
"""
Moltbot 浏览器自动化工具配置和使用说明

## 安装状态
✅ browser-use 已安装
❌ 需要配置 LLM API Key 才能使用

## 可用的 LLM 选项

### 1. ChatBrowserUse（推荐用于浏览器自动化）
- 需要 BROWSER_USE_API_KEY
- 注册: https://cloud.browser-use.com/new-api-key
- 价格: $0.20/1M input tokens

### 2. OpenAI GPT-4
- 需要 OPENAI_API_KEY
- 配置: 
  export OPENAI_API_KEY="your-key"
  
### 3. Ollama（本地免费）
- 安装: curl -fsSL https://ollama.ai/install.sh | sh
- 启动: ollama serve
- 使用: ollama pull llama3.2

### 4. MiniMax（当前 Moltbot 使用）
- 需要 Moltbot API 支持
- 暂未集成到 browser-use

## 使用方法

### 基本用法
```bash
cd /home/admin/browser-use-agent

# 设置 API Key
export BROWSER_USE_API_KEY="your-api-key"

# 运行任务
./venv/bin/python browser_tool.py "打开 example.com"

# 带 JSON 输出
./venv/bin/python browser_tool.py "搜索 GitHub 热榜" --json
```

### 在 Moltbot 中使用
```python
# 需要集成开发
from browser_use import Agent, Browser
```

## 文件结构
browser-use-agent/
├── browser_tool.py      # 主工具脚本
├── pyproject.toml       # 项目配置
├── README.md           # 本说明文档
└── .venv/              # Python 虚拟环境
"""

import os
import sys

def check_installation():
    """检查安装状态"""
    print("=" * 50)
    print("Moltbot 浏览器自动化工具 - 安装检查")
    print("=" * 50)
    
    checks = []
    
    # 检查 Python 版本
    try:
        import sys
        version = sys.version_info
        if version.major >= 3 and version.minor >= 11:
            checks.append(("✅ Python 版本", f"{sys.version.split()[0]} (>=3.11)"))
        else:
            checks.append(("❌ Python 版本", f"{sys.version.split()[0]} (<3.11)"))
    except Exception as e:
        checks.append(("❌ Python 检查", f"错误: {e}"))
    
    # 检查 browser-use
    try:
        import importlib.metadata
        version = importlib.metadata.version("browser-use")
        checks.append(("✅ browser-use", f"v{version}"))
    except ImportError:
        checks.append(("❌ browser-use", "未安装"))
    
    # 检查 Playwright
    try:
        from playwright.sync_api import sync_playwright
        checks.append(("✅ Playwright", "已安装"))
    except ImportError:
        checks.append(("⚠️ Playwright", "建议安装: uv pip install playwright"))
    
    # 检查 API Key
    api_key = os.environ.get("BROWSER_USE_API_KEY") or os.environ.get("OPENAI_API_KEY")
    if api_key:
        checks.append(("✅ API Key", "已配置"))
    else:
        checks.append(("❌ API Key", "未配置"))
    
    # 打印检查结果
    for status, detail in checks:
        print(f"{status}: {detail}")
    
    print("=" * 50)
    
    return all("✅" in x[0] for x in checks)


def show_usage():
    """显示使用方法"""
    print("\n📖 使用方法:")
    print("-" * 50)
    print("1. 配置 API Key:")
    print("   export BROWSER_USE_API_KEY='your-key'")
    print()
    print("2. 运行任务:")
    print("   python browser_tool.py '你的任务描述'")
    print()
    print("3. 示例:")
    print("   python browser_tool.py '打开 example.com'")
    print("   python browser_tool.py '搜索 GitHub 热榜项目' --json")
    print()
    print("-" * 50)


if __name__ == "__main__":
    all_ok = check_installation()
    
    if not all_ok:
        show_usage()
        
        sys.exit(1 if not all_ok else 0)
