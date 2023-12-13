<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<style>
    .flight-container {
        font-family: Arial, sans-serif;
        margin: 10px;
    }
    .flight-header {
        background-color: #f2f2f2;
        padding: 10px;
        text-align: center;
    }
    .flight-list {
        list-style: none;
        padding: 0;
    }
    .flight-item {
        background-color: #f2f2f2;
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .book-button {
        background-color: green;
        color: white;
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }
    .flight-details {
        margin-right: 10px;
    }
    
    .filter-buttons {
        text-align: center;
        margin-bottom: 20px;
    }
    .filter-button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        margin: 5px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    </style>

<% 
try{
	String choice = request.getParameter("choice");
	String repUsername = request.getParameter("repUsername");
	String htmlText = "";
	ResultSet rs;
	if(choice.equals("browse")) {
		response.sendRedirect("browsefile.jsp?username="+repUsername);
	} else if (choice.equals("search")) {
		response.sendRedirect("searchfile.jsp?username="+repUsername);
	} else if (choice.equals("post")) {
		response.sendRedirect("postfile.jsp?username="+repUsername);
	}	
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>