<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
	 const id = document.getElementById("id").value;
     const departing = document.getElementById("departing").value;
     const arriving = document.getElementById("arriving").value;
   
     
  }
</script>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<%=session.getAttribute("user")%>, please enter the information below to edit the departing and arriving airport for the flight: 
  <form action="repEditFlight.jsp">
  <label for="origin">Flight id to be edited:</label><br>
  <input type="text" id="id" name="id" placeholder="id"><br>
  <label for="destination">New departing airport:</label><br>
  <input type="text" id="departing" name="departing" placeholder="departing"><br><br> 
  <label for="destination">New arriving airport:</label><br>
  <input type="text" id="arriving" name="arriving" placeholder="arriving"><br><br>  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

