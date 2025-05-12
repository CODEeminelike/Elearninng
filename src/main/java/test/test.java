package test;

import Model.Account;
import Model.Admin;
import Model.Course;
import Model.Teacher;
import dao.*;
import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "TestServlet", urlPatterns = {"/test"})
public class test extends HttpServlet {
    
    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
              accountDAO = new AccountDAO();
    }

    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
               
            // Lấy danh sách khóa học
            Long teacherId = 36L; // Giả định Account.id tương ứng với Teacher.id
            CourseDAO courseDAO = new CourseDAO();
            List<Course> courses = courseDAO.findByTeacherId(teacherId);

            // Gửi danh sách khóa học và cờ showCourses đến JSP
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/Done.jsp").forward(request, response);
    
    }
    
}