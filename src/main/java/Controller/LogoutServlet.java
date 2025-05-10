package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout") // Map Servlet tới URL /logout
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tạo mới
        if (session != null) {
            session.invalidate(); // Hủy bỏ session
        }
        // Chuyển hướng về trang đăng nhập hoặc trang chủ
        response.sendRedirect(request.getContextPath() + "/login"); // Ví dụ: chuyển hướng đến /login
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thường thì logout được xử lý bằng GET, nhưng cũng có thể cho phép POST
        doGet(request, response);
    }
}