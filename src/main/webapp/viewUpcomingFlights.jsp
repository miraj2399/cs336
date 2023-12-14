<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
    .business-class {
        color: gold;
        font-weight: bold;
        font-size: 1.2em;
        background-color: #f2f2f2;
        padding: 5px;
        border-radius: 5px;
        display: inline-block;
        border: 1px solid gold;
        margin: 2px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
</style>
</head>
<body>
<%
QueryManager query = new QueryManager();
String today = request.getParameter("today");
String username = session.getAttribute("user").toString();
ResultSet rs = query.getUpcomingReservations(username, today, false);
String s;
out.println("<ul>");
while(rs.next()){
    out.println("<li>");
    s = "flight id: ";
    out.println(s + rs.getString("flight_id") + "<br>");
    s = "departs at: ";
    out.println("<strong>" + s + rs.getString("departs_date") + "</strong><br>");
    s = "from: ";
    out.println(s + rs.getString("from_airport") + "<br>");
    s = "to: ";
    out.println(s + rs.getString("to_airport") + "<br>");
    s = "booking id: ";
    out.println(s + rs.getString("booking_id") + "<br>");
    s = "ticket id: ";
    out.println(s + rs.getString("ticket_id") + "<br>");
    s = "class: ";
    String classValue = rs.getString("class").equals("1") ? "business" : "economy";
    String classStyle = classValue.equals("business") ? "business-class" : "";
    out.println(s + "<span class='" + classStyle + "'>" + classValue + "</span><br>");
    out.println("</li><br><br><br>");
}
out.println("</ul>");
%>
</body>
</html>
