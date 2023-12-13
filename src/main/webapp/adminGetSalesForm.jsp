<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
     const month = document.getElementById("month").value;
     const month = document.getElementById("year").value;

     console.log(month);
     
  }
</script>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<%=session.getAttribute("user")%>, please type a month (first three characters only): 
  <form action="adminGetSalesQuery.jsp">
  <label for="origin">Type the month (Ex: 1,2,3,4,5,6,7,8,9,10,11,12):</label><br>
  <input type="text" id="month" name="month" placeholder="month"><br> 
  <label for="origin">Type the year (Ex: 2023, 2021):</label><br>
  <input type="text" id="year" name="year" placeholder="year"><br> 
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

