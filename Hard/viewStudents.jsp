<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Students</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .menu { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }
        .menu a { margin-right: 15px; text-decoration: none; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
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
        
        <h2>Student List</h2>
        
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Roll Number</th>
                <th>Course</th>
            </tr>
            
            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal", "root", "password");
                stmt = conn.createStatement();
                String sql = "SELECT * FROM students ORDER BY name";
                rs = stmt.executeQuery(sql);
                
                while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("roll_number") %></td>
                        <td><%= rs.getString("course") %></td>
                    </tr>
                    <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                try { if(rs != null) rs.close(); } catch(Exception e) { }
                try { if(stmt != null) stmt.close(); } catch(Exception e) { }
                try { if(conn != null) conn.close(); } catch(Exception e) { }
            }
            %>
        </table>
    </div>
</body>
</html>
