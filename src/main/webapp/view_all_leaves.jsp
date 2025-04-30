<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("faculty")) {
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
    <title>View All Leaves - Faculty</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f7fa, #80deea);
            margin: 0;
            padding: 40px 20px;
            min-height: 100vh;
        }

        h2 {
            text-align: center;
            color: #00796b;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            max-width: 1150px;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #00796b;
            color: white;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        td.reason {
            max-width: 250px;
            height: 60px;
            overflow-y: auto;
            text-align: left;
            white-space: normal;
            word-wrap: break-word;
            vertical-align: top;
        }

        td.status-tag {
            font-weight: bold;
            border-radius: 6px;
            padding: 6px 10px;
            display: inline-block;
            color: white;
        }

        .approved { background-color: #388e3c; }
        .pending { background-color: #fbc02d; color: black; }
        .rejected { background-color: #d32f2f; }

        form {
            display: inline;
        }

        button {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            background-color: #00796b;
            color: white;
            cursor: pointer;
            margin: 2px;
        }

        button:hover {
            background-color: #004d40;
        }

        button[value="rejected"] {
            background-color: #d32f2f;
        }

        button[value="rejected"]:hover {
            background-color: #b71c1c;
        }

        a.back-btn {
            display: block;
            width: max-content;
            margin: 30px auto 0;
            text-align: center;
            padding: 12px 24px;
            background-color: #00796b;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        a.back-btn:hover {
            background-color: #004d40;
        }

        .error {
            text-align: center;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>All Leave Applications</h2>
    <table>
        <tr>
            <th>#</th>
            <th>Username</th>
            <th>Leave Type</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Status</th>
            <th>Reason</th>
            <th>Application Date</th>
            <th>Action</th>
        </tr>
<%
    int count = 1;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");
        String sql = "SELECT id, username, leave_type, start_date, end_date, status, reason, submission_date FROM leave_applications ORDER BY submission_date DESC";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        while (rs.next()) {
            int leaveId = rs.getInt("id");
            String status = rs.getString("status");
            String reason = rs.getString("reason");
            reason = (reason != null) ? reason.replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "No reason provided";
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

%>


        <tr>
            <td><%= count++ %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("leave_type") %></td>
            <td><%= sdf.format(rs.getDate("start_date")) %></td>
            <td><%= sdf.format(rs.getDate("end_date")) %></td>
            <td>
                <span class="status-tag <%= status.toLowerCase() %>"><%= status.substring(0,1).toUpperCase() + status.substring(1).toLowerCase() %></span>
            </td>
            <td class="reason"><%= reason %></td>
            <td><%= sdf.format(rs.getDate("submission_date")) %></td>
            
            <td>
                <% if ("pending".equalsIgnoreCase(status)) { %>
                    <form method="post" action="update_leave_status.jsp">
                        <input type="hidden" name="leave_id" value="<%= leaveId %>"/>
                        <button type="submit" name="action" value="approved">Approve</button>
                        <button type="submit" name="action" value="rejected">Reject</button>
                    </form>
                <% } else { %>
                    <i>No Action</i>
                <% } %>
            </td>
        </tr>
<%
        }
    } catch (Exception e) {
%>
    <tr>
        <td colspan="8" class="error">Error fetching data: <%= e.getMessage() %></td>
    </tr>
<%
    } finally {
        try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); if (conn != null) conn.close(); }
        catch (SQLException e) { out.println("<div class='error'>DB Close Error: " + e.getMessage() + "</div>"); }
    }
%>
    </table>

    <a class="back-btn" href="faculty_dashboard.jsp">Back to Dashboard</a>
</body>
</html>
