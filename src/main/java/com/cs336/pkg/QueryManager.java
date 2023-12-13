package com.cs336.pkg;

import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
			connection = DriverManager.getConnection(connectionUrl,"root", "harmit10");
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



public int createTicket(String username) {
	try {
	Statement st = this.connection.createStatement();
	java.util.Date utilDate = new java.util.Date();
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	String q = "insert into ticket(username,date_purchased) values('"+username +  "', '"+sqlDate+"')";
	int rs;
	rs = st.executeUpdate(q);
	q = "select Max(id) as maxid from ticket";
	ResultSet rs1 = st.executeQuery(q);
	if (rs1.next()) {
	return Integer.parseInt(rs1.getString("maxid"));
	}
	return -1;
	}
	catch(Exception e) {
		System.out.print(e);
		return -1;
	}
	
}	
public int createBooking(String from, String to, String username) {
	try {
	int ticket_id = createTicket(username);
	Statement st = this.connection.createStatement();
	String q = "insert into booking(from_airport,to_airport,ticket_id) values('"+from+"', '"+to+"', "+ticket_id+");";
	int rs;
	rs = st.executeUpdate(q);
	q = "select Max(id) as maxid from booking";
	ResultSet rs1 = st.executeQuery(q);
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
		
		int booking_num = createBooking(from,to,username);
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


public ResultSet searchDirectFlight6(String origin, String destination, String dateString, String dateString2, String dateString3, String dateString4, String dateString5, String dateString6) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		String dayOfWeekString2 = ConvertDateToSpecialString(dateString2);
		String dayOfWeekString3 = ConvertDateToSpecialString(dateString3);
		String dayOfWeekString4 = ConvertDateToSpecialString(dateString4);
		String dayOfWeekString5 = ConvertDateToSpecialString(dateString5);
		String dayOfWeekString6 = ConvertDateToSpecialString(dateString6);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery("select * from flight where arriving_airport='"+destination +"' and departing_airport='"+origin+"'" + "and (day_of_week like '"+dayOfWeekString+"' OR day_of_week like '"+dayOfWeekString2+"' OR day_of_week like '"+dayOfWeekString3+"' OR day_of_week like '"+dayOfWeekString4+"' OR day_of_week like '"+dayOfWeekString5+"' OR day_of_week like '"+dayOfWeekString6+"')");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	
}

public ResultSet searchDirectFlight5(String origin, String destination, String dateString, String dateString2, String dateString3, String dateString4, String dateString5) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		String dayOfWeekString2 = ConvertDateToSpecialString(dateString2);
		String dayOfWeekString3 = ConvertDateToSpecialString(dateString3);
		String dayOfWeekString4 = ConvertDateToSpecialString(dateString4);
		String dayOfWeekString5 = ConvertDateToSpecialString(dateString5);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery("select * from flight where arriving_airport='"+destination +"' and departing_airport='"+origin+"'" + "and (day_of_week like '"+dayOfWeekString+"' OR day_of_week like '"+dayOfWeekString2+"' OR day_of_week like '"+dayOfWeekString3+"' OR day_of_week like '"+dayOfWeekString4+"' OR day_of_week like '"+dayOfWeekString5+"')");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	
}

public ResultSet searchDirectFlight4(String origin, String destination, String dateString, String dateString2, String dateString3, String dateString4) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		String dayOfWeekString2 = ConvertDateToSpecialString(dateString2);
		String dayOfWeekString3 = ConvertDateToSpecialString(dateString3);
		String dayOfWeekString4 = ConvertDateToSpecialString(dateString4);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery("select * from flight where arriving_airport='"+destination +"' and departing_airport='"+origin+"'" + "and (day_of_week like '"+dayOfWeekString+"' OR day_of_week like '"+dayOfWeekString2+"' OR day_of_week like '"+dayOfWeekString3+"' OR day_of_week like '"+dayOfWeekString4+"')");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	
}

public ResultSet searchDirectFlight3(String origin, String destination, String dateString, String dateString2, String dateString3) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		String dayOfWeekString2 = ConvertDateToSpecialString(dateString2);
		String dayOfWeekString3 = ConvertDateToSpecialString(dateString3);
		
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery("select * from flight where arriving_airport='"+destination +"' and departing_airport='"+origin+"'" + "and (day_of_week like '"+dayOfWeekString+"' OR day_of_week like '"+dayOfWeekString2+"' OR day_of_week like '"+dayOfWeekString3+"')");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	
}



	



//askQuestion(question, username)

/*

public void askQuestion(String question, String username) {
	
	Statement st;
	try {
		
		st = this.connection.createStatement();
		int rs;
		rs = st.executeUpdate("Insert into question(question, username) values('"+question+"'+','+'"username+"')");
	} catch (SQLException e) {
		//INSERT INTO question (customer, question) VALUES ('Adam412', 'Second question?');
		// INTO question (customer, question) VALUES ('Adam412', 'Second question?');
		// TODO Auto-generated catch block
		e.printStackTrace();
		//return null;
	}
}
*/

public ResultSet getReservationsByFlightNumber(String flightNumber) {
    ResultSet rs; // Declare ResultSet without assigning a value
    try {
        // Prepare SQL query to find reservations for the given flight number
        String query = "SELECT " +
                "B.id, F.id"+
                " FROM Booking B " +
                "JOIN Itinerary I ON B.id = I.booking_id " +
                "JOIN Flight F ON I.flight_id =F.id " +
                "WHERE F.id = ?";
        System.out.println(query);
        PreparedStatement pst = this.connection.prepareStatement(query);
        pst.setString(1, flightNumber);
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        rs = null; // Set rs to null in case of an exception
    }
    return rs;
}


public ResultSet salesMethod(String monthString, String year) {
    ResultSet rs = null;
    try {
        // Convert the month string to an integer
        int monthNum = Integer.parseInt(monthString);
        int yearNum = Integer.parseInt(year);
     
      

        // Prepare the SQL query to find the total sales for the given month
        String query = "SELECT SUM(total_fare) AS Total_Revenue " +
                "FROM ticket " +
                "WHERE MONTH(date_purchased) = ? " +  // Space added here
                "AND YEAR(date_purchased) = ?";       // Space added here

                     

        PreparedStatement pst = this.connection.prepareStatement(query);
        pst.setInt(1, monthNum);
        pst.setInt(2, yearNum);
        rs = pst.executeQuery();

        // Uncomment this to print the SQL query in the console
        // System.out.println(query);

    } catch (NumberFormatException e) {
        System.err.println("Invalid month format: " + monthString);
        e.printStackTrace();
    } catch (SQLException e) {
        System.err.println("SQL Error: " + e.getMessage());
        e.printStackTrace();
    }
    return rs;
}


public ResultSet ReservationsFlight(String flightNumber) {

    ResultSet rs = null;
    try {
        String query = "SELECT booking_id, flight_id, departs_date, arrives_date, seat_no, class, plane_id " +
                       "FROM Itinerary " +
                       "WHERE flight_id = ?";
        System.out.println(query); // Debug: Print query

        PreparedStatement pst = this.connection.prepareStatement(query);
        pst.setString(1, flightNumber);
        rs = pst.executeQuery();

        if (!rs.next()) { 
            System.out.println("No data found for flight number: " + flightNumber); // Debug: No data found
            return null; // or handle accordingly
        } else {
            rs.beforeFirst(); // Reset cursor position
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Debug: Print stack trace
        System.out.println(e);

        return null; // Return null or handle the exception as required
    }
    return rs; // Return the ResultSet
}




public ResultSet SummaryRevenue() {
    ResultSet rs = null; // Declare ResultSet without assigning a value
    try {
        // Prepare SQL query to find revenue for each username
        String query = "SELECT username, total_fare as revenue FROM Ticket";

        System.out.println(query); // Print the query for debugging

        PreparedStatement pst = this.connection.prepareStatement(query);
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        rs = null; // Set rs to null in case of an exception
    }
    return rs;
}


public ResultSet getTicketsWithMaxFare() {
    ResultSet rs = null; // Declare ResultSet without assigning a value
    try {
        // Prepare SQL query to find the ticket(s) with the maximum fare
        String query = "SELECT username, total_fare " +
                       "FROM ticket t " +
                       "WHERE t.total_fare = (SELECT MAX(total_fare) FROM ticket)";

        System.out.println(query); // Print the query for debugging purposes

        PreparedStatement pst = this.connection.prepareStatement(query);
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        rs = null; // Set rs to null in case of an exception
    }
    return rs;
}


public ResultSet CustomerGeneratedRevenue() {
    ResultSet rs = null; // Declare ResultSet without assigning a value
    try {
        // Prepare SQL query to find the customer who generated the most total revenue
        String query = "SELECT username, SUM(total_fare) AS Total_Revenue " +
                       "FROM ticket " +
                       "GROUP BY username " +
                       "ORDER BY SUM(total_fare) DESC " +
                       "LIMIT 1";

        System.out.println(query); // Print the query for debugging

        PreparedStatement pst = this.connection.prepareStatement(query);
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        rs = null; // Set rs to null in case of an exception
    }
    return rs;
}


public ResultSet getMostActiveFlights() {
    ResultSet rs = null;
    try {
        String query = "SELECT flight_id, frequency " +
                       "FROM ( " +
                       "    SELECT flight_id, COUNT(flight_id) AS frequency, " +
                       "           RANK() OVER (ORDER BY COUNT(flight_id) DESC) as rnk " +
                       "    FROM itinerary " +
                       "    GROUP BY flight_id " +
                       ") AS RankedFlights " +
                       "WHERE rnk = 1;";

        PreparedStatement pst = this.connection.prepareStatement(query);
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle the exception as required
    }
    return rs;
}



/*
public ResultSet queryPastFlights(String givenUsername, String givendate) {
	ResultSet rs = null;
    try {
        if (this.connection == null) {
            throw new SQLException("Database connection is not established.");
        }

        String query = "SELECT B.id, B.ticket_id, B.from_airport, B.to_airport, " +
                       "T.id AS ticket_id, T.username, T.datepurchased " +
                       "FROM Booking B " +
                       "JOIN Ticket T ON T.id = B.ticket_id " +
                       "WHERE T.username = ? AND T.datepurchased > ?";

        PreparedStatement pst = this.connection.prepareStatement(query);
        pst.setString(1, givenUsername); // Set the username
        pst.setDate(2, java.sql.Date.valueOf(givendate)); // Set the date, assuming givendate is in format "yyyy-MM-dd"
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        System.err.println("SQL Error: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        System.err.println("General Error: " + e.getMessage());
    }
    return rs;
}
*/
    // Existing methods and constructor...

public ResultSet getFlightsByAirport(String airportCode) {
    ResultSet rs; // Declare ResultSet without assigning a value
    try {
        // Prepare SQL query to find departing and arriving flights for the given airport
    	
    	/*String query = "SELECT 'Departing' as flight_direction, flight_number, day_of_week, isDomestic, arriving_airport, managed_by_airline, aircraft_number, arriving_time, departing_airport, departing_time " +
                "FROM Flight " +
                "WHERE departing_airport = ? OR arriving_airport = ?";
                */ 
    	
    	String query = "SELECT id FROM Flight WHERE departing_airport = ? OR arriving_airport = ?";
        
        PreparedStatement pst = this.connection.prepareStatement(query);
        pst.setString(1, airportCode);
        pst.setString(2, airportCode);
        rs = pst.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        rs = null; // Set rs to null in case of an exception
    }
    return rs;
}
}














