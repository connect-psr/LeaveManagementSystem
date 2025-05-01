<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String statusFilter = request.getParameter("status");
    if (statusFilter == null) statusFilter = "all";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Leave Reports</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #e3f2fd;
            padding: 20px;
        }

        h2 {
            color: #0d47a1;
            text-align: center;
        }

        form {
            margin: 20px auto;
            text-align: center;
        }

        select {
            padding: 8px 12px;
            font-size: 14px;
        }

        input[type="submit"] {
            padding: 8px 16px;
            background-color: #1976d2;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #0d47a1;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px #ccc;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #1565c0;
            color: white;
        }
        .back-btn {
            display: block;
            width: 200px;
            margin: 30px auto;
            padding: 10px 20px;
            text-align: center;
            background-color: #00796b;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .back-btn:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>

<h2>Generate Leave Reports</h2>

<form method="get" action="generate_reports.jsp">
    <label for="status">Filter by Status:</label>
    <select name="status" id="status">
        <option value="all" <%= "all".equals(statusFilter) ? "selected" : "" %>>All</option>
        <option value="pending" <%= "pending".equals(statusFilter) ? "selected" : "" %>>Pending</option>
        <option value="approved" <%= "approved".equals(statusFilter) ? "selected" : "" %>>Approved</option>
        <option value="rejected" <%= "rejected".equals(statusFilter) ? "selected" : "" %>>Rejected</option>
    </select>
    <input type="submit" value="Generate Report">
</form>

<table>
    <tr>
        <th>Username</th>
        <th>Leave Type</th>
        <th>Submission Date</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Status</th>
    </tr>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");

        String query;
        if ("all".equals(statusFilter)) {
            query = "SELECT username, leave_type, submission_date, start_date, end_date, status FROM leave_applications";
            stmt = conn.prepareStatement(query);
        } else {
            query = "SELECT username, leave_type, submission_date, start_date, end_date, status FROM leave_applications WHERE status = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, statusFilter);
        }

        rs = stmt.executeQuery();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("leave_type") %></td>
        <td><%= sdf.format(rs.getDate("submission_date")) %></td>
        <td><%= sdf.format(rs.getDate("start_date")) %></td>
        <td><%= sdf.format(rs.getDate("end_date")) %></td>
        <td><%= rs.getString("status").toUpperCase() %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>
</table>
	<a class="back-btn" href="admin_dashboard.jsp">← Back to Dashboard</a>
</body>
</html>
