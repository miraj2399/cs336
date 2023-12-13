
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
  
    <br><br>

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


<%--
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
     const date2 = document.getElementById("date2").value;
     const date3 = document.getElementById("date3").value;
     const date4 = document.getElementById("date4").value;
     const date5 = document.getElementById("date5").value;
     const date6 = document.getElementById("date6").value;

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
    <input type="date" id="date2" name="date2"><br><br><br>
    <input type="date" id="date3" name="date3"><br><br><br>
    <input type="date" id="date4" name="date4"><br><br><br>
    <input type="date" id="date5" name="date5"><br><br><br>
    <input type="date" id="date6" name="date6"><br><br><br>
  
  <input type="radio" id="oneway" name="choice" value="oneway" checked>
  <label for="oneway">One way</label>
  <input type="radio" id="roundtrip" name="choice" value="roundtrip">
  <label for="roundtrip">Round trip</label> <br><br>
  
  
  <  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  

<br>
<a href='logout.jsp'>Log out</a>
<br>
<br>
<br>
 <form action="browsefile.jsp"> <!-- Update the action attribute here -->
    <!-- Your existing form elements -->
<input type="submit" value="Browse Questions" onClick="handleSubmit()">
  </form>
 <form action="searchfile.jsp"> <!-- Update the action attribute here -->
    <!-- Your existing form elements -->
    
   <input type="submit" value="Search Questions" onClick="handleSubmit()">
   
     </form>
   <form action="postfile.jsp"> <!-- Update the action attribute here -->
    <!-- Your existing form elements -->
    
   <input type="submit" value="Post Questions" onClick="handleSubmit()">
    </form>
  

<%
}
%>
--%>
