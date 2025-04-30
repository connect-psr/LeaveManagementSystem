<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
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
    <title>View Leaves - Leave Management System</title>
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
		}
		
		table {
		    width: 80%;
		    margin: 20px auto;
		    border-collapse: collapse;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    background-color: #ffffff;
		}
		
		th, td {
		    padding: 12px 20px;
		    text-align: center;
		    border-bottom: 1px solid #ccc;
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
		
		/* Status Colors */
		.approved {
		    color: green;
		    font-weight: bold;
		}
		
		.rejected {
		    color: red;
		    font-weight: bold;
		}
		
		.pending {
		    color: orange;
		    font-weight: bold;
		}

    </style>
</head>
<body>
    <h2>Your Leave Applications</h2>
    <table>
        <tr>
            <th>Leave Type</th>
            <th>Application Date</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Status</th>
        </tr>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management", "root", "root");
        String sql = "SELECT leave_type, start_date, end_date, submission_date, status FROM leave_applications WHERE username = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        while (rs.next()) {
            String status = rs.getString("status");
            String statusClass = "pending"; // Default status color for pending
            if ("approved".equalsIgnoreCase(status)) {
                statusClass = "approved"; // Set green for approved
            } else if ("rejected".equalsIgnoreCase(status)) {
                statusClass = "rejected"; // Set red for rejected
            }
            
%>
        <tr>
            <td><%= rs.getString("leave_type") %></td>
            <td><%= sdf.format(rs.getDate("submission_date")) %></td>
            <td><%= sdf.format(rs.getDate("start_date")) %></td>
            <td><%= sdf.format(rs.getDate("end_date")) %></td>
            <td class="<%= statusClass %>"><%= rs.getString("status") %></td>
        </tr>
<%
        }
    } catch (Exception e) {
    	out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
        	out.println("Error: " + e.getMessage());
        }
    }
%>
    </table>
    <a class="back-btn" href="student_dashboard.jsp">← Back to Dashboard</a>
</body>
</html>
