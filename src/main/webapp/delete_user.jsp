<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");

        PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE id = ?");
        stmt.setInt(1, Integer.parseInt(id));
        stmt.executeUpdate();

        stmt.close();
        conn.close();

        response.sendRedirect("manage_users.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
