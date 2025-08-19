package com.api;

import javax.json.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class Get {

    private static final String API_URL = "https://api.deepseek.com/v1/chat/completions";
    private static final String API_KEY = "你的API_KEY";// System.getenv("DEEPSEEK_API_KEY");
    
    // 确保API密钥已设置
    static {
        if (API_KEY == null || API_KEY.isBlank()) {
            throw new IllegalStateException("DeepSeek API key is not set. Please set the DEEPSEEK_API_KEY environment variable.");
        }
    }

    public static String callDeepSeekApi(String userMessage) throws IOException {
        // 1. 创建JSON请求体
        JsonObject requestBody = createRequestBody(userMessage);
        
        // 2. 创建HTTP连接
        HttpURLConnection conn = createConnection();
        
        // 3. 发送请求
        sendRequest(conn, requestBody);
        
        // 4. 处理响应
        return handleResponse(conn);
    }

    private static JsonObject createRequestBody(String userMessage) {
        JsonObjectBuilder requestBuilder = Json.createObjectBuilder();
        requestBuilder.add("model", "deepseek-chat");
        
        JsonArrayBuilder messagesBuilder = Json.createArrayBuilder();
        messagesBuilder.add(Json.createObjectBuilder()
                .add("role", "user")
                .add("content", userMessage));
        
        requestBuilder.add("messages", messagesBuilder);
        requestBuilder.add("temperature", 0.7);
        requestBuilder.add("max_tokens", 2000);
        
        return requestBuilder.build();
    }

    private static HttpURLConnection createConnection() throws IOException {
        URL url = new URL(API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setDoOutput(true);
        conn.setConnectTimeout(30_000); // 30秒连接超时
        conn.setReadTimeout(60_000);    // 60秒读取超时
        return conn;
    }

    private static void sendRequest(HttpURLConnection conn, JsonObject requestBody) throws IOException {
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }
    }

    private static String handleResponse(HttpURLConnection conn) throws IOException {
        int responseCode = conn.getResponseCode();
        
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(
                    responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), 
                    StandardCharsets.UTF_8))) {
            
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            
            if (responseCode == 200) {
                return parseApiResponse(response.toString());
            } else {
                throw new IOException("API request failed with status " + responseCode + ": " + response);
            }
        }
    }

    private static String parseApiResponse(String jsonResponse) {
        try (JsonReader jsonReader = Json.createReader(new StringReader(jsonResponse))) {
            JsonObject json = jsonReader.readObject();
            
            // 检查错误
            if (json.containsKey("error")) {
                JsonObject error = json.getJsonObject("error");
                String message = error.getString("message", "Unknown error");
                throw new RuntimeException("DeepSeek API error: " + message);
            }
            
            JsonArray choices = json.getJsonArray("choices");
            if (choices == null || choices.isEmpty()) {
                throw new RuntimeException("No choices in API response");
            }
            
            JsonObject firstChoice = choices.getJsonObject(0);
            JsonObject message = firstChoice.getJsonObject("message");
            return message.getString("content", "No content found");
        }
    }
}
