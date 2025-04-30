<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("faculty")) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    int leaveId = Integer.parseInt(request.getParameter("leave_id"));
    String action = request.getParameter("action");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");

        String sql = "UPDATE leave_applications SET status = ? WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, action);
        stmt.setInt(2, leaveId);
        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("view_all_leaves.jsp"); // Redirect back to the leaves page after updating
        } else {
            out.println("Error updating leave status.");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { 
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close(); 
        } catch (SQLException e) { out.println("Error closing DB: " + e.getMessage()); }
    }
%>
