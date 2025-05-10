package Controller;



import Controller.*;
import Model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "UserServlet", urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        UsersJpaController controller = new UsersJpaController();

        // Tạo user mới
        Users newUser = new Users();
        newUser.setUsername("admin1021");
        newUser.setFullName("Admin UserUPP");
        newUser.setEmail("admin1021@example.com");
        newUser.setPassword("123456");
        controller.create(newUser);

        // Lấy danh sách user
        List<Users> users = controller.findAllUsers();
        out.println("<html><body>");
        out.println("<h1>Users List</h1>");
        for (Users user : users) {
            out.println("ID: " + user.getId() + ", Username: " + user.getUsername() + "<br>");
        }
        out.println("</body></html>");
    }
}