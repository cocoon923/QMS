package dbOperation;

import java.sql.*;   

public class DB extends DBC {   
  
 private static Connection con = null ;    
  
 public static void main(String[] args) {       
  
    try {        
  
     con=  dbConn();       
  
    if (con == null ) {   
  
     System.out.print("连接失败");   
  
     System.exit(0);   
  
    }   
    else
    {
      System.out.print("连接成功");
    	
    }
  
      //String url = "delete from t_user where username='wang'";   
  
   // PreparedStatement pres = con.prepareStatement(url);      
  
  // System.out.print(pres.executeUpdate()) ;   
  
   con.close();   
  
    
  
    } catch (Exception e) {   
  
          e.printStackTrace();   
  
        }   
  
    }   
  
}  

