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
     const firstname = document.getElementById("firstname").value;
     console.log(table, username, firstname);
     
  }
</script>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<%=session.getAttribute("user")%>, please enter the information below to edit: 
  <form action="adminEditPerson.jsp">
  <label for="origin">Table:</label><br>
  <input type="text" id="table" name="table" placeholder="customer or custRep"><br>
  <label for="destination">Username to make changes to:</label><br>
  <input type="text" id="username" name="username" placeholder="username"><br><br>
  <label for="destination">First Name to be updated:</label><br>
  <input type="text" id="username" name="firstname" placeholder="firstname"><br><br>  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>
