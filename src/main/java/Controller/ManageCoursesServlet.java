/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;



import dao.CourseDAO;
import dao.AccountDAO;
import Model.Account;
import Model.Teacher;
import Model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/teacher/manage-courses")
public class ManageCoursesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy Account từ session
        Account account = (Account) session.getAttribute("account");
        AccountDAO accountDAO = new AccountDAO();

//        // Kiểm tra xem account có phải là Teacher không
//        if (!accountDAO.isTeacher(account.getId())) {
//            request.setAttribute("error", "You are not authorized to manage courses.");
//            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
//            return;
//        }

        // Giả định có một phương thức trong Account để lấy Teacher (hoặc lấy từ DB)
        // Ở đây, tôi giả định bạn có cách lấy Teacher từ Account, ví dụ: một truy vấn trong AccountDAO
        Long teacherId = account.getAccountId(); // Giả định Account.id tương ứng với Teacher.id
        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.findByTeacherId(teacherId);

        // Gửi danh sách khóa học đến JSP
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/views/teacher/managecourses.jsp").forward(request, response);
    }
}