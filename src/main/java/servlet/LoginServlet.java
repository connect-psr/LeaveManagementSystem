package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/leave_management";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	response.setContentType("text/html");

        PrintWriter out = response.getWriter();
    	
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=1");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(30 * 60);

                if ("faculty".equalsIgnoreCase(role)) {
                    response.sendRedirect("faculty_dashboard.jsp");
                } else if("student".equalsIgnoreCase(role)){
                    response.sendRedirect("student_dashboard.jsp");
                } else {
                	response.sendRedirect("admin_dashboard.jsp");
                }
            }{
            	out.println("<html>");
                out.println("<head><title></title></head>");
                out.println("<body>");
                out.println("<script type='text/javascript'>");
                out.println("alert('Worng Username or Password..');"); 
                out.println("window.location.href = 'login.jsp';");
                out.println("</script>");
                out.println("</body>");
                out.println("</html>");
            }


            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
