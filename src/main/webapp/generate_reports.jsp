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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f7fa, #80deea);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #00796b;
            margin-bottom: 20px;
            font-size: 2rem;
        }

        form label {
            font-size: 1.1rem;
            margin-right: 10px;
        }

        select {
            padding: 8px 12px;
            font-size: 14px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #00796b;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #004d40;
        }

        .generate_report_btn, .btn-download {
	        padding: 10px 20px;
	        background-color: #00796b;
	        color: white;
	        border: none;
	        cursor: pointer;
	        border-radius: 4px;
	        font-weight: bold;
	        font-size: 16px;  /* Same font size */
	        line-height: 1.5; /* Adjust line height for consistent height */
	        transition: background-color 0.3s ease;
	        display: inline-block;
	        text-decoration: none; /* Remove underline for the link */
	        text-align: center;
	    }
	
	    .generate_report_btn:hover, .btn-download:hover {
	        background-color: #004d40;
	    }
	
	    .btn-download {
	        display: inline-block; /* Make sure the download button behaves like the generate button */
	    }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        th, td {
            padding: 12px 20px;
            text-align: center;
            border-bottom: 1px solid #ccc;
            font-size: 1rem;
        }

        th {
            background-color: #00796b;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .back-btn {
            display: block;
            width: 200px;
            margin: 30px auto;
            padding: 12px 20px;
            text-align: center;
            background-color: #00796b;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background-color 0.3s ease;
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
    <input type="submit" class="generate_report_btn" value="Generate Report">
    <a href="generate_leave_report?status=<%= statusFilter %>" class="btn-download">
        Download PDF Report
    </a>
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
