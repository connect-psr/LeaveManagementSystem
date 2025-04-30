package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class ApplyLeaveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String role = request.getParameter("role");
        String leaveType = request.getParameter("leaveType");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String reason = request.getParameter("reason");
        String submissionDate = request.getParameter("submission_date");
        
        username = username.trim();
        role = role.trim();
        leaveType = leaveType.trim();
        reason = reason.trim();

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/leave_management";
            String dbUsername = "root";
            String dbPassword = "root";
            conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            String sql = "INSERT INTO leave_applications (username, role, leave_type, start_date, end_date, reason, status, submission_date) "
                       + "VALUES (?, ?, ?, ?, ?, ?, 'pending', ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, role);
            stmt.setString(3, leaveType);
            stmt.setDate(4, Date.valueOf(startDate));
            stmt.setDate(5, Date.valueOf(endDate));
            stmt.setString(6, reason);
            stmt.setDate(7, Date.valueOf(submissionDate)); // NEW: submission_date

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("leave_status.jsp?status=success");
            } else {
                response.sendRedirect("leave_status.jsp?status=error");
            }
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
