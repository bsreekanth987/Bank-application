
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%  
	int accountnum=Integer.parseInt(request.getParameter("accno"));
    String name=request.getParameter("name");
    String password=request.getParameter("pwd");
    try
	{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sree","sree");
			PreparedStatement ps=con.prepareStatement("select *from sdfc where accountnum=? and name=? and password=?");
			ps.setInt(1, accountnum);
			ps.setString(2,name);
			ps.setString(3,password);
			ResultSet rs=ps.executeQuery();
			double dammt=0.0;
			if (rs.next()){ 
			
					out.print(rs.getString(7));
		 		dammt=rs.getInt(4);
		 		out.print(dammt);
			double amount=Double.parseDouble(request.getParameter("amt"));
		PreparedStatement us=con.prepareStatement("update sdfc set amount=? where accountnum=? and name=? and password=?and status='valid'");
		   amount=dammt+amount;
			us.setDouble(1, amount);
			us.setInt(2, accountnum);
			us.setString(3,name);
			us.setString(4,password);
    		int i=us.executeUpdate();
   
    		out.println("<h1>"+"Account Info"+"</h1>");
    		out.println("Account Number :"+accountnum+"<br>");
    		out.println("Deposit amount : "+(amount-dammt)+"<br>");
    		out.println("Current Balance :"+amount+"<br>");
    		out.println("Before Deposit  Balance :"+dammt+"<br>");
			}
			else {
				out.print("ENTER VALID DETAILS");
			}
	
  	  		con.close();}
  	catch(Exception ex)
    {
       System.out.println(ex);
    }
    %>