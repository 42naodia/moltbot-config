#!/usr/bin/env python3
"""
Moltbot 浏览器自动化工具
通过自然语言让 AI 控制浏览器执行任务

用法:
    python browser_tool.py "任务描述" [--cloud]

示例:
    python browser_tool.py "打开 example.com"
    python browser_tool.py "搜索 GitHub 上的热门项目" --cloud
"""

import asyncio
import json
import os
import sys
import argparse

from browser_use import Agent, Browser, ChatBrowserUse


async def run_browser_task(task: str, use_cloud: bool = False, headless: bool = True):
    """
    执行浏览器任务
    
    Args:
        task: 自然语言描述的任务
        use_cloud: 是否使用云端 Stealth 浏览器
        headless: 是否无头模式运行
    
    Returns:
        dict: 执行结果
    """
    result = {
        "task": task,
        "success": False,
        "error": None,
        "output": None,
    }
    
    try:
        # 初始化浏览器
        browser = Browser(
            use_cloud=use_cloud,
            headless=headless,
        )
        
        # 初始化 LLM
        llm = ChatBrowserUse()
        
        # 创建 Agent
        agent = Agent(
            task=task,
            llm=llm,
            browser=browser,
        )
        
        # 执行任务
        history = await agent.run()
        
        result["success"] = True
        result["output"] = str(history)
        
    except Exception as e:
        result["error"] = str(e)
    
    return result


def main():
    """CLI 入口"""
    parser = argparse.ArgumentParser(
        description="Moltbot 浏览器自动化工具"
    )
    parser.add_argument(
        "task",
        type=str,
        help="要执行的任务（自然语言描述）"
    )
    parser.add_argument(
        "--cloud",
        action="store_true",
        help="使用云端 Stealth 浏览器（需要 API Key）"
    )
    parser.add_argument(
        "--headed",
        action="store_true",
        help="显示浏览器窗口（默认无头模式）"
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="JSON 格式输出"
    )
    
    args = parser.parse_args()
    
    # 运行任务
    result = asyncio.run(
        run_browser_task(
            task=args.task,
            use_cloud=args.cloud,
            headless=not args.headed
        )
    )
    
    # 输出结果
    if args.json:
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        if result["success"]:
            print(f"✅ 任务完成: {args.task}")
            print(f"结果: {result['output'][:500]}...")
        else:
            print(f"❌ 任务失败: {args.task}")
            print(f"错误: {result['error']}")


if __name__ == "__main__":
    main()
