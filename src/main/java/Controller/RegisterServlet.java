package controller;

import dao.AccountDAO; // Import lớp DAO của bạn
import model.Student; // Import lớp Model Student của bạn
import model.Account; // Import lớp Model Account của bạn

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register") // Map Servlet tới URL /register
public class RegisterServlet extends HttpServlet {

     private AccountDAO accountDAO;

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiển thị trang đăng ký (ví dụ: register.jsp)
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // Cần băm mật khẩu trước khi lưu
        String email = request.getParameter("email");
        String phone = request.getParameter("phone"); // Có thể lấy thêm các trường khác

        // **Lưu ý:** Thực hiện xác thực đầu vào ở đây (kiểm tra null, rỗng, định dạng email...)

        // Kiểm tra tên người dùng hoặc email đã tồn tại chưa
        Account existingAccount = accountDAO.findByUsernameOrEmail(username, email);

        if (existingAccount != null) {
            // Tên người dùng hoặc email đã tồn tại
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc email đã tồn tại.");
             // Giữ lại dữ liệu đã nhập (trừ mật khẩu) để người dùng không phải nhập lại
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        } else {
            // Tạo đối tượng Student mới (hoặc Account nếu không phải Student)
            // **Lưu ý:** Băm mật khẩu ở đây trước khi tạo đối tượng!
            // String hashedPassword = hashPassword(password); // Sử dụng hàm băm mật khẩu của bạn
            Student newStudent = new Student(username, password, email, phone, null, true); // Sử dụng mật khẩu đã băm

            // Lưu tài khoản vào cơ sở dữ liệu
            boolean success = accountDAO.saveAccount(newStudent);

            if (success) {
                // Đăng ký thành công
                // Chuyển hướng đến trang đăng nhập hoặc trang thông báo thành công
                response.sendRedirect(request.getContextPath() + "/login?registrationSuccess=true");
            } else {
                 // Lưu thất bại vì lý do khác (ví dụ: lỗi DB)
                request.setAttribute("errorMessage", "Đăng ký thất bại. Vui lòng thử lại sau.");
                 // Giữ lại dữ liệu đã nhập
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.getRequestDispatcher("views/register.jsp").forward(request, response);
            }
        }
    }

     @Override
    public void destroy() {
        // Đóng tài nguyên nếu cần
        super.destroy();
    }
}