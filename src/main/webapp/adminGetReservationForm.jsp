<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
     const table = document.getElementById("table").value;
     const username = document.getElementById("username").value;
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
<%=session.getAttribute("user")%>, please enter the information below to delete: 
  <form action="adminGetReservation.jsp">
  <label for="origin">Table:</label><br>
  <input type="text" id="table" name="table" placeholder="customer or flight"><br>
  <label for="destination">flight id or customer username:</label><br>
  <input type="text" id="username" name="username" placeholder="username"><br><br>  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

