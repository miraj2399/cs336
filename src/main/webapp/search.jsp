<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">

var selectedFlights = [];
function selectFlight(flight){
	selectedFlights.includes(flight)?selectedFlights=selectedFlights.filter((id)=>{return id!=flight}):selectedFlights.push(flight);
	console.log(selectedFlights);
	changeButtonText(flight);
	const reserve_section = document.getElementById("reserve_text");
	const type = reserve_section.getAttribute("data-value")
	console.log(type);
	const reserveButton = document.createElement('button');
	reserveButton.textContent = 'Book now! ';
	
	
	if (type=="oneway" && selectedFlights.length==1) {
		reserve_section.appendChild(reserveButton);
	}
	else if (type=="roundtrip" && selectedFlights.length==2) {
		reserve_section.appendChild(reserveButton);
	}
	else{
		reserve_section.innerHTML="";
}
}
function changeButtonText(buttonid){
	document.getElementById(buttonid).innerHTML =="select"?document.getElementById(buttonid).innerHTML ="UNSELECT": document.getElementById(buttonid).innerHTML ="select";
}
</script>

<% 
try{
	
	String origin = request.getParameter("origin");
	String destination = request.getParameter("destination");
	String date  = request.getParameter("date");
	String choice = request.getParameter("choice");
	QueryManager query= new QueryManager();
	out.println("<div id='reserve_text' data-value ='"+ choice +"'></div");
	out.println("<h1>Flight from: "+ origin + " to "+destination+"</h1>");
	ResultSet rs = query.searchDirectFlight(origin,destination,date);
	String htmlText ="<h3>Direct flights:</h3>";
	htmlText += "<ul>";
	while (rs.next()) htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";
	htmlText += "</ul>";
	out.println(htmlText);
	htmlText  = "";
	
	rs = query.searchOneTransitFlight(origin,destination,date);
	
	htmlText ="<h3>Flight with one  Transit:</h3>";
	htmlText += "<ul>";
	while (rs.next()) htmlText = htmlText+ "<li> Start with flight: "+rs.getString("f1") + ", Departs at " + rs.getString("f1_departs_at")+ ", Arrives at "+ rs.getString("f1_arrives_at") +
			" on "+ rs.getString("connecting") + " airport." + " Then take flight " + rs.getString("f2") + " departing at " + rs.getString("f2_departs_at") + " and by " + rs.getString("f2_arrives_at") + " you will be at your destination."+"<br><button>book</button><br><br>";

	htmlText += "</ul>";
	out.println(htmlText);
	htmlText  = "";
	
	if (choice.equals("roundtrip")){
		out.println("<h1>Flight from: "+ destination + " to "+origin+"</h1>");
		rs = query.searchDirectFlight(destination,origin,date);
		htmlText ="<h3>Direct flights:</h3>";
		htmlText += "<ul>";
		while (rs.next()) htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button>book</button><br><br>";
		htmlText += "</ul>";
		out.println(htmlText);
		htmlText  = "";
		
		rs = query.searchOneTransitFlight(destination,origin,date);
		
		htmlText ="<h3>Flight with one  Transit:</h3>";
		htmlText += "<ul>";
		while (rs.next()) htmlText = htmlText+ "<li> Start with flight: "+rs.getString("f1") + ", Departs at " + rs.getString("f1_departs_at")+ ", Arrives at "+ rs.getString("f1_arrives_at") +
				" on "+ rs.getString("connecting") + " airport." + " Then take flight " + rs.getString("f2") + " departing at " + rs.getString("f2_departs_at") + " and by " + rs.getString("f2_arrives_at") + " you will be at your destination."+"<br><button>book</button><br><br>";
		htmlText += "</ul>";
		out.println(htmlText);
		
		
	}
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>