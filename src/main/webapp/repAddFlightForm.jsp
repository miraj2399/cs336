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
     const dayOfWeek = document.getElementById("dayOfWeek").value;
     const departing = document.getElementById("departing").value;
     const arriving = document.getElementById("arriving").value;
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
<%=session.getAttribute("user")%>, please enter the information below to add: 
  <form action="repAddFlight.jsp">
  <label for="origin">Id:</label><br>
  <input type="text" id="id" name="id" placeholder="id"><br>
    <label for="origin">Day of Week:</label><br>
  <input type="text" id="dayOfWeek" name="dayOfWeek" placeholder="0000000"><br>
  <label for="destination">Departing airport:</label><br>
  <input type="text" id="departing" name="departing" placeholder="EWR"><br><br>  
  <label for="destination">Arriving airport:</label><br>
  <input type="text" id="arriving" name="arriving" placeholder="LAX"><br><br>  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

