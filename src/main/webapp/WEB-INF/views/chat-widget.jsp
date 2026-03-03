<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- Chat widget -->
    <div id="chat-widget"
        style="position: fixed; bottom: 20px; right: 20px; width: 320px; background: white; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.2); font-family: 'Segoe UI', sans-serif; z-index: 1000; overflow: hidden;">
        <div style="background: #4cae4f; color: white; padding: 12px 15px; font-weight: bold; cursor: pointer; display: flex; justify-content: space-between; align-items: center;"
            onclick="toggleChat()">
            <span>💬 Hỗ trợ trực tuyến AI</span>
            <span id="chat-toggle-icon">−</span>
        </div>
        <div id="chat-body" style="display: block;">
            <div id="chat-messages"
                style="padding: 15px; height: 280px; overflow-y: auto; background-color: #fafafa; display: flex; flex-direction: column; gap: 10px;">
                <div
                    style="background: #e9ecef; color: #333; padding: 8px 12px; border-radius: 15px; align-self: flex-start; max-width: 80%;">
                    Xin chào! Tôi là trợ lý ảo Nông Sản Việt. Tôi có thể giúp gì cho bạn?
                </div>
                <%-- Loop messages if available in session/request --%>
            </div>
            <form id="chat-form" onsubmit="submitChat(event)"
                style="padding: 10px; border-top: 1px solid #eee; display: flex; align-items: center; background: white;">
                <input type="text" id="chat-input" name="message" placeholder="Nhập tin nhắn..."
                    style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 20px; outline: none;"
                    required>
                <button type="submit"
                    style="background: #4cae4f; color: white; border: none; width: 35px; height: 35px; border-radius: 50%; margin-left: 8px; cursor: pointer; display: flex; align-items: center; justify-content: center;">
                    ➤
                </button>
            </form>
        </div>
    </div>

    <script>
        function toggleChat() {
            var body = document.getElementById("chat-body");
            var icon = document.getElementById("chat-toggle-icon");
            if (body.style.display === "none") {
                body.style.display = "block";
                icon.innerText = "−";
            } else {
                body.style.display = "none";
                icon.innerText = "+";
            }
        }

        async function submitChat(event) {
            event.preventDefault(); // Prevent standard form submission

            var input = document.getElementById("chat-input");
            var message = input.value.trim();
            if (!message) return;

            var messagesDiv = document.getElementById("chat-messages");

            // Append user message
            var userMsgHtml = '<div style="background: #4cae4f; color: white; padding: 8px 12px; border-radius: 15px; align-self: flex-end; max-width: 80%;">' + message + '</div>';
            messagesDiv.innerHTML += userMsgHtml;
            input.value = "";
            messagesDiv.scrollTop = messagesDiv.scrollHeight;

            // Show loading
            var loadingId = "loading-" + Date.now();
            var loadingHtml = '<div id="' + loadingId + '" style="background: #e9ecef; color: #555; padding: 8px 12px; border-radius: 15px; align-self: flex-start; max-width: 80%; font-style: italic;">Đang trả lời...</div>';
            messagesDiv.innerHTML += loadingHtml;
            messagesDiv.scrollTop = messagesDiv.scrollHeight;

            try {
                const response = await fetch('chat', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify({ message: message })
                });

                const data = await response.json();

                // Remove loading
                document.getElementById(loadingId).remove();

                // Append AI reply
                var replyHtml = '<div style="background: #e9ecef; color: #333; padding: 8px 12px; border-radius: 15px; align-self: flex-start; max-width: 80%;">' + data.reply + '</div>';
                messagesDiv.innerHTML += replyHtml;
                messagesDiv.scrollTop = messagesDiv.scrollHeight;

            } catch (error) {
                document.getElementById(loadingId).remove();
                var errorHtml = '<div style="background: #ffebee; color: #c62828; padding: 8px 12px; border-radius: 15px; align-self: flex-start; max-width: 80%;">Lỗi kết nối. Vui lòng thử lại.</div>';
                messagesDiv.innerHTML += errorHtml;
                messagesDiv.scrollTop = messagesDiv.scrollHeight;
            }
        }
    </script>