package test;

import dao.AccountDAO; // Vẫn giữ nguyên, có thể dùng cho các mục đích khác sau này
import Util.EmailUtil; // Vẫn giữ nguyên
import dao.PasswordResetTokenDAO;
import Model.PasswordResetToken; // Import lớp Model
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime; // Vẫn giữ nguyên
import java.util.UUID; // Vẫn giữ nguyên
import java.util.List; // Import List để làm việc với danh sách token

@WebServlet(name = "TestServlet", urlPatterns = {"/test"})
public class test extends HttpServlet {

    private AccountDAO accountDAO;
    private PasswordResetTokenDAO tokenDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo các đối tượng DAO
        accountDAO = new AccountDAO();
        tokenDAO = new PasswordResetTokenDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Phương thức GET sẽ được sử dụng để hiển thị danh sách token
        response.setContentType("text/html;charset=UTF-8");

        try {
            
             // Tạo token
            String token = UUID.randomUUID().toString();
            LocalDateTime expiryDate = LocalDateTime.now().plusHours(1);
            tokenDAO.saveToken("108@gmail.com", token, expiryDate);

            // Lấy tất cả các token từ cơ sở dữ liệu
            List<PasswordResetToken> allTokens = tokenDAO.findAllToken();

            // Đặt danh sách token vào request attribute
            request.setAttribute("allTokens", allTokens);

            // Chuyển tiếp yêu cầu đến trang Done.jsp để hiển thị
            request.getRequestDispatcher("/Done.jsp").forward(request, response);

        } catch (Exception e) {
            // Xử lý lỗi nếu có
            System.err.println("Loi truy xuat " + e.getMessage());
            e.printStackTrace();

            // Đặt thông báo lỗi vào request và chuyển tiếp đến trang lỗi
            request.setAttribute("errorMessage", "Loi lay danh sách: " + e.getMessage());
            request.getRequestDispatcher("/ERROR.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Phương thức POST có thể được giữ lại để test chức năng tạo token riêng biệt
        // Hoặc bạn có thể bỏ qua phương thức này nếu chỉ muốn dùng GET để hiển thị tất cả
        response.getWriter().println("Phương thức POST hiện tại không được sử dụng để hiển thị tất cả token. Vui lòng dùng GET.");
        // Nếu bạn vẫn muốn giữ chức năng tạo token test bằng POST, bạn có thể di chuyển logic tạo token từ doGet ban đầu vào đây.
    }

    @Override
    public String getServletInfo() {
        return "Servlet dùng để kiểm tra chức năng truy xuất tất cả token đặt lại mật khẩu";
    }
}
