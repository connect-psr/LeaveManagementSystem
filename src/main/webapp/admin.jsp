<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
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
            justify-content: flex-start;
            padding-top: 40px;
        }

        h2 {
            color: #00796b;
            margin-bottom: 30px;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            width: 90%;
            max-width: 1000px;
        }

        .card {
		    background-color: white;
		    padding: 25px 20px;
		    text-align: center;
		    border-radius: 12px;
		    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
		    text-decoration: none;
		    color: #00796b;
		    font-size: 17px;
		    font-weight: 600;
		    letter-spacing: 0.5px;
		    transition: transform 0.25s ease, box-shadow 0.25s ease, background-color 0.3s ease;
		    display: flex;
		    flex-direction: column;
		    justify-content: center;
		    align-items: center;
		    min-height: 120px;
		}
		
		.card:hover {
		    background-color: #e0f2f2;
		    transform: translateY(-6px);
		    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
		}

        a.back-link {
            margin-top: 40px;
            text-decoration: none;
            padding: 12px 24px;
            background-color: #00796b;
            color: white;
            border-radius: 6px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        a.back-link:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>
    <h2>Welcome to the Admin Panel</h2>

    <div class="card-grid">
        <a href="manage_users.jsp" class="card">Manage Users</a>
        <a href="view_all_leaves_admin.jsp" class="card">View All Leave Applications</a>
        <a href="pending_requests.jsp" class="card">Pending Leave Requests</a>
        <a href="generate_reports.jsp" class="card">Generate Reports</a>
        <a href="settings.jsp" class="card">System Settings</a>
    </div>
    
    <a href="LogoutServlet" class="back-link">Logout</a>
</body>
</html>
