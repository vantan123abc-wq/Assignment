<%@page contentType="text/plain" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@page import="config.CloudinaryConfig" %>
        <%@page import="com.cloudinary.Cloudinary" %>
            <% out.println("--- CLOUDINARY DIAGNOSTIC ---"); try { CloudinaryConfig config=new
                CloudinaryConfig(request.getServletContext()); Cloudinary cloudinary=config.getClient();
                out.println("Cloud Name: " + cloudinary.config.cloudName);
        out.println(" API Key: " + cloudinary.config.apiKey);
        if (cloudinary.config.apiSecret != null) {
            out.println(" API Secret Length: " + cloudinary.config.apiSecret.length());
        } else {
            out.println(" API Secret is NULL"); } out.println("--- TEST SUCCESS ---"); } catch (Exception e) {
                out.println("--- FATAL ERROR ---"); out.println(e.getMessage()); for (StackTraceElement element :
                e.getStackTrace()) { out.println(element.toString()); } } %>