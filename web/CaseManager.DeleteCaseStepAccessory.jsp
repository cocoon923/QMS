<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%@ page import="com.jspsmart.upload.*" %>
<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />
<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ɾ���ϴ�ͼƬ</title>
</head>
 <%
     String sCASESEQ=request.getParameter("caseseq");
	 //��ȡ���ڵĲ�����
	 String sPROCESSID=request.getParameter("sCaseProcessID");
	// out.print("caseSeq="+sCASESEQ+";sPROCESSID="+sPROCESSID);
	 //��ȡ���ڵ�ͼƬ
	 String sAccessory="";
	 Vector vProcess =CaseOpera.querycaseProcess(sCASESEQ,sPROCESSID);
	    if(vProcess.size()>0)
	    {
	       HashMap hash = (HashMap) vProcess.get(0);
           sAccessory = (String) hash.get("ACCESSORY");
           if(sAccessory!=null && !sAccessory.equals("")) //���������ڵ������ɾ���ļ�
           {
              String   path=request.getRealPath("AICMS/upload");
              path=path+"/"+sAccessory;
              out.print("path="+path);
              java.io.File temp =new java.io.File(path);
              //File temp = new File(path);   
              if(temp.isFile()) 
              {  
                 temp.delete(); 
              }
           }
        }
        CaseOpera.deleteCaseProcessPic(sCASESEQ,sPROCESSID);
        out.print("<script language='javascript'>alert('ɾ��ͼƬ�ɹ�!');</script>");
       // out.print("<script language='javascript'>alert('ɾ��ͼƬ�ɹ�');<script>");
       // out.print("<script language='javascript'>window.close();<script>");
  %>
  <body>
  <script language="javascript"> 
<!-- 
function clock()
{ 
	if(i==0)
	{ 
		clearTimeout(st); 
		window.opener=null; 
		window.open('','_self',''); 
		window.close();
	} 
	i = i -1; 
	st = setTimeout("clock()",1); 
} 

var i=1 
clock(); 
--> 
</script>

  </body>
</html>
