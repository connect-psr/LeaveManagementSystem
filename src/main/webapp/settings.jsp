<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #80deea);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        h2 {
            color: #00796b;
            margin-bottom: 20px;
        }

        .container {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #00796b;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #004d40;
        }

        .logout-link {
            margin-top: 20px;
            text-align: center;
        }

        .logout-link a {
            color: #00796b;
            font-weight: bold;
            text-decoration: none;
        }

        .logout-link a:hover {
            text-decoration: underline;
        }

        .message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <h2>Account Settings</h2>

    <div class="container">
        <% if (message != null && message.equals("Password updated successfully")) { %>
		    <p class="message" style="color: green;"><%= message %></p>
		<% } else if (message != null) { %>
		    <p class="message" style="color: red;"><%= message %></p>
		<% } %>


        <!-- Change Password Form -->
        <form method="post" action="UpdatePasswordServlet">
            <h3>Change Password</h3>
            <input type="password" name="old_password" placeholder="Current Password" required>
            <input type="password" name="new_password" placeholder="New Password" required>
            <input type="submit" value="Update Password">
        </form>

        <hr>

        <div class="logout-link">
            <a href="admin_dashboard.jsp">← Back to Dashboard</a> | <a href="LogoutServlet" class="back-link">Logout</a>
        </div>
    </div>

</body>
</html>
