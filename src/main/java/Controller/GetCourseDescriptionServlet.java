/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ENum.ScheduleDay;
import dao.CourseDAO;
import Model.*;
import dao.DescriptionDAO;
import dao.TeacherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Set;


@WebServlet("/student/readmore")
public class GetCourseDescriptionServlet extends HttpServlet {

    private CourseDAO courseDAO;
    private DescriptionDAO descriptionDAO;
    private TeacherDAO teacherDAO; // Thêm đối tượng TeacherDAO

    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo đối tượng DAO
        courseDAO = new CourseDAO();
        descriptionDAO = new DescriptionDAO();
        teacherDAO = new TeacherDAO(); // Khởi tạo TeacherDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy courseTitle từ form
        String courseTitle = request.getParameter("courseTitle");

        // Tìm khóa học theo tiêu đề
        List<Course> courses = courseDAO.findCourseByTitle(courseTitle);

        if (!courses.isEmpty()) {
            Course course = courses.get(0); // Lấy khóa học đầu tiên (nếu có nhiều kết quả, bạn có thể chọn theo logic của bạn)

            // Lấy description và schedule từ DAO
            Description description = descriptionDAO.findByCourseId(course.getCourseId());
            Set<ScheduleDay> applicableDays = descriptionDAO.getScheduleDay(course.getCourseId());

            // Lấy Teacher dạy khóa học từ TeacherDAO
            Teacher teacher = teacherDAO.findTeacherByCourseId(course.getCourseId());

            // Đưa thông tin vào request để chuyển tiếp đến JSP
            request.setAttribute("course", course);
            request.setAttribute("description", description);
            request.setAttribute("applicableDays", applicableDays);
            request.setAttribute("teacher", teacher); // Thêm teacher vào request

            // Chuyển tiếp đến description.jsp để hiển thị
            request.getRequestDispatcher("/views/description.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy khóa học, chuyển về trang lỗi
            request.setAttribute("error", "Course not found.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
