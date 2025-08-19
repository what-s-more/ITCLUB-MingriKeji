package com.servlet;

import com.api.Get;
import java.io.StringReader;
import javax.json.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deepseek/chat")
public class Use extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. 解析请求体
        String requestBody = readRequestBody(request);
        
        // 2. 提取用户消息
        String userMessage = extractUserMessage(requestBody);
        
        // 3. 调用DeepSeek API
        String apiResponse;
        try {
            apiResponse = Get.callDeepSeekApi(userMessage);
        } catch (Exception e) {
            apiResponse = "Error: " + e.getMessage();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        
        // 4. 返回响应
        sendJsonResponse(response, apiResponse);
    }

    private String readRequestBody(HttpServletRequest request) throws IOException {
        StringBuilder buffer = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        }
        return buffer.toString();
    }

    private String extractUserMessage(String jsonBody) {
        try (JsonReader jsonReader = Json.createReader(new StringReader(jsonBody))) {
            JsonObject json = jsonReader.readObject();
            return json.getString("message", "");
        } catch (Exception e) {
            return "";
        }
    }

    private void sendJsonResponse(HttpServletResponse response, String content) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        JsonObject jsonResponse = Json.createObjectBuilder()
                .add("response", content)
                .build();
        
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse.toString());
        }
    }
}