<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Most Active Flights</title>
</head>
<body>

<%
    QueryManager queryManager = new QueryManager(); // Assuming QueryManager is correctly initialized with a DB connection

    try {
        ResultSet rs = queryManager.getMostActiveFlights();
        if (rs != null) {
            out.println("<h2>Most Active Flights</h2>");
            out.println("<table border='1'>");
            out.println("<tr><th>Flight ID</th><th>Frequency</th></tr>");
            while (rs.next()) {
                String flightId = rs.getString("flight_id");
                int frequency = rs.getInt("frequency");
                out.println("<tr><td>" + flightId + "</td><td>" + frequency + "</td></tr>");
            }
            out.println("</table>");
            rs.close();
        } else {
            out.println("<p>No active flights found.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>Error retrieving data: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>