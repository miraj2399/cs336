<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flight Info</title>
</head>
<body>
    <h2>Flight Information for JFK Airport</h2>
    
    <div class="dropdown">
  <button class="dropbtn">Airport Code</button>
  <div class="Airport Code">
 
  </div>
</div>
    <%
        QueryManager queryManager = new QueryManager();
        ResultSet rs = null;
        String airportCode = "JFK"; // Replace with the actual airport code
        
        try {
            rs = queryManager.getFlightsByAirport(airportCode);
            if (rs != null) {
                while (rs.next()) {
                    out.println("<p>Flight Number: " + rs.getString("id") + "</p>");
                    // Add more fields as needed
                }
            } else {
                out.println("<p>No flight information found for JFK Airport.</p>");
            }
        } catch (SQLException e) {
            out.println("<p>SQL Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<p>General Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</body>
</html>



