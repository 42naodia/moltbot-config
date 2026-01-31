#!/usr/bin/env python3
"""
浏览器自动化工具测试
"""

import asyncio
import os

async def test_basic():
    """测试 browser-use 基本功能"""
    print("Testing browser-use installation...")
    
    try:
        from browser_use import Agent, Browser
        from browser_use.llm import ChatBrowserUse
        
        print("✓ browser-use imported successfully")
        
        # 尝试初始化浏览器
        browser = Browser()
        print("✓ Browser initialized")
        
        # 获取 LLM
        llm = ChatBrowserUse()
        print("✓ LLM (ChatBrowserUse) initialized")
        
        # 创建一个简单任务
        agent = Agent(
            task="Go to example.com and tell me what you see",
            llm=llm,
            browser=browser,
        )
        print("✓ Agent created")
        
        print("\nAll basic tests passed!")
        return True
        
    except Exception as e:
        print(f"✗ Error: {e}")
        return False


if __name__ == "__main__":
    asyncio.run(test_basic())
