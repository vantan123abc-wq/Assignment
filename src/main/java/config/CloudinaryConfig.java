/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.ServletContext;

/**
 *
 * @author DELL
 */
public class CloudinaryConfig {
    private final Cloudinary cloudinary;

    public CloudinaryConfig(ServletContext ctx) {
        String cloudName = ctx.getInitParameter("CLOUD_NAME");
        String apiKey = ctx.getInitParameter("API_KEY");
        String apiSecret = ctx.getInitParameter("API_SECRET");

        // Fallback for when Tomcat doesn't redeploy web.xml properly (IDE caching
        // issue)
        if (cloudName == null || cloudName.isEmpty())
            cloudName = "dk3khyzub";
        if (apiKey == null || apiKey.isEmpty())
            apiKey = "426629568762242";
        if (apiSecret == null || apiSecret.isEmpty())
            apiSecret = "iLxmI29_s8n4TS8sWDQfFVTa9hw";

        this.cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret));
    }

    public Cloudinary getClient() {
        return cloudinary;
    }
}
