package servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String oldPassword = request.getParameter("old_password");
        String newPassword = request.getParameter("new_password");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");

            stmt = conn.prepareStatement("SELECT password FROM users WHERE username = ?");
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String currentPassword = rs.getString("password");
                if (currentPassword.equals(oldPassword)) {

                    stmt = conn.prepareStatement("UPDATE users SET password = ? WHERE username = ?");
                    stmt.setString(1, newPassword);
                    stmt.setString(2, username);
                    stmt.executeUpdate();

                    response.sendRedirect("settings.jsp?msg=Password updated successfully");
                } else {
                    response.sendRedirect("settings.jsp?msg=Incorrect password");
                }
            } else {
                response.sendRedirect("settings.jsp?msg=User not found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("settings.jsp?msg=An error occurred");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
