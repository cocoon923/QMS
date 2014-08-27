<%
  	} 
  	catch(Exception e) {
		out.println(e.toString());
   		out.println(session.getValue("err_desc"));
	} 
	finally 
	{
		conn.close();
		pc.close(); 
	}
%>