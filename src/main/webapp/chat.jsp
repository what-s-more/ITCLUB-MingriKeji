<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DeepSeek 聊天助手</title>
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4caf50;
            --error-color: #f44336;
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            /* 设置背景图片 */
            background: url('images/bg.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        header {
            background: linear-gradient(120deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
            text-align: center;
            position: relative; /* 允许内部元素绝对定位 */
        }
        
        header h1 {
            font-size: 2.2rem;
            margin-bottom: 10px;
        }

        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }
        
        .chat-container {
            padding: 20px;
            min-height: 400px;
            max-height: 600px;
            overflow-y: auto;
            border-bottom: 1px solid #eee;
        }
        
        .message {
            margin-bottom: 15px;
            padding: 12px 15px;
            border-radius: 18px;
            max-width: 80%;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .user-message {
            background-color: #e3f2fd;
            margin-left: auto;
            border-bottom-right-radius: 5px;
        }
        
        .ai-message {
            background-color: #f0f4f8;
            margin-right: auto;
            border-bottom-left-radius: 5px;
        }
        
        .message-header {
            font-weight: bold;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
        }
        
        .message-header i {
            margin-right: 8px;
        }
        
        .input-area {
            display: flex;
            padding: 15px;
            background-color: #f8f9fa;
        }
        
        #userInput {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 30px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s;
        }
        
        #userInput:focus {
            border-color: var(--primary-color);
        }
        
        #sendBtn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 12px 25px;
            margin-left: 10px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        #sendBtn:hover {
            background-color: var(--secondary-color);
        }
        
        #sendBtn:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        
        .status {
            text-align: center;
            padding: 10px;
            color: #666;
            font-size: 0.9rem;
        }
        
        .error {
            background-color: #ffebee;
            color: var(--error-color);
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
            text-align: center;
        }
        
        .typing-indicator {
            display: flex;
            padding: 10px 15px;
        }
        
        .typing-indicator span {
            height: 8px;
            width: 8px;
            float: left;
            margin: 0 1px;
            background-color: #9E9EA1;
            display: block;
            border-radius: 50%;
            opacity: 0.4;
        }
        
        .typing-indicator span:nth-of-type(1) {
            animation: typing 1s infinite;
        }
        
        .typing-indicator span:nth-of-type(2) {
            animation: typing 1s infinite 0.2s;
        }
        
        .typing-indicator span:nth-of-type(3) {
            animation: typing 1s infinite 0.4s;
        }
        
        @keyframes typing {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); opacity: 1; }
        }
        
        @media (max-width: 600px) {
            .container {
                margin: 10px;
            }
            
            .message {
                max-width: 90%;
            }
            
            .input-area {
                flex-direction: column;
            }
            
            #sendBtn {
                margin-left: 0;
                margin-top: 10px;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <button class="back-button" onclick="window.history.back();">返回</button>
            <h1>DeepSeek 聊天助手</h1>
            <p>基于 Java Servlet 的 AI 对话系统</p>
        </header>
        
        <div class="chat-container" id="chatContainer">
            <div class="message ai-message">
                <div class="message-header">
                    <i>🤖</i> DeepSeek 助手
                </div>
                <div>您好！我是 DeepSeek 智能助手，有什么可以帮您的？</div>
            </div>
        </div>
        
        <div class="input-area">
            <input type="text" id="userInput" placeholder="输入您的问题..." autocomplete="off">
            <button id="sendBtn">发送</button>
        </div>
        
        <div class="status" id="status"></div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const chatContainer = document.getElementById('chatContainer');
            const userInput = document.getElementById('userInput');
            const sendBtn = document.getElementById('sendBtn');
            const status = document.getElementById('status');
            
            // 添加用户消息
            function addUserMessage(message) {
			    const messageDiv = document.createElement('div');
			    messageDiv.className = 'message user-message';
			    // 用字符串拼接调用JavaScript的escapeHtml函数，JSP不会解析
			    messageDiv.innerHTML = `
			        <div class="message-header">
			            <i>👤</i> 用户
			        </div>
			        <div>` + escapeHtml(message) + `</div>  <!-- 字符串拼接，直接调用JS函数 -->
			    `;
			    chatContainer.appendChild(messageDiv);
			    chatContainer.scrollTop = chatContainer.scrollHeight;
			}
            
            // 添加AI消息
            function addAIMessage(message) {
                const messageDiv = document.createElement('div');
                messageDiv.className = 'message ai-message';
                messageDiv.innerHTML = `
                    <div class="message-header">
                        <i>🤖</i> DeepSeek 助手
                    </div>
                    <div>` + formatResponse(message) + `</div>
                `;
                chatContainer.appendChild(messageDiv);
                chatContainer.scrollTop = chatContainer.scrollHeight;
            }
            
            // 显示加载指示器
            function showTypingIndicator() {
                const typingDiv = document.createElement('div');
                typingDiv.className = 'typing-indicator';
                typingDiv.id = 'typingIndicator';
                typingDiv.innerHTML = `
                    <span></span>
                    <span></span>
                    <span></span>
                    <span>正在思考中...</span>
                `;
                chatContainer.appendChild(typingDiv);
                chatContainer.scrollTop = chatContainer.scrollHeight;
            }
            
            // 隐藏加载指示器
            function hideTypingIndicator() {
                const typingIndicator = document.getElementById('typingIndicator');
                if (typingIndicator) {
                    typingIndicator.remove();
                }
            }
            
            // 显示错误
            function showError(message) {
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error';
                errorDiv.textContent = message;
                status.appendChild(errorDiv);
                setTimeout(() => errorDiv.remove(), 5000);
            }
            
            // 发送消息到后端
            async function sendMessage() {
                const message = userInput.value.trim();
                if (!message) return;
                
                addUserMessage(message);
                userInput.value = '';
                sendBtn.disabled = true;
                showTypingIndicator();
                try {
                    const response = await fetch('deepseek/chat', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ message })
                    });
                    if (!response.ok) {
                        throw new Error(`请求失败: ${response.status}`);
                    }
                    
                    const data = await response.json();
                    hideTypingIndicator();
                    addAIMessage(data.response);
                } catch (error) {
                    hideTypingIndicator();
                    showError(`错误: ${error.message}`);
                    console.error('API请求错误:', error);
                } finally {
                    sendBtn.disabled = false;
                    userInput.focus();
                }
            }
            
            // 事件监听
            sendBtn.addEventListener('click', sendMessage);
            userInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && !sendBtn.disabled) {
                    sendMessage();
                }
            });
            // HTML转义
            function escapeHtml(text) {
                return text
                    .replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;")
                    .replace(/'/g, "&#039;");
            }
            
            // 格式化响应
            function formatResponse(text) {
			    let formatted = text.replace(/```(\w+)?\n([\s\S]*?)```/g, (match, lang, code) => {
			        // 转义HTML特殊字符
			        const escapedCode = code.trim()
			            .replace(/&/g, "&amp;")
		                    .replace(/</g, "&lt;")
		                    .replace(/>/g, "&gt;")
		                    .replace(/"/g, "&quot;")
		                    .replace(/'/g, "&#039;");
			        
			        const formattedCode = escapedCode.replace(/\n/g, '<br>');
			        return `<pre><code>${formattedCode}</code></pre>`;
			    });
			    
			    // 2. 处理普通换行符（不在代码块内的）
			    formatted = formatted.replace(/\n/g, '<br>');
			    
			    // 3. 处理粗体
			    formatted = formatted.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
			    
			    // 4. 处理其他格式...
			    
			    return formatted;
			}
        });
    </script>
</body>
</html>