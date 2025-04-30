<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    String searchQuery = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #e1f5fe;
            padding: 20px;
        }
        h2 {
            color: #006064;
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .search-bar input[type="text"] {
            padding: 6px;
            width: 250px;
        }
        .search-bar button {
            padding: 6px 12px;
            background-color: #00796b;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
        .search-bar button:hover {
            background-color: #004d40;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #b2ebf2;
        }
        th {
            background-color: #4dd0e1;
            color: white;
        }
        form {
            display: inline;
        }
        input, select {
            padding: 5px;
            margin-right: 10px;
        }
        button {
            padding: 6px 12px;
            background-color: #00796b;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
        button:hover {
            background-color: #004d40;
        }
        .form-section {
            margin-top: 30px;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #00796b;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Manage Users</h2>

    <!-- Search Bar -->
    <div class="search-bar">
        <form method="get" action="manage_users.jsp">
            <input type="text" name="search" placeholder="Search by username or role" value="<%= searchQuery %>" />
            <button type="submit">Search</button>
            <a href="manage_users.jsp" style="margin-left: 10px;">Reset</a>
        </form>
    </div>

    <!-- Users Table -->
    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");

                String sql = "SELECT * FROM users WHERE username LIKE ? OR role LIKE ? ORDER BY username ASC";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, "%" + searchQuery + "%");
                stmt.setString(2, "%" + searchQuery + "%");
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("role") %></td>
            <td>
                <form method="post" action="delete_user.jsp" onsubmit="return confirm('Are you sure you want to delete this user?');">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>" />
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <!-- Add User Section -->
    <div class="form-section">
        <h3>Add New User</h3>
        <form method="post" action="add_user.jsp">
            <input type="text" name="username" placeholder="Username" required />
            <input type="password" name="password" placeholder="Password" required />
            <select name="role" required>
                <option value="student">Student</option>
                <option value="faculty">Faculty</option>
                <option value="admin">Admin</option>
            </select>
            <button type="submit">Add User</button>
        </form>
    </div>

    <a href="admin.jsp">Back to Admin Panel</a>
</body>
</html>
