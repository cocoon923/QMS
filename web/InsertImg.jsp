<%@ page language="java"%> 
<%@ page contentType="text/html;charset=gb2312" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*"%> 
<%@ page import="java.text.*"%> 
<%@ page import="java.io.*"%> 

<% 
Class.forName("oracle.jdbc.driver.OracleDriver"); 
String url="jdbc:oracle:thin:@10.3.18.133:1521:autotest"; 
Connection con=DriverManager.getConnection(url,"autotest","autotest"); 

//�������ݿ� 
String sql="insert into test_img values (?,?,?)"; 
//��ȡ��ֵID 
String id=request.getParameter("id"); 
//��ȡimage��·�� 
String kk=request.getParameter("image"); 
//ת����file��ʽ 
File filename=new File(kk); 

//���ļ��ĳ��ȶ�������ת����Long�� 
long l1=filename.length(); 
int l2=(int)l1; 

//�����ĸ�ʽ��ֵ 
FileInputStream fis=new FileInputStream(filename); 

PreparedStatement ps =con.prepareStatement(sql); 
ps.setString(1,id); 
ps.setString(2,filename.getName()); 
ps.setBinaryStream(3,fis,l2); 
//ps.setBinaryStream(3,fis,fis.available()); 
ps.executeUpdate(); 
//ps.execute(); 
ps.close(); 
fis.close(); 
out.println("ok!!!"); 
%> 


