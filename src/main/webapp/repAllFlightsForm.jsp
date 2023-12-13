<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
     const airport = document.getElementById("airport").value;
     console.log(table, username);
     
  }
</script>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<%=session.getAttribute("user")%>, please enter the airport to find all flights for: 
  <form action="repAllFlightQuery.jsp">
  <label for="destination">airport:</label><br>
  <input type="text" id="flightId" name="airport" placeholder="airport"><br><br>  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

