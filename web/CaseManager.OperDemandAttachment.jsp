<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%@ page import="com.jspsmart.upload.*" %>

<jsp:useBean id="CaseInfo" scope="page" class="dbOperation.CaseInfo" />
<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>OperDemandAttachment</title>
</head>
<% 
   //��ǰת����jsp��form����Ϊ��ENCTYPE="multipart/form-data"����ֻ��ͨ��mySmartUpload�ķ�����ȡֵ
   out.print("�ύ������...��ȴ�..."); 
   SmartUpload mySmartUpload = new SmartUpload();
   mySmartUpload.initialize(pageContext);
   mySmartUpload.upload();
   String sOperType=mySmartUpload.getRequest().getParameter("sOperType");
   String sRMId=mySmartUpload.getRequest().getParameter("requirement");
   String attachmentseq=mySmartUpload.getRequest().getParameter("attachmentseq");
   

   
   String path=request.getRealPath("upload\\solution"); //web��������window����ϵͳ
   
   //String path=request.getRealPath("QMS/upload/solution");//web����������linuxϵͳ
   if(path==null) path="";
   out.print("<br> �ϴ�·��Ϊ��"+path);
   int itype=0;
   String srmid="";
   
   if(sOperType==null) sOperType="";
   if (sRMId==null) sRMId="";
   if(attachmentseq==null) attachmentseq="";

   out.print("<br>sOperType="+sOperType+"<br>sRMId="+sRMId+"<br>attachmentseq="+attachmentseq);

   if(!sRMId.equals(""))
   {
		String  sType=sRMId.toUpperCase().substring(0,1);
		if(sType.equals("R"))
		{
			itype=1;
			srmid=sRMId.substring(1,sRMId.length());
		}
		else if (sType.equals("F"))
		{
			itype=2;
			srmid=sRMId.substring(1,sRMId.length());
		}
		else
		{
			out.print("<br>����δ֪�����飡");
		}

   }

   String myFileName="";
   String NewFileName="";
   String sTime="";
   String FileNameFlag="";
   //�޸��ϴ��������ƣ���ȡϵͳ�ϴ�ʱ��
   java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
   java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
   sTime = sdf.format(date);

	if(sOperType.equals("1")==true)//���� �������
	{	 
	 //�ϴ��ļ�
	  com.jspsmart.upload.File myFile=mySmartUpload.getFiles().getFile(0);
	  if (!myFile.isMissing())
	  {
	    myFileName=myFile.getFileName();
	    FileNameFlag=myFileName.substring(myFileName.length()-4,myFileName.length());
	    if(FileNameFlag.toLowerCase().equals(".doc"))
	    {
	    	NewFileName="Solution-["+sRMId+"]-"+sTime+".doc";
	    }
	    else if(FileNameFlag.toLowerCase().equals(".txt"))
	    {
	    	NewFileName="Solution-["+sRMId+"]-"+sTime+".txt";
	    }
	    else if(FileNameFlag.toLowerCase().equals("docx"))
	    {
	    	NewFileName="Solution-["+sRMId+"]-"+sTime+".docx";
	    }

	    out.print("<br>����ԭ�ļ���="+myFileName);
	    out.print("<br>�ϴ��������ļ���="+NewFileName);
	    //myFile.saveAs("AICMS/upload/solution/"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//qcs
	    myFile.saveAs("upload\\solution\\"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//windows
	  }
	  CaseInfo.updateDemandAttachmentInfo(1,"",srmid,itype,"DEMAND_SOLUTION",NewFileName,"",myFileName);
	  
	  out.print("<br>����ɹ���");
			   
	  //out.print("<script language='javascript'>alert('�����ɹ�!');</script>");
	  
	}
	else if(sOperType.equals("2")==true)//ɾ�� �������
	{
	   String attachmentname=mySmartUpload.getRequest().getParameter("attachmentname");
	   String newname=mySmartUpload.getRequest().getParameter("newname");
	   out.print("<br>attachmentname="+attachmentname);		   
	   CaseInfo.updateDemandAttachmentInfo(2,attachmentseq,srmid,itype,"DEMAND_SOLUTION",newname,"",attachmentname);
       
	   path=path+"\\"+newname;//web������Ϊwindows
       
	   //path=path+"/"+newname;//web������Ϊlinux
       
	   out.print("<br>path="+path);
       java.io.File temp =new java.io.File(path);
       //File temp = new File(path);   
       if(temp.isFile()) 
       {  
         temp.delete(); 
       }
	   //out.print("<script language='javascript'>alert('ɾ���ɹ�!');</script>");
	}
	else if(sOperType.equals("3")==true)//���� ��������
	{	 
	 //�ϴ��ļ�
	  com.jspsmart.upload.File myFile=mySmartUpload.getFiles().getFile(0);
	  if (!myFile.isMissing())
	  {
	    myFileName=myFile.getFileName();
	    FileNameFlag=myFileName.substring(myFileName.length()-4,myFileName.length());
	    if(FileNameFlag.toLowerCase().equals(".doc"))
	    {
	    	NewFileName="Remark3-["+sRMId+"]-"+sTime+".doc";
	    }
	    else if(FileNameFlag.toLowerCase().equals(".txt"))
	    {
	    	NewFileName="Remark3-["+sRMId+"]-"+sTime+".txt";
	    }
	    else if(FileNameFlag.toLowerCase().equals("docx"))
	    {
	    	NewFileName="Remark3-["+sRMId+"]-"+sTime+".docx";
	    }

	    out.print("<br>����ԭ�ļ���="+myFileName);
	    out.print("<br>�ϴ��������ļ���="+NewFileName);
	    //myFile.saveAs("AICMS/upload/solution/"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//qcs
	    myFile.saveAs("upload\\solution\\"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//windows
	  }
	  CaseInfo.updateDemandAttachmentInfo(1,"",srmid,itype,"REMARK3",NewFileName,"",myFileName);
	  
	  out.print("<br>����ɹ���");
			   
	  //out.print("<script language='javascript'>alert('�����ɹ�!');</script>");
	  
	}
	else if(sOperType.equals("4")==true)//ɾ�� ��������
	{
	   String attachmentname=mySmartUpload.getRequest().getParameter("attachmentname");
	   String newname=mySmartUpload.getRequest().getParameter("newname");
	   out.print("<br>attachmentname="+attachmentname);		   
	   CaseInfo.updateDemandAttachmentInfo(2,attachmentseq,srmid,itype,"REMARK3",newname,"",attachmentname);
       path=path+"\\"+newname;//web������Ϊwindows
       //path=path+"/"+newname;//web������Ϊlinux
       out.print("<br>path="+path);
       java.io.File temp =new java.io.File(path);
       //File temp = new File(path);   
       if(temp.isFile()) 
       {  
         temp.delete(); 
       }
	   //out.print("<script language='javascript'>alert('ɾ���ɹ�!');</script>");
	}
	else
	{
		out.print("/n ��������δ֪!");
	}


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
	st = setTimeout("clock()",0.1); 
} 

var i=1 
clock(); 
//--> 
</script>
</body>
</html>