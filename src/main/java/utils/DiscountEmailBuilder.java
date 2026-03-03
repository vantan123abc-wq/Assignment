package utils;

import model.Product;

/**
 * Xây dựng nội dung email HTML thông báo giảm giá sản phẩm.
 */
public class DiscountEmailBuilder {

    private DiscountEmailBuilder() {}

    /**
     * @param product     Sản phẩm đang giảm giá
     * @param productLink URL dẫn đến trang sản phẩm (ví dụ: "https://yourdomain.com/shop?id=5")
     * @return Nội dung HTML email
     */
    public static String buildHtml(Product product, String productLink) {
        double originalPrice = product.getPrice();
        int discountPercent = (product.getDiscountPercent() != null) ? product.getDiscountPercent() : 0;
        double salePrice = product.getSalePrice();
        String productName = product.getName();
        String imageUrl = (product.getImageUrl() != null && !product.getImageUrl().isEmpty())
                ? product.getImageUrl()
                : "https://via.placeholder.com/600x300?text=Sale";

        return "<!DOCTYPE html>" +
               "<html lang='vi'>" +
               "<head>" +
               "  <meta charset='UTF-8'>" +
               "  <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
               "  <title>Thông báo giảm giá</title>" +
               "</head>" +
               "<body style='margin:0;padding:0;background-color:#f4f4f7;font-family:Arial,sans-serif;'>" +
               "  <table width='100%' cellpadding='0' cellspacing='0' style='background:#f4f4f7;padding:30px 0;'>" +
               "    <tr><td align='center'>" +
               "      <table width='600' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:12px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.1);'>" +
               /* Header */
               "        <tr>" +
               "          <td style='background:linear-gradient(135deg,#ff6b35,#f7c59f);padding:40px 30px;text-align:center;'>" +
               "            <h1 style='margin:0;color:#fff;font-size:28px;letter-spacing:1px;'>🎉 Sản phẩm đang giảm giá!</h1>" +
               "            <p style='color:#fff3ec;margin:8px 0 0;font-size:15px;'>Đừng bỏ lỡ cơ hội tuyệt vời này!</p>" +
               "          </td>" +
               "        </tr>" +
               /* Product image */
               "        <tr>" +
               "          <td style='padding:0;'>" +
               "            <img src='" + imageUrl + "' alt='" + productName + "' " +
               "                 style='width:100%;max-height:280px;object-fit:cover;display:block;'/>" +
               "          </td>" +
               "        </tr>" +
               /* Content */
               "        <tr>" +
               "          <td style='padding:35px 40px;'>" +
               "            <h2 style='margin:0 0 20px;color:#2d2d2d;font-size:22px;'>" + productName + "</h2>" +
               /* Price table */
               "            <table width='100%' cellpadding='12' cellspacing='0' style='background:#fff8f5;border-radius:8px;border:1px solid #fde8d8;margin-bottom:25px;'>" +
               "              <tr>" +
               "                <td style='color:#888;font-size:14px;'>Giá gốc</td>" +
               "                <td align='right' style='color:#aaa;font-size:16px;text-decoration:line-through;'>" +
               String.format("%,.0f ₫", originalPrice) +
               "                </td>" +
               "              </tr>" +
               "              <tr style='background:#fff3ec;'>" +
               "                <td style='color:#ff6b35;font-weight:bold;font-size:15px;'>Giá sau giảm</td>" +
               "                <td align='right' style='color:#ff6b35;font-size:22px;font-weight:bold;'>" +
               String.format("%,.0f ₫", salePrice) +
               "                </td>" +
               "              </tr>" +
               "              <tr>" +
               "                <td style='color:#28a745;font-weight:bold;'>Tiết kiệm</td>" +
               "                <td align='right'>" +
               "                  <span style='background:#28a745;color:#fff;padding:4px 12px;border-radius:20px;font-size:14px;font-weight:bold;'>" +
               "                    Giảm " + discountPercent + "%" +
               "                  </span>" +
               "                </td>" +
               "              </tr>" +
               "            </table>" +
               /* CTA button */
               "            <div style='text-align:center;margin-top:10px;'>" +
               "              <a href='" + productLink + "' " +
               "                 style='display:inline-block;background:linear-gradient(135deg,#ff6b35,#e04e1c);" +
               "                        color:#fff;text-decoration:none;padding:14px 40px;border-radius:30px;" +
               "                        font-size:16px;font-weight:bold;letter-spacing:0.5px;" +
               "                        box-shadow:0 4px 14px rgba(255,107,53,0.45);'>" +
               "                🛒 Mua ngay &rarr;" +
               "              </a>" +
               "            </div>" +
               "          </td>" +
               "        </tr>" +
               /* Footer */
               "        <tr>" +
               "          <td style='background:#f9f9f9;padding:20px 40px;border-top:1px solid #eee;text-align:center;'>" +
               "            <p style='margin:0;color:#aaa;font-size:12px;'>Bạn nhận được email này vì đã đăng ký nhận thông báo từ cửa hàng chúng tôi.</p>" +
               "          </td>" +
               "        </tr>" +
               "      </table>" +
               "    </td></tr>" +
               "  </table>" +
               "</body>" +
               "</html>";
    }
}
