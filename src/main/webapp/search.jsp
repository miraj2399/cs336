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

<script type="text/javascript">

var selectedFlights = [];
var sorted = false;

function toggleSortByPrice(){
	if (sorted){
		sorted = false;
	}
	else{
		sorted = true;
	}
	if (sorted){
		// Hide u
	    document.querySelectorAll('.unsorted').forEach(function(el) {
	        el.style.display = 'none';
	    });

	    // Show all direct flights
	    document.querySelectorAll('.sorted').forEach(function(el) {
	        el.style.display = 'block';
	    });
	}
	else{
		// Hide u
	    document.querySelectorAll('.sorted').forEach(function(el) {
	        el.style.display = 'none';
	    });

	    // Show all direct flights
	    document.querySelectorAll('.unsorted').forEach(function(el) {
	        el.style.display = 'block';
	    });
	}
}
function selectFlight(flight) {
    if (selectedFlights.includes(flight)) {
        selectedFlights = selectedFlights.filter((id) => id != flight);
    } else {
        selectedFlights.push(flight);
    }
    document.getElementById(flight).innerHTML =="select"?document.getElementById(flight).innerHTML ="UNSELECT": document.getElementById(flight).innerHTML ="select";
 
    const form = document.getElementById("bookingForm");
    var hiddenInput;
    if (document.getElementById("flight-data")){
    	hiddenInput = document.getElementById("flight-data");
    }
    else{
	hiddenInput = document.createElement('input');
    }
	hiddenInput.id = "flight-data";
    hiddenInput.setAttribute("type","hidden")
    hiddenInput.setAttribute("name","flights");
    hiddenInput.value = selectedFlights.join(",");
    form.appendChild(hiddenInput);
}




function bookFlights() {
    alert("Booking flights: " + selectedFlights.join(", "),+origin+destination+date);
}



function handleDirectFilter(){
    // Hide all one-stop flights
    document.querySelectorAll('.onestop').forEach(function(el) {
        el.style.display = 'none';
    });

    // Show all direct flights
    document.querySelectorAll('.direct').forEach(function(el) {
        el.style.display = 'block';
    });

    console.log("Showing only direct flights");
}

function handleOneStopFilter(){
    // Hide all direct flights
    document.querySelectorAll('.direct').forEach(function(el) {
        el.style.display = 'none';
    });

    // Show all one-stop flights
    document.querySelectorAll('.onestop').forEach(function(el) {
        el.style.display = 'block';
    });

    console.log("Showing only one-stop flights");
}



</script>

<%
try {
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String date  = request.getParameter("date");
    String choice = request.getParameter("choice");
    QueryManager query= new QueryManager();
    String htmlText = "<div id='reserve_text' data-value ='"+ choice +"'>";
    htmlText += "<form id='bookingForm' method='POST' action='bookFlights.jsp'>"; 
    htmlText += "<input type='hidden' id='origin' name='origin' value='" + origin + "'>";
    htmlText += "<input type='hidden' id='destination' name='destination' value='" + destination + "'>";
    htmlText += "<input type='hidden' id='date' name='date' value='" + date + "'>";
    htmlText += "<button type='submit'>book<button>";
    htmlText += "</form>";
    htmlText += "</div>";
    htmlText += "<h1>Flight from: "+ origin + " to "+destination+"</h1>";
    htmlText += "<div class='filter-buttons'>";
    htmlText += "<button onclick='handleDirectFilter()'>Direct</button> ";
    htmlText += "<button onclick='handleOneStopFilter()'>One Stop</button>";
    htmlText += "<h6> Sort by: &nbsp;";
    htmlText +="<form action='sortedSearch.jsp'>";
    htmlText += "<button onClick={toggleSortByPrice()} type='submit' > price </button>";
    htmlText += "<input type='hidden' name='" + "origin" + "' value='"+origin+ "'>";
    htmlText += "<input type='hidden' name='" + "destination" + "' value='"+destination+ "'>";
    htmlText += "<input type='hidden' name='" + "choice" + "' value='"+choice+ "'>";
    htmlText += "<input type='hidden' name='" + "date" + "' value='"+date+ "'>";
    htmlText += "</form>";
    htmlText += "<button onClick={toggleSortByPrice()}> departure time </button>";
    htmlText += "<button onClick={toggleSortByPrice()}> arriving time </button>";
    htmlText += "<button onClick={toggleSortByPrice()}> duration </button>";
    htmlText += "<button onClick={toggleSortByPrice()}> none </button>";
    
    htmlText += "</div>";

    ResultSet rs = query.searchDirectFlight(origin, destination, date,false);

    htmlText += "<div class='direct'>";
    htmlText += "<h3>Direct flights:</h3>";
    htmlText += "<ul style='list-style-type:none; padding: 0;'>";
    while (rs.next()) {
        htmlText += "<li class='flight-item'>";
        htmlText += "Flight ID: " + rs.getString("id") + "<br>";
        htmlText += "Departs: " + rs.getString("departing_time") + "<br>";
        htmlText += "Arrives: " + rs.getString("arriving_time") + "<br>";
        htmlText += "Price: " + rs.getString("price");
        
        htmlText += "<button class='book-button' id='"+rs.getString("id")+"' onclick='selectFlight(\"" + rs.getString("id") + "\")'>select</button>";
        htmlText += "</li>";
    }
    htmlText += "</ul>";
    htmlText += "</div>";

    // Handling one-stop flights
    rs = query.searchOneTransitFlight(origin, destination, date);
    htmlText += "<div class='onestop'>";
    htmlText += "<h3>Flights with One Transit:</h3>";
    htmlText += "<ul style='list-style-type:none; padding: 0;'>";
    while (rs.next()) {
        htmlText += "<li class='flight-item'>";
        // Example details for one-stop flights, adjust according to your schema
        htmlText += "Transit Flight ID: " + rs.getString("f1") + "<br>";
        htmlText += "Departs: " + rs.getString("f1_departs_at") + "<br>";
        htmlText += "Arrives at Transit: " + rs.getString("f1_arrives_at") + "<br>";
        htmlText += "Connects to Flight ID: " + rs.getString("f2") + "<br>";
        htmlText += "Final Arrival: " + rs.getString("f2_arrives_at") + "<br>";
        htmlText += "<button class='book-button' onclick='selectFlight(\"" + rs.getString("f1") + "\")'>select</button>";
        htmlText += "</li>";
    }
    htmlText += "</ul>";
    htmlText += "</div>";

    out.println(htmlText);
    htmlText = "";
  
    
    if (choice.equals("roundtrip")){
    	rs = query.searchDirectFlight(destination, origin, date,false);
    	
        htmlText += "<div class='direct'>";
        htmlText += "<h3>Direct flights:</h3>";
        htmlText += "<ul style='list-style-type:none; padding: 0;'>";
        while (rs.next()) {
            htmlText += "<li class='flight-item'>";
            htmlText += "Flight ID: " + rs.getString("id") + "<br>";
            htmlText += "Departs: " + rs.getString("departing_time") + "<br>";
            htmlText += "Arrives: " + rs.getString("arriving_time") + "<br>";
            htmlText += "Price: " + rs.getString("price");
            htmlText += "<button class='book-button' id='"+rs.getString("id")+"' onclick='selectFlight(\"" + rs.getString("id") + "\")'>select</button>";
            htmlText += "</li>";
        }
        htmlText += "</ul>";
        htmlText += "</div>";

        // Handling one-stop flights
        rs = query.searchOneTransitFlight(origin, destination, date);
        htmlText += "<div class='onestop'>";
        htmlText += "<h3>Flights with One Transit:</h3>";
        htmlText += "<ul style='list-style-type:none; padding: 0;'>";
        while (rs.next()) {
            htmlText += "<li class='flight-item'>";
            // Example details for one-stop flights, adjust according to your schema
            htmlText += "Transit Flight ID: " + rs.getString("f1") + "<br>";
            htmlText += "Departs: " + rs.getString("f1_departs_at") + "<br>";
            htmlText += "Arrives at Transit: " + rs.getString("f1_arrives_at") + "<br>";
            htmlText += "Connects to Flight ID: " + rs.getString("f2") + "<br>";
            htmlText += "Final Arrival: " + rs.getString("f2_arrives_at") + "<br>";
            htmlText += "<button class='book-button' onclick='selectFlight(\"" + rs.getString("f1") + "\")'>select</button>";
            htmlText += "</li>";
        }
        htmlText += "</ul>";
        htmlText += "</div>";

        out.println(htmlText);
        
    	
    }
    
}
catch(Exception e) {
    out.println("Something went wrong");
    out.println(e);
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
	String date2  = request.getParameter("date2");
	String date3  = request.getParameter("date3");
	String date4  = request.getParameter("date4");
	String date5  = request.getParameter("date5");
	String date6  = request.getParameter("date6");
	String choice = request.getParameter("choice");
	QueryManager query= new QueryManager();
	out.println("<div id='reserve_text' data-value ='"+ choice +"'></div");
	out.println("<h1>Flight from: "+ origin + " to "+destination+"</h1>");
	ResultSet rs = null;
	if(date6 != null) {
		 rs = query.searchDirectFlight6(origin,destination,date, date2, date3, date4, date5, date6);
	} else if(date5 != null) {
		 rs = query.searchDirectFlight5(origin,destination,date, date2, date3, date4, date5);
	} else if(date4 != null) {
		 rs = query.searchDirectFlight4(origin,destination,date, date2, date3, date4);
	} else if(date3 != null) {
		 rs = query.searchDirectFlight3(origin,destination,date, date2, date3);
	} else if(date2 != null) {
		 rs = query.searchDirectFlight2(origin,destination,date, date2);
	} else {
		 rs = query.searchDirectFlight(origin,destination,date);
	}
	String htmlText ="<h3>Direct flights:</h3>";
	htmlText += "<ul>";
	while (rs.next()) {
		if(date6 != null) {
			htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";
		} else if(date5 != null) {
			htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";
		} else if(date4 != null) {
			htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";

		} else if(date3 != null) {
			htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";
		} else if(date2 != null) {
			htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";
		} else {
			 rs = query.searchDirectFlight(origin,destination,date);
		}
		htmlText = htmlText+ "<li> Flight id: "+rs.getString("id") + ", departs at " + rs.getString("departing_time")+ ", arrives at "+ rs.getString("arriving_time")+"<h5> Price: "+rs.getString("price")+"</h5>"+"<button  value='"+rs.getString("id") +"' id='"+rs.getString("id")+"' onClick='{selectFlight(this.value)} '>select</button><br><br>";
	}
	htmlText += "</ul>";
	out.println(htmlText);
	htmlText  = "";
	
	rs = query.searchOneTransitFlight(origin,destination,date);
	
	htmlText ="<h3>Flight with one  Transit:</h3>";
	htmlText += "<ul>";/	while (rs.next()) htmlText = htmlText+ "<li> Start with flight: "+rs.getString("f1") + ", Departs at " + rs.getString("f1_departs_at")+ ", Arrives at "+ rs.getString("f1_arrives_at") +
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
		
		out.println("<button onclick=jasminButton()'>JASMINBUTTON</button>");
	}
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}

%>
--%>