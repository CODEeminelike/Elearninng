package Controller;

import dao.TeacherDAO;
import Model.Teacher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/teacher-management")
public class TeacherManagementServlet extends HttpServlet {
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        teacherDAO = new TeacherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả Teacher
            List<Teacher> teachers = teacherDAO.getAllTeachers();
            if (teachers == null) {
                teachers = List.of(); // Đảm bảo teachers không null
            }
            request.setAttribute("teachers", teachers);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading teachers: " + e.getMessage());
            e.printStackTrace(); // Log lỗi để debug
        }
        request.getRequestDispatcher("/views/teacher/TeacherManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Xóa Teacher
            String accountIdStr = request.getParameter("accountId");
            try {
                Long accountId = Long.parseLong(accountIdStr);
                boolean success = teacherDAO.removeTeacher(accountId);
                if (success) {
                    request.setAttribute("message", "Teacher with accountId " + accountId + " deleted successfully.");
                } else {
                    request.setAttribute("errorMessage", "Teacher with accountId " + accountId + " not found.");
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Failed to delete teacher: " + e.getMessage());
            }
        } else if ("updateStatus".equals(action)) {
            // Cập nhật trạng thái isActive
            String accountIdStr = request.getParameter("accountId");
            String isActiveStr = request.getParameter("isActive");
            try {
                Long accountId = Long.parseLong(accountIdStr);
                boolean isActive = Boolean.parseBoolean(isActiveStr);
                boolean success = teacherDAO.updateTeacherStatus(accountId, isActive);
                if (success) {
                    request.setAttribute("message", "Teacher status updated successfully for accountId " + accountId + ".");
                } else {
                    request.setAttribute("errorMessage", "Teacher with accountId " + accountId + " not found.");
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Failed to update teacher status: " + e.getMessage());
            }
        }

        // Tải lại danh sách Teacher sau khi thực hiện hành động
        try {
            List<Teacher> teachers = teacherDAO.getAllTeachers();
            if (teachers == null) {
                teachers = List.of(); // Đảm bảo teachers không null
            }
            request.setAttribute("teachers", teachers);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading teachers: " + e.getMessage());
            e.printStackTrace(); // Log lỗi để debug
        }
        request.getRequestDispatcher("/views/teacher/TeacherManagement.jsp").forward(request, response);
    }
}