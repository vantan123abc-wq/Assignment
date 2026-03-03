/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import java.security.SecureRandom;
import java.time.Duration;
import java.util.Scanner;

public class OtpService {

    private final SecureRandom random = new SecureRandom();

    // Lưu OTP theo key (email/username/phone...)
    private final Cache<String, String> otpCache;

    // TTL mặc định: 5 phút
    public OtpService() {
        this(Duration.ofMinutes(5));
    }

    public OtpService(Duration ttl) {
        this.otpCache = Caffeine.newBuilder()
                .expireAfterWrite(ttl)       // hết hạn sau ttl kể từ lúc tạo
                .maximumSize(10000)          // chống tràn bộ nhớ
                .build();
    }

    // Tạo OTP 6 số (000000 - 999999)
    public String generateAndStored(String email) {
        String otp = String.format("%06d", random.nextInt(1_000_000));
        otpCache.put(email, otp);
        return otp;
    }

    // Kiểm tra OTP: đúng thì tự xoá để không dùng lại
    public boolean verifyOtp(String key, String otpInput) {
        if (key == null || otpInput == null) return false;

        String otpStored = otpCache.getIfPresent(key);
        if (otpStored == null) return false;

        boolean ok = otpStored.equals(otpInput.trim());
        if (ok) {
            otpCache.invalidate(key); // dùng đúng thì xoá
        }
        return ok;
    }

    // Xoá OTP thủ công (ví dụ user bấm "gửi lại")
    public void invalidate(String key) {
        otpCache.invalidate(key);
    }

    // (Tuỳ chọn) kiểm tra xem key còn OTP không
    public boolean hasOtp(String key) {
        return otpCache.getIfPresent(key) != null;
    }
    public static void main(String[] args) {
        OtpService otp=new OtpService();
        String sendOtpMail=otp.generateAndStored("vantan123abc@gmail.com");
        EmailService email=new EmailService();
        email.send("vantan123abc@gmail.com", "Ma xac thuc khoi phuc mat khau", sendOtpMail);
        Scanner sc=new Scanner(System.in);
        String maNhap=sc.nextLine();
        boolean oke=otp.verifyOtp("vantan123abc@gmail.com", maNhap);
        if(oke){
            System.out.println("Nhap mat khau moi: ");
        }else{
            System.out.println("CUT");
        }
        
    }
}
