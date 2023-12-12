<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">

function handleSubmit(){
    

	
}
</script>

<% 
try{
	String	htmlText  = "";
	String questionId = request.getParameter("questionId");
	String reply = request.getParameter("reply");
	String repUsername = request.getParameter("repUsername");
		
	QueryManager query= new QueryManager();
	query.insertReply(reply, repUsername, questionId);
	response.sendRedirect("customerRep.jsp");

	}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>