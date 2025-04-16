<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Attendance</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .menu { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }
        .menu a { margin-right: 15px; text-decoration: none; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; margin-right: 10px; }
        input[type="date"] { padding: 5px; }
        button { padding: 6px 12px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .success { background-color: #dff0d8; color: #3c763d; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Portal</h1>
        
        <div class="menu">
            <a href="index.jsp">Home</a>
            <a href="viewStudents.jsp">View Students</a>
            <a href="<a href="markAttendance.jsp">Mark Attendance</a>
            <a href="viewAttendance.jsp">View Attendance</a>
        </div>
        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="success">
                Attendance has been successfully saved!
            </div>
        <% } %>
        
        <h2>View Attendance</h2>
        
        <form action="viewAttendance.jsp" method="get">
            <div class="form-group">
                <label for="date">Select Date:</label>
                <input type="date" id="date" name="date" required 
                       value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">
                <button type="submit">View</button>
            </div>
        </form>
        
        <%
        String dateParam = request.getParameter("date");
        if (dateParam != null && !dateParam.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal", "root", "password");
                
                String sql = "SELECT a.id, s.name, s.roll_number, s.course, a.status, a.remarks " +
                             "FROM attendance a " +
                             "JOIN students s ON a.student_id = s.id " +
                             "WHERE a.date = ? " +
                             "ORDER BY s.name";
                             
                pstmt = conn.prepareStatement(sql);
                pstmt.setDate(1, java.sql.Date.valueOf(dateParam));
                rs = pstmt.executeQuery();
                
                SimpleDateFormat formatter = new SimpleDateFormat("EEEE, MMMM d, yyyy");
                java.util.Date date = java.sql.Date.valueOf(dateParam);
                %>
                
                <h3>Attendance for <%= formatter.format(date) %></h3>
                
                <table>
                    <tr>
                        <th>Student Name</th>
                        <th>Roll Number</th>
                        <th>Course</th>
                        <th>Status</th>
                        <th>Remarks</th>
                    </tr>
                    
                    <%
                    boolean hasRecords = false;
                    while(rs.next()) {
                        hasRecords = true;
                        %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("roll_number") %></td>
                            <td><%= rs.getString("course") %></td>
                            <td>
                                <% 
                                String status = rs.getString("status");
                                String statusColor = "black";
                                if ("Present".equals(status)) statusColor = "green";
                                else if ("Absent".equals(status)) statusColor = "red";
                                else if ("Late".equals(status)) statusColor = "orange";
                                %>
                                <span style="color: <%= statusColor %>"><%= status %></span>
                            </td>
                            <td><%= rs.getString("remarks") != null ? rs.getString("remarks") : "" %></td>
                        </tr>
                        <%
                    }
                    
                    if (!hasRecords) {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center;">No attendance records found for this date.</td>
                        </tr>
                        <%
                    }
                    %>
                </table>
                <%
            } catch(Exception e) {
                out.println("<div style='color: red;'>Error: " + e.getMessage() + "</div>");
            } finally {
                try { if(rs != null) rs.close(); } catch(Exception e) { }
                try { if(pstmt != null) pstmt.close(); } catch(Exception e) { }
                try { if(conn != null) conn.close(); } catch(Exception e) { }
            }
        }
        %>
    </div>
    

