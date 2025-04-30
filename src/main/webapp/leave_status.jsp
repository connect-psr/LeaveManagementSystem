<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Status</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f3ff;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .card {
            max-width: 500px;
            width: 90%;
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            padding: 40px 30px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333333;
        }
        .icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .success-icon {
            color: green;
        }
        .error-icon {
            color: red;
        }
        p {
            font-size: 18px;
            color: #444444;
        }
        a {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            background-color: #008CBA;
            color: white;
            padding: 12px 24px;
            border-radius: 10px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #0077a6;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Leave Application Status</h2>
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <div class="icon success-icon">✅</div>
            <p>Your leave application has been successfully submitted.<br>It is currently pending approval.</p>
        <%
            } else if ("error".equals(status)) {
        %>
            <div class="icon error-icon">❌</div>
            <p>There was an error submitting your leave application.<br>Please try again.</p>
        <%
            } else {
        %>
            <div class="icon error-icon">⚠️</div>
            <p>Status unknown. Please return to the dashboard and try again.</p>
        <%
            }
        %>
        <a href="student_dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
