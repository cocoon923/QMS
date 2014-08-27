package dbOperation;

import java.sql.Connection;   

import java.sql.DriverManager;   
  
import java.sql.SQLException;   
  
public class DBC {   
  
public static Connection dbConn()  {   
  
   Connection c = null ;   
  
      try {   
  
  Class.forName("oracle.jdbc.driver.OracleDriver");   
  
 } catch (ClassNotFoundException e) {   
  
   e.printStackTrace();   
  
 }   
  
   try {   
  
//c =DriverManager.getConnection("jdbc:oracle:thin:@10.3.18.133:1521:autotest","autotest","autotest");   
c =DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:yanwg","AICMS","AICMS");   
 

 } catch (SQLException e1) {   
  
    e1.printStackTrace();   
  
 }   
  return c;   
 }   
  
} 
