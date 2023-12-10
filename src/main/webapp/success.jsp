<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
     const origin = document.getElementById("origin").value;
     const destination = document.getElementById("destination").value;
     const date = document.getElementById("date").value;
     const choice = document.getElementById("roundtrip").checked?"roundtrip":"oneway";
     console.log(origin,destination,date,choice);
     
  }
</script>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%> 
  <form action="search.jsp">
  <label for="origin">From:</label><br>
  <input type="text" id="origin" name="origin" placeholder="EWR"><br>
  <label for="destination">To:</label><br>
  <input type="text" id="destination" name="destination" placeholder="LAX"><br><br>
  <input type="date" id="date" name="date"><br><br><br>
  
  <input type="radio" id="oneway" name="choice" value="oneway" checked>
  <label for="oneway">One way</label>
  <input type="radio" id="roundtrip" name="choice" value="roundtrip">
  <label for="roundtrip">Round trip</label> <br><br>
  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

