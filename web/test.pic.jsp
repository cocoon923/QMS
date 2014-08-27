<%//@ page contentType="text/html;charset=gb2312" language="java" import="java.sql.*" errorPage="" %> 
<%@ page contentType="application/msword; charset=gb2312" language="java" import="java.sql.*" errorPage="" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns="http://www.w3.org/TR/REC-html40"> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /> 


<title>无标题文档</title> 
</head> 

<body> 
<h2>显示图片：</h2> 
<%@ page import="java.io.*"%>  
<% 

    try 
    { 
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@10.3.18.133:1521:autotest";    
        Connection con=DriverManager.getConnection(url,"autotest","autotest");  
        String image_id = (String) request.getParameter("id");
        out.print(image_id);
        con.setAutoCommit (false); 
        Statement   stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);  
        ResultSet rs=stmt.executeQuery("select * from autotest.test_img WHERE id = " + image_id);// 
         
        if(rs.next()) 
        { 
            int len = 10 * 1024 * 1024; 
            InputStream in = (InputStream)rs.getBinaryStream("PIC");//①  
            response.reset(); //返回在流中被标记过的位置  
            response.setContentType("image/jpg"); //或gif等 //得到输入流  
            OutputStream toClient = response.getOutputStream();//②  
            String str="test-pic.html";
        	response.setHeader("Content-disposition","attachment;filename="+new String(str.getBytes("gb2312"),"iso8859-1")); 
        	 
            byte[] P_Buf = new byte[len];  
            int i=-1;  
            while ((i = in.read(P_Buf)) != -1) 
            { 
             toClient.write(P_Buf, 0, i); 

             
            }  
            in.close();  
            toClient.flush(); //强制清出缓冲区  
            toClient.close();//  
            con.commit(); 
        } 
         
        rs.close();  
        stmt.close(); 
        con.close();     
    } 
    catch(Exception   ex) 
    {      
        ex.printStackTrace();  
    } 
%> 

</body> 
</html> 