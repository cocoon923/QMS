package dbOperation;
import java.io.*;
import java.util.*;
import java.util.logging.Logger;
import java.sql.*;
import dbOperation.*;
public class checkLogin {

    public boolean checkUserLogin(String name,String password)
    {
    	DBConnection lib = new DBConnection();
        String username ="";
        System.out.print("用户名："+name);
        System.out.print("密码:"+password);
        String sql="select op_login from op_login  where op_passwd='"+password+"' and op_login='"+name+"'";
        ResultSet RS = lib.executeQuery(sql);
        try
        {
            RS.next();
            username = RS.getString("op_login");         
            RS.close();
        }catch(SQLException ex)
        {
		  System.err.println("aq.executeQuery:"+ex.getMessage());
	    }
        //System.out.print("ok");
	    if((username != null ) &&  !(username.equals("")))
              return true;
        else
              return false;
	    
    }
    
    public String getOpName(String name,String password)
    {
    	DBConnection lib = new DBConnection();
        String username ="";
        System.out.print("用户名："+name);
        System.out.print("密码:"+password);
        String sql="select * from op_login  where op_passwd='"+password+"' and op_login='"+name+"'";
        ResultSet RS = lib.executeQuery(sql);
        try
        {
            RS.next();
            username = RS.getString("op_name");         
            RS.close();
        }catch(SQLException ex)
        {
		  System.err.println("aq.executeQuery:"+ex.getMessage());
	    }
        return username;
    }
    public String getOpId(String name,String password)
    {
    	DBConnection lib = new DBConnection();
        String opId ="";
        System.out.print("用户名："+name);
        System.out.print("密码:"+password);
        String sql="select * from op_login  where op_passwd='"+password+"' and op_login='"+name+"'";
        ResultSet RS = lib.executeQuery(sql);
        try
        {
            RS.next();
            opId = RS.getString("OP_ID");         
            RS.close();
        }catch(SQLException ex)
        {
		  System.err.println("aq.executeQuery:"+ex.getMessage());
	    }
        return opId;
    }
    
    
}