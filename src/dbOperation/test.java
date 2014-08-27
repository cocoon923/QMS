package dbOperation;
import java.io.*;
import java.util.*;
import java.sql.*;
import dbOperation.*;
public class test{
    public boolean getall()
    {
    	DBConnection lib = new DBConnection();
        String username ="";
        String sql = "select * from aiga_case  where case_id=10000264";
        ResultSet RS = lib.executeQuery(sql);
        try
        {
            RS.next();
            username = RS.getString("case_id");          
            RS.close();
        }catch(SQLException ex)
        {
		System.err.println("aq.executeQuery:"+ex.getMessage());
	    }
	    if((username != null ) &&  !(username.equals("")))
              return true;
        else
              return false;
    }
}

