package test;

import Model.Account;
import Model.Admin;
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
    private TeacherDAO teacherDAO;
    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
       teacherDAO = new TeacherDAO();
        accountDAO = new AccountDAO();
    }

    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả Teacher
            List<Teacher> teachers = teacherDAO.getAllTeachers();
            request.setAttribute("teachers", teachers);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading teachers: " + e.getMessage());
            request.getRequestDispatcher("/ERROR.jsp").forward(request, response);
        }
        request.getRequestDispatcher("/Done.jsp").forward(request, response);
    }
    
}