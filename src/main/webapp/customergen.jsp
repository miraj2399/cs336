<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Top Customer by Revenue</title>
</head>
<body>

<%
    QueryManager queryManager = new QueryManager(); // Assuming QueryManager is correctly initialized with a DB connection

    try {
        ResultSet rs = queryManager.CustomerGeneratedRevenue();
        if (rs != null && rs.next()) {
            String username = rs.getString("username");
            double totalRevenue = rs.getDouble("Total_Revenue");

            out.println("<h2>Top Customer by Revenue</h2>");
            out.println("<p>Username: " + username + "</p>");
            out.println("<p>Total Revenue: $" + totalRevenue + "</p>");
        } else {
            out.println("<p>No data found.</p>");
        }
        if (rs != null) rs.close();
    } catch (SQLException e) {
        out.println("<p>Error retrieving data: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>