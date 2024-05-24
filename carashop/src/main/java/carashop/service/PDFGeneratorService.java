package carashop.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import carashop.dto.Cart;
import carashop.dto.ProductCart;
import carashop.model.User;

@Service
public class PDFGeneratorService {
	public void export(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (loginedUser != null && loginedUser instanceof UserDetails) {
            User user = (User) loginedUser;
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            // Đặt font với hỗ trợ Unicode
            BaseFont bf = BaseFont.createFont("C:/Windows/Fonts/times.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font fontHeader = new Font(bf, 22, Font.BOLD);
            Font fontSubHeader = new Font(bf, 14);
            Font fontNormal = new Font(bf, 12);
            Font fontH1 = new Font(bf, 22, Font.BOLD);

            // Định dạng tiền tệ
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            DecimalFormat decimalFormatter = (DecimalFormat) currencyFormatter;
            decimalFormatter.applyPattern("#,##0");

            // Thêm tiêu đề (user.getName() viết hoa toàn bộ và là thẻ h1)
            Paragraph companyName = new Paragraph(user.getName().toUpperCase(), fontH1);
            companyName.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(companyName);

            // Thêm số điện thoại, địa chỉ dưới dạng thẻ p
            Paragraph hotline = new Paragraph("Hotline: " + user.getMobile(), fontNormal);
            hotline.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(hotline);

            Paragraph address = new Paragraph(user.getAddress(), fontNormal);
            address.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(address);

            Paragraph invoiceTitle = new Paragraph("HÓA ĐƠN BÁN HÀNG", fontHeader);
            invoiceTitle.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(invoiceTitle);

            // Thêm bảng
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);
            table.setWidths(new int[]{4, 2, 2, 2});

            // Đặt tiêu đề bảng
            PdfPCell cell = new PdfPCell();
            cell.setPadding(5);

            cell.setPhrase(new Phrase("Sản phẩm", fontSubHeader));
            table.addCell(cell);

            cell.setPhrase(new Phrase("Số lượng", fontSubHeader));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(cell);

            cell.setPhrase(new Phrase("Đơn giá", fontSubHeader));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(cell);

            cell.setPhrase(new Phrase("Thành tiền", fontSubHeader));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(cell);

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("OrderDetailOfCart");

            // Thêm các hàng vào bảng
            if (cart != null) {
                for (ProductCart product : cart.getProductCarts()) {
                    table.addCell(new Phrase(product.getProductName(), fontNormal));
                    PdfPCell quantityCell = new PdfPCell(new Phrase(String.valueOf(product.getQuantity()), fontNormal));
                    quantityCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(quantityCell);

                    PdfPCell priceCell = new PdfPCell(new Phrase(decimalFormatter.format(product.getPrice()) + "₫", fontNormal));
                    priceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(priceCell);

                    BigDecimal price = product.getPrice();
                    BigInteger quantity = product.getQuantity();
                    BigDecimal total = price.multiply(new BigDecimal(quantity));
                    PdfPCell totalCell = new PdfPCell(new Phrase(decimalFormatter.format(total) + "₫", fontNormal));
                    totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(totalCell);
                }
            }

            document.add(table);
    
            // Thêm tổng cộng và số tiền khách phải trả trong cùng một hàng
            if (cart != null) {
                PdfPTable summaryTable = new PdfPTable(2);
                summaryTable.setWidthPercentage(100);

                PdfPCell totalLabelCell = new PdfPCell(new Phrase("Tổng cộng", fontSubHeader));
                totalLabelCell.setBorder(PdfPCell.NO_BORDER);
                totalLabelCell.setHorizontalAlignment(Element.ALIGN_LEFT);
                summaryTable.addCell(totalLabelCell);

                PdfPCell totalAmountCell = new PdfPCell(new Phrase(decimalFormatter.format(cart.totalCartPrice()) + "₫", fontSubHeader));
                totalAmountCell.setBorder(PdfPCell.NO_BORDER);
                totalAmountCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                summaryTable.addCell(totalAmountCell);

                document.add(summaryTable);

                PdfPTable paymentTable = new PdfPTable(2);
                paymentTable.setWidthPercentage(100);

                PdfPCell paymentLabelCell = new PdfPCell(new Phrase("Khách phải trả", fontSubHeader));
                paymentLabelCell.setBorder(PdfPCell.NO_BORDER);
                paymentLabelCell.setHorizontalAlignment(Element.ALIGN_LEFT);
                paymentTable.addCell(paymentLabelCell);

                PdfPCell paymentAmountCell = new PdfPCell(new Phrase(decimalFormatter.format(cart.totalCartPrice()) + "₫", fontSubHeader));
                paymentAmountCell.setBorder(PdfPCell.NO_BORDER);
                paymentAmountCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                paymentTable.addCell(paymentAmountCell);

                document.add(paymentTable);
            }

            document.add(new Paragraph("\n"));

            // Thêm thời gian dưới dạng thẻ p
            DateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String formattedDate = dateFormatter.format(new Date());
            Paragraph dateParagraph = new Paragraph(formattedDate, fontNormal);
            dateParagraph.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(dateParagraph);

            // Thêm lời cảm ơn dưới dạng thẻ p
            Paragraph thankYou = new Paragraph("CẢM ƠN QUÝ KHÁCH", fontNormal);
            thankYou.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(thankYou);

            document.close();
            
            session.setAttribute("OrderDetailOfCart", new Cart());
        }
    }
}
