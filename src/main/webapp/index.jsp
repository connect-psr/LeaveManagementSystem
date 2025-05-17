<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f2f1, #80cbc4);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            text-align: center;
            background: rgba(0, 0, 0, 0.4);
            padding: 40px 60px;
            border-radius: 16px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.3);
        }

        .container h2 {
            color: #ffffff;
            font-size: 2.5rem;
            margin-bottom: 30px;
        }

        .btn-start {
            text-decoration: none;
            padding: 14px 40px;
            background-color: #B35D47;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-start:hover {
            background-color: #8b3e2f;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome to the Leave Management System</h2>
        <a href="login.jsp" class="btn-start">Get Started</a>
    </div>
</body>
</html>
