<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (!"student".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f2f1, #80cbc4);
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            background-color: white;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            width: 350px;
            text-align: center;
        }

        h2 {
            color: #00695c;
            margin-bottom: 10px;
        }

        h3 {
            color: #333;
            margin-bottom: 25px;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0 0 20px 0;
        }

        li {
            margin: 12px 0;
        }

        a {
            text-decoration: none;
            color: white;
            background-color: #00695c;
            padding: 10px 18px;
            border-radius: 6px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }

        a:hover {
            background-color: #004d40;
        }

        .logout {
            background-color: #d32f2f;
            margin-top: 20px;
        }

        .logout:hover {
            background-color: #a30000;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome Student, <%= username %>!</h2>
    <h3>Student Dashboard</h3>
    <ul>
        <li><a href="apply_leave.jsp">Apply for Leave</a></li>
        <li><a href="view_leaves.jsp">View My Leaves</a></li>
    </ul>
    <a href="LogoutServlet" class="logout">Logout</a>
</div>
</body>
</html>
