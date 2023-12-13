<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Summary</title>
</head>
<body>

<%
    QueryManager queryManager = new QueryManager(); // Assuming QueryManager is correctly initialized with a DB connection

    try {
        ResultSet rs = queryManager.SummaryRevenue();
        if (rs != null) {
            out.println("<table>");
            out.println("<tr><th>Username</th><th>Revenue</th></tr>");
            while (rs.next()) {
                String username = rs.getString("username");
                double revenue = rs.getDouble("revenue");
                out.println("<tr><td>" + username + "</td><td>$" + revenue + "</td></tr>");
            }
            out.println("</table>");
            rs.close();
        } else {
            out.println("<p>No revenue data found.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>Error retrieving revenue data: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>