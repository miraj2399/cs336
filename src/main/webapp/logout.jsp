<%
session.invalidate();
//session.getAttribute("user"); 
response.sendRedirect("login.jsp");
%>
