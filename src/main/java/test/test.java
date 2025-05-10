package test;

import dao.AccountDAO;
import Model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TestServlet", urlPatterns = {"/test"})
public class test extends HttpServlet {

    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo AccountDAO
        accountDAO = new AccountDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("test.jsp").forward(request, response);
    }

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = "testuser";
        String password = "password123";

        // Gọi hàm findByUsernameAndPassword từ AccountDAO
        Account account = accountDAO.findByUsernameAndPassword(username, password);

        if (account != null) {
            // Tìm thấy tài khoản, chuyển hướng đến Done.jsp
                       request.getRequestDispatcher("Done.jsp").forward(request, response);
        } else {
           
            
            request.getRequestDispatcher("ERROR.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for testing AccountDAO login";
    }
}