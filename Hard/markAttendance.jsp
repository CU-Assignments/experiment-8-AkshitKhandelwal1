<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mark Attendance</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .menu { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }
        .menu a { margin-right: 15px; text-decoration: none; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="date"], select, textarea { width: 100%; padding: 8px; box-sizing: border-box; }
        button { padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
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
        
        <h2>Mark Attendance</h2>
        
        <form action="AttendanceServlet" method="post">
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>
            </div>
            
            <table>
                <tr>
                    <th>Student</th>
                    <th>Status</th>
                    <th>Remarks</th>
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
                    
                    int count = 0;
                    while(rs.next()) {
                        int studentId = rs.getInt("id");
                        String studentName = rs.getString("name");
                        String rollNumber = rs.getString("roll_number");
                        %>
                        <tr>
                            <td>
                                <%= studentName %> (<%= rollNumber %>)
                                <input type="hidden" name="studentId<%= count %>" value="<%= studentId %>">
                            </td>
                            <td>
                                <select name="status<%= count %>">
                                    <option value="Present">Present</option>
                                    <option value="Absent">Absent</option>
                                    <option value="Late">Late</option>
                                </select>
                            </td>
                            <td>
                                <textarea name="remarks<%= count %>" rows="2" cols="30"></textarea>
                            </td>
                        </tr>
                        <%
                        count++;
                    }
                    %>
                    <input type="hidden" name="studentCount" value="<%= count %>">
                    <%
                } catch(Exception e) {
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    try { if(rs != null) rs.close(); } catch(Exception e) { }
                    try { if(stmt != null) stmt.close(); } catch(Exception e) { }
                    try { if(conn != null) conn.close(); } catch(Exception e) { }
                }
                %>
            </table>
            
            <div style="margin-top: 20px;">
                <button type="submit">Save Attendance</button>
            </div>
        </form>
    </div>
</body>
</html>
