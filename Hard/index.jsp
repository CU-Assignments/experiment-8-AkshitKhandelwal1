<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Portal</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .menu { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }
        .menu a { margin-right: 15px; text-decoration: none; color: #333; }
        h1 { color: #4a4a4a; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Portal</h1>
        
        <div class="menu">
            <a href="index.jsp">Home</a>
            <a href="viewStudents.jsp">View Students</a>
            <a href="markAttendance.jsp">Mark Attendance</a>
            <a href="viewAttendance.jsp">View Attendance</a>
        </div>
        
        <div style="margin-top: 20px;">
            <h2>Welcome to the Student Portal</h2>
            <p>This portal allows you to manage student information and attendance records.</p>
            <p>Use the navigation menu above to access different features.</p>
        </div>
    </div>
</body>
</html>
