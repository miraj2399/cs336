package com.cs336.pkg;
import  java.util.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.DayOfWeek;

public class QueryManager {
	private Connection connection;
	public QueryManager() {
		this.connection = getConnection();
	}

	
public Connection getConnection() {
		
		//Create a connection string
		String connectionUrl = "jdbc:mysql://localhost:3306/flight_reservation";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "rootroot");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}

public String ConvertDateToSpecialString(String dateString) {
	//Define the formatter based on the expected format of the date string
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    // Parse the date string into a LocalDate object
    LocalDate date = LocalDate.parse(dateString, formatter);

    // Get the DayOfWeek enum for the parsed date
    DayOfWeek dayOfWeek = date.getDayOfWeek();

    // Get the integer value of the day of the week (1=Monday, 7=Sunday)
    int dayOfWeekInt = dayOfWeek.getValue();
    String dayOfWeekString;
    
    switch (dayOfWeekInt) {
    case 1:
    	dayOfWeekString = "1______";
        break;
    case 2:
    	dayOfWeekString = "_1_____";
        break;
    case 3:
    	dayOfWeekString = "__1____";
        break;
    case 4:
    	dayOfWeekString = "___1___";
        break;
    case 5:
    	dayOfWeekString = "____1__";
        break;
    case 6:
    	dayOfWeekString = "_____1_";
        break;
    case 7:
    	dayOfWeekString = "______1";
        break;
    default:
    	dayOfWeekString = "Invalid day";
        break;
}
    return dayOfWeekString;
	
}

public ResultSet searchDirectFlight(String origin, String destination, String dateString, Boolean sorted) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		String q = "select * from flight where arriving_airport='"+destination +"' and departing_airport='"+origin+"'" + "and day_of_week like '"+dayOfWeekString+"'";
		if (sorted) {
			q+=" order by price asc";
		}
		rs = st.executeQuery(q);
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	
}

public ResultSet searchOneTransitFlight(String origin, String destination, String dateString) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery(
				  "select f1.id as f1, f2.id as f2,"
				+ "f1.day_of_week as day_of_week_f1,"
				+ " f2.day_of_week as day_of_week_f2,"
				+ "f1.arriving_time as f1_arrives_at,"
				+ "f1.departing_time as f1_departs_at,"
				+ "f2.departing_time as f2_departs_at,"
				+ "f2.arriving_time as f2_arrives_at,"
				+ " f1.departing_airport as origin,"
				+ " f1.arriving_airport as connecting,"
				+ " f2.arriving_airport as destination"
				+ " from flight f1 join flight f2"
				+ " on f1.arriving_airport=f2.departing_airport"
				+ " where f1.departing_airport='"+origin+"' "
				+ "and  f2.arriving_airport='"+destination+"' "
				+ " and f2.departing_time>f1.arriving_time"
				+ " and f2.departing_time-f1.arriving_time>=500"
				+ " and f1.day_of_week like '" + dayOfWeekString+"' "
				// don't need to do anything  else, if only allow same day transit flight
				+ " and f2.day_of_week like '"+ dayOfWeekString+"'"
			);
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	

}

public ResultSet authenticate(String username, String password) {
	Statement st;
	try {
		st = this.connection.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from customer where username='"+username+"' and password='"+password+"'");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
}



public int createTicket(String username,String flight1,String flight2) {
	try {
	Statement st = this.connection.createStatement();
	java.util.Date utilDate = new java.util.Date();
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
    int price = 0;
    
    
	ResultSet rs1 ;
	 st = this.connection.createStatement();
	String q = "select price from flight where id='"+flight1+"';";
	System.out.print(q);
	System.out.print("\n");
	rs1 = st.executeQuery(q);
	if (rs1.next()) {
		price+=Integer.parseInt(rs1.getString("price"));
	}
	System.out.println(price);
	
	if (flight2!=null) {
		q = "select price from flight where id='"+flight2+"';";
		rs1 = st.executeQuery(q);
		if (rs1.next()) {
			price+=Integer.parseInt(rs1.getString("price"));
		}
	}
	
	
	
	q = "insert into ticket(username,date_purchased,total_fare) values('"+username +  "', '"+sqlDate+"', "+price+");";
	int rs;
	System.out.print(q);
	rs = st.executeUpdate(q);
	q = "select Max(id) as maxid from ticket";
	 rs1 = st.executeQuery(q);
	if (rs1.next()) {
		System.out.println("ticket id: "+ rs1.getString("maxid"));
	return Integer.parseInt(rs1.getString("maxid"));
	}
	return -1;
	}
	catch(Exception e) {
		System.out.print(e);
		return -1;
	}
	
}	
public int createBooking(String from, String to, String username,String flight1, String flight2) {
	try {
	int ticket_id = createTicket(username,flight1,flight2);
	
	Statement st = this.connection.createStatement();
	 String q = "insert into booking(from_airport,to_airport,ticket_id) values('"+from+"', '"+to+"', "+ticket_id+");";
	int rs;
	rs = st.executeUpdate(q);
	ResultSet rs1;
	q = "select Max(id) as maxid from booking";
	rs1 = st.executeQuery(q);
	if (rs1.next()) {
		return Integer.parseInt(rs1.getString("maxid"));
		}
	return -1;
	}
	catch(Exception e) {
		System.out.println(e);
		return -1;
	}	
}

public int updateItinerary(String from, String to, String username, String flight1, String flight2, String departs) {
	
	try {
		
		int booking_num = createBooking(from,to,username,flight1,flight2);
		System.out.println(booking_num);
		Statement st = this.connection.createStatement();
		String q;
		ResultSet rs;
		String arrives;
		Random random;
		int c;
		int seat;
		String plane_id;
		
		q = "select * from flight where id='"+flight1+"';";
		rs = st.executeQuery(q);
		plane_id = "";
		if (rs.next()) {
			 plane_id = rs.getString("aircraft_id");
		}
		arrives = departs;
		random = new Random();
		c = random.nextInt(2);
		seat = random.nextInt(101);
		q = "insert into itinerary values(";
		q+= booking_num;
		q+=", '";
		q+=flight1;
		q+="', '";
		q+=departs;
		q+="', '";
		q+=arrives;
		q+="', ";
		q+= seat;
		q+= ", ";
		q+=c;
		q+= ", ";
		q+= Integer.parseInt(plane_id);
		q+= ");";
		
		int rs1 = st.executeUpdate(q);
		
		
		if (flight2!=null) {
			q = "select * from flight where id='"+flight2+"';";
			rs = st.executeQuery(q);
			plane_id = "";
			if (rs.next()) {
				 plane_id = rs.getString("aircraft_id");
			}
			arrives = departs;
			random = new Random();
			c = random.nextInt(2);
			seat = random.nextInt(101);
			q = "insert into itinerary values(";
			q+= booking_num;
			q+=", '";
			q+=flight2;
			q+="', '";
			q+=departs;
			q+="', '";
			q+=arrives;
			q+="', ";
			q+= seat;
			q+= ", ";
			q+=c;
			q+= ", ";
			q+= Integer.parseInt(plane_id);
			q+= ");";
			int rs2 = st.executeUpdate(q);
			return rs2;

		}
		return rs1;
		
	} catch (SQLException e) {
		
		// TODO Auto-generated catch block
		System.out.println(e);
		e.printStackTrace();
		return -1;
	}
	
	
}

public Boolean checkAvailability(String from, String to, String flight, String date) {
	try {

		int numberOfSeats = 0;
		String q = "select seat_num from plane where id = (select aircraft_id from flight  where id =\""+ flight + "\" )";
		Statement st = this.connection.createStatement();
		ResultSet rs ;
		rs = st.executeQuery(q);
		if (rs.next()) {
		numberOfSeats = Integer.parseInt(rs.getString("seat_num"));
		}
		int numberOfReservations = 0;
		q= " select count(*) as n from itinerary where flight_id=\""+flight+"\" and departs_date = '"+date+"';";
		rs = st.executeQuery(q);
		if (rs.next()) {
			numberOfReservations = Integer.parseInt(rs.getString("n"));
			}
		
	    
	    
		
		return numberOfReservations<numberOfSeats;
	}
	catch(Exception e){
		System.out.print(e);
		return false;
	}
}

}
	
	
	
	
	
	