<%@ page import="java.text.SimpleDateFormat" %>
<% 
    if (session.getAttribute("username") == null || session.getAttribute("role") == null) {
        response.sendRedirect("login.jsp"); // Or wherever your login page is
    }
%>

<%@ page import="java.util.Date" %>
<%
    String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply Leave - Leave Management System</title>
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
            margin-bottom: 5px;
        }

        .date-display {
            color: #444;
            font-size: 0.95rem;
            margin-bottom: 20px;
            background-color: #e0f7fa;
            padding: 8px;
            border-radius: 5px;
        }

        label {
            font-size: 1rem;
            color: #333;
            margin-bottom: 8px;
            display: inline-block;
            text-align: left;
        }

        input[type="date"], 
        select, 
        textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        button {
            background-color: #00695c;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #004d40;
        }

        a {
            text-decoration: none;
            color: #007acc;
            margin-top: 10px;
            display: inline-block;
        }

        a:hover {
            color: #005f99;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Apply for Leave</h2>
        
        <form action="applyLeave" method="POST">
            <!-- Hidden fields for username, role and submission date -->
            <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
            <input type="hidden" name="role" value="<%= session.getAttribute("role") %>">

			<p id="submissionDateDisplay" style="color:#00695c; font-weight:bold;">Submission Date: <span id="submissionDate"></span></p>
			<input type="hidden" id="submission_date" name="submission_date">

            <label for="leaveType">Leave Type:</label><br>
            <select id="leaveType" name="leaveType">
                <option value="Sick Leave">Sick Leave</option>
                <option value="Casual Leave">Casual Leave</option>
                <option value="Earned Leave">Earned Leave</option>
            </select><br><br>
            
            <label for="startDate">Start Date:</label><br>
            <input type="date" id="startDate" name="startDate" required><br><br>
            
            <label for="endDate">End Date:</label><br>
            <input type="date" id="endDate" name="endDate" required><br><br>
            
            <label for="reason">Reason:</label><br>
            <textarea id="reason" name="reason" rows="4" cols="50" required></textarea><br><br>
            
            <button type="submit">Apply for Leave</button>
        </form>
        <a href="student_dashboard.jsp">Back to Dashboard</a>
    </div>

    <script>
	    
	    const today = new Date().toISOString().split('T')[0];
	    document.getElementById('submission_date').value = today;
	    document.getElementById('submissionDate').textContent = today;
	    
	    document.getElementById('startDate').setAttribute('min', today);
	    document.getElementById('endDate').setAttribute('min', today);
	
	    document.querySelector('form').addEventListener('submit', function(event) {
	        const startDate = new Date(document.getElementById('startDate').value);
	        const endDate = new Date(document.getElementById('endDate').value);
	        if (startDate > endDate) {
	            alert("Start date cannot be later than end date.");
	            event.preventDefault();
	        }
	    });
	</script>

    
</body>
</html>
