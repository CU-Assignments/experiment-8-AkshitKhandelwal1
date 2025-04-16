import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
    
    // JDBC URL, username and password
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/employeedb";
    static final String USER = "root";
    static final String PASS = "password";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        Connection conn = null;
        Statement stmt = null;
        
        try {
            // Register JDBC driver
            Class.forName(JDBC_DRIVER);
            
            // Open a connection
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            
            // Execute SQL query
            stmt = conn.createStatement();
            String sql;
            ResultSet rs;
            
            String action = request.getParameter("action");
            String empId = request.getParameter("empId");
            
            out.println("<html><head><title>Employee Database</title></head><body>");
            
            if ("viewAll".equals(action)) {
                // Display all employees
                sql = "SELECT * FROM employees";
                rs = stmt.executeQuery(sql);
                
                displayEmployeeTable(out, rs);
                
            } else if (empId != null && !empId.isEmpty()) {
                // Search by employee ID
                sql = "SELECT * FROM employees WHERE id = " + empId;
                rs = stmt.executeQuery(sql);
                
                if (rs.next()) {
                    out.println("<h2>Employee Details</h2>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>ID</th><th>Name</th><th>Department</th><th>Salary</th></tr>");
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("name") + "</td>");
                    out.println("<td>" + rs.getString("department") + "</td>");
                    out.println("<td>" + rs.getDouble("salary") + "</td>");
                    out.println("</tr>");
                    out.println("</table>");
                } else {
                    out.println("<h2>No employee found with ID: " + empId + "</h2>");
                }
            } else {
                out.println("<h2>Please enter an employee ID or view all employees</h2>");
            }
            
            out.println("<br><a href='employeeSearch.html'>Back to Search</a>");
            out.println("</body></html>");
            
            // Clean-up environment
            if (rs != null) rs.close();
            stmt.close();
            conn.close();
            
        } catch(SQLException se) {
            out.println("<h2>Database Error: " + se.getMessage() + "</h2>");
        } catch(Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        } finally {
            try {
                if(stmt!=null) stmt.close();
            } catch(SQLException se2) {}
            try {
                if(conn!=null) conn.close();
            } catch(SQLException se) {}
        }
    }
    
    private void displayEmployeeTable(PrintWriter out, ResultSet rs) throws SQLException {
        out.println("<h2>All Employees</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Name</th><th>Department</th><th>Salary</th></tr>");
        
        while(rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("department") + "</td>");
            out.println("<td>" + rs.getDouble("salary") + "</td>");
            out.println("</tr>");
        }
        
        out.println("</table>");
    }
}
