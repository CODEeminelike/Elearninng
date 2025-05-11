package test;

import Model.Account;
import Model.Admin;
import dao.AccountDAO; // Vẫn giữ nguyên, có thể dùng cho các mục đích khác sau này
import Util.EmailUtil; // Vẫn giữ nguyên
import dao.PasswordResetTokenDAO;
import Model.PasswordResetToken; // Import lớp Model
import jakarta.mail.MessagingException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime; // Vẫn giữ nguyên
import java.util.UUID; // Vẫn giữ nguyên
import java.util.List; // Import List để làm việc với danh sách token
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "TestServlet", urlPatterns = {"/test"})
public class test extends HttpServlet {
    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU"; // Thay bằng tên Persistence Unit của bạn
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "123456";
    private static final String ADMIN_EMAIL = "monnkkey2004@gmail.com";

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
           // Lấy thông tin từ form
        String username = "admin";
        String password = "123456";
        String role = "admin";

        // Kiểm tra thông tin đăng nhập
        Account account = accountDAO.findByUsernameAndPassword(username, password);

        // Nếu tài khoản tồn tại và hoạt động
        if (account != null && account.isActive()) {
            // Lưu tài khoản vào session
            HttpSession session = request.getSession();
            session.setAttribute("account", account);

            // Điều hướng dựa trên vai trò
            Long accountId = account.getAccountId();
            if ("teacher".equalsIgnoreCase(role) && accountDAO.isTeacher(accountId)) {
                response.sendRedirect(request.getContextPath() + "/views/teacher/teacherDashboard.jsp");
            } else if ("admin".equalsIgnoreCase(role) && accountDAO.isAdmin(accountId)) {
                response.sendRedirect(request.getContextPath() + "/views/admin/adminDashboard.jsp");
            } else {
                // Vai trò không khớp hoặc tài khoản không thuộc loại tương ứng
                request.setAttribute("error", "Invalid role or account type.");
                request.getRequestDispatcher("/ERROR.jsp").forward(request, response);
            }
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Invalid username or password.");
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
