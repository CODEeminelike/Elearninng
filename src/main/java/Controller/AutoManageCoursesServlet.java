package Controller;

import dao.CourseDAO;
import dao.AccountDAO;
import Model.Account;
import Model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/teacher/auto-manage-courses")
public class AutoManageCoursesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       CourseDAO courseDAO = new CourseDAO();

           
            List<Course> courses = courseDAO.findAll();
            if (courses == null) {
                courses = new ArrayList<>();
            }
            request.setAttribute("courses", courses);
            request.setAttribute("showCourses", true);
        request.getRequestDispatcher("/views/courses.jsp").forward(request, response);
    }
}