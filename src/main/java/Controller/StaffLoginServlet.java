package Controller;

import dao.AccountDAO;
import Model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/stafflogin")
public class StaffLoginServlet extends HttpServlet {
    
    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo AccountDAO
        accountDAO = new AccountDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu truy cập bằng GET, chuyển hướng đến trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/staff_login.jsp");
    }
}