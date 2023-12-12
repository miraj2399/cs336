<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">

function handleSubmit(questionId, reply, repUsername){
    window.location.href = 'insertQuestionToDatabase.jsp?questionId=' + encodeURIComponent(questionId) +
    '&reply=' + encodeURIComponent(reply)+
    '&repUsername=' + encodeURIComponent(repUsername) 
}
</script>

<% 
try{
	String	htmlText  = "";
	String customerId = request.getParameter("customerId");
	String customerUsername = request.getParameter("customerUsername");
	String customerQuestion = request.getParameter("customerQuestion");
	String repUsername = request.getParameter("repUsername");
	String questionId = request.getParameter("questionId");
	
	out.println("Selected question: the id is " + customerId + " and the username is " + customerUsername + " and the question is " + customerQuestion);
	out.println("Write your reply:");
	out.println("<input type='text' id='answer' name='answer' placeholder='reply'><br>");
	out.println("<button onClick='handleSubmit(\"" + questionId + "\", document.getElementById(\"answer\").value, \"" + repUsername + "\")'>Select</button><br><br>");

}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>