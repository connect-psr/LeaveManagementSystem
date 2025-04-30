<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Leave Applications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f8ff;
            padding: 20px;
        }
        h2 {
            color: #006064;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #b2ebf2;
            text-align: left;
        }
        th {
            background-color: #26c6da;
            color: white;
        }
        td.status {
            font-weight: bold;
        }
        a {
            margin-top: 20px;
            display: inline-block;
            text-decoration: none;
            color: #00796b;
            font-weight: bold;
        }
        .scrollable {
            max-height: 500px;
            overflow-y: auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #fff;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>All Leave Applications</h2>

    <div class="scrollable">
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Submission Date</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");
                    String sql = "SELECT * FROM leave_applications ORDER BY submission_date DESC";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("role") %></td>
                <td><%= rs.getString("reason") %></td>
                <td class="status"><%= rs.getString("status").toUpperCase() %></td>
                <td><%= rs.getString("submission_date") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </div>

    <a href="admin.jsp">Back to Admin Panel</a>
</body>
</html>
