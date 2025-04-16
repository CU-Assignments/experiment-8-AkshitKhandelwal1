import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    
    // JDBC URL, username and password
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/student_portal";
    static final String USER = "root";
    static final String PASS = "password";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Register JDBC driver
            Class.forName(JDBC_DRIVER);
            
            // Open a connection
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            
            // Get form data
            String dateStr = request.getParameter("date");
            int studentCount = Integer.parseInt(request.getParameter("studentCount"));
            
            // Prepare SQL statement
            String sql = "INSERT INTO attendance (student_id, date, status, remarks) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Process each student's attendance
            for (int i = 0; i < studentCount; i++) {
                int studentId = Integer.parseInt(request.getParameter("studentId" + i));
                String status = request.getParameter("status" + i);
                String remarks = request.getParameter("remarks" + i);
                
                pstmt.setInt(1, studentId);
                pstmt.setDate(2, java.sql.Date.valueOf(dateStr));
                pstmt.setString(3, status);
                pstmt.setString(4, remarks);
                
                pstmt.executeUpdate();
            }
            
            // Commit transaction
            conn.commit();
            
            // Redirect to view attendance page
            response.sendRedirect("viewAttendance.jsp?date=" + dateStr + "&success=true");
            
        } catch(Exception e) {
            // Rollback in case of error
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
            
            out.println("<html><head>");
            out.println("<title>Error</title>");
            out.println("<style>body { font-family: Arial, sans-serif; margin: 20px; }</style>");
            out.println("</head><body>");
            out.println("<h2>Error Saving Attendance</h2>");
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
            out.println("<a href='markAttendance.jsp'>Try Again</a>");
            out.println("</body></html>");
            
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
                if(conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch(SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
