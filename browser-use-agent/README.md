# Moltbot 浏览器自动化工具

## 项目状态

✅ **browser-use 已安装** (v0.11.5)  
❌ **需要配置 LLM API Key 才能使用**

## 快速开始

### 1. 配置 API Key

选择以下 LLM 之一：

#### ChatBrowserUse（推荐用于浏览器自动化）
```bash
export BROWSER_USE_API_KEY="your-api-key"
```
注册: https://cloud.browser-use.com/new-api-key

#### OpenAI GPT-4
```bash
export OPENAI_API_KEY="your-openai-key"
```

#### Ollama（本地免费）
```bash
# 安装 Ollama
curl -fsSL https://ollama.ai/install.sh | sh
ollama serve
ollama pull llama3.2
```

### 2. 运行任务

```bash
cd /home/admin/browser-use-agent

# 基本用法
./venv/bin/python browser_tool.py "打开 example.com"

# JSON 输出
./venv/bin/python browser_tool.py "搜索 GitHub 热榜" --json

# 显示浏览器窗口
./venv/bin/python browser_tool.py "填写这个表单" --headed
```

### 3. 检查安装状态

```bash
./venv/bin/python check_install.py
```

## 文件结构

```
browser-use-agent/
├── browser_tool.py      # 主工具脚本
├── check_install.py     # 安装检查
├── pyproject.toml       # 项目配置
└── README.md            # 本说明文档
```

## 功能特性

### 已支持的功能
- ✅ 打开网页
- ✅ 点击元素
- ✅ 输入文字
- ✅ 滚动页面
- ✅ 截图
- ✅ 表单填写
- ✅ 信息搜索
- ✅ 数据采集

### 待配置
- 🔒 需要 API Key
- 🔒 需要安装 Playwright 浏览器

## 在 Moltbot 中使用

需要后续集成开发，将 browser-use 集成到 Moltbot 的工具系统中。

## 相关链接

- [browser-use GitHub](https://github.com/browser-use/browser-use)
- [browser-use 文档](https://docs.browser-use.com)
- [Moltbot 配置仓库](https://github.com/42naodia/moltbot-config)
