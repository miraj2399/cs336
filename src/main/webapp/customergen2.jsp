<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tickets with Max Fare</title>
</head>
<body>

<%
    String customer = request.getParameter("customer");
    if (customer != null && !customer.isEmpty()) {
        QueryManager queryManager = new QueryManager(); // Assuming QueryManager is correctly initialized with a DB connection

        try {
            ResultSet rs = queryManager.CustomerGeneratedRevenue(customer);
            if (rs != null) {
                out.println("<h2>Tickets with the Maximum Fare</h2>");
                out.println("<table border='1'>");
                out.println("<tr><th>Username</th><th>Total Fare</th></tr>");
                while (rs.next()) {
                    String username = rs.getString("username");
                    float totalFare = rs.getFloat("total_fare");
                    out.println("<tr><td>" + username + "</td><td>" + totalFare + "</td></tr>");
                }
                out.println("</table>");
                rs.close();
            } else {
                out.println("<p>No tickets found with maximum fare.</p>");
            }
        } catch (SQLException e) {
            out.println("<p>Error retrieving data: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Please provide a customer identifier.</p>");
    }
%>

</body>
</html>