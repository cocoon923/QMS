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
   //此前转跳的jsp的form类型为：ENCTYPE="multipart/form-data"，故只能通过mySmartUpload的方法获取值
   out.print("提交数据中...请等待..."); 
   SmartUpload mySmartUpload = new SmartUpload();
   mySmartUpload.initialize(pageContext);
   mySmartUpload.upload();
   String sOperType=mySmartUpload.getRequest().getParameter("sOperType");
   String sRMId=mySmartUpload.getRequest().getParameter("requirement");
   String attachmentseq=mySmartUpload.getRequest().getParameter("attachmentseq");
   

   
   String path=request.getRealPath("upload\\solution"); //web服务器是window操作系统
   
   //String path=request.getRealPath("QMS/upload/solution");//web服务器，是linux系统
   if(path==null) path="";
   out.print("<br> 上传路径为："+path);
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
			out.print("<br>类型未知，请检查！");
		}

   }

   String myFileName="";
   String NewFileName="";
   String sTime="";
   String FileNameFlag="";
   //修改上传附件名称：获取系统上传时间
   java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
   java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
   sTime = sdf.format(date);

	if(sOperType.equals("1")==true)//新增 解决方案
	{	 
	 //上传文件
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

	    out.print("<br>附件原文件名="+myFileName);
	    out.print("<br>上传附件新文件名="+NewFileName);
	    //myFile.saveAs("AICMS/upload/solution/"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//qcs
	    myFile.saveAs("upload\\solution\\"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//windows
	  }
	  CaseInfo.updateDemandAttachmentInfo(1,"",srmid,itype,"DEMAND_SOLUTION",NewFileName,"",myFileName);
	  
	  out.print("<br>处理成功！");
			   
	  //out.print("<script language='javascript'>alert('新增成功!');</script>");
	  
	}
	else if(sOperType.equals("2")==true)//删除 解决方案
	{
	   String attachmentname=mySmartUpload.getRequest().getParameter("attachmentname");
	   String newname=mySmartUpload.getRequest().getParameter("newname");
	   out.print("<br>attachmentname="+attachmentname);		   
	   CaseInfo.updateDemandAttachmentInfo(2,attachmentseq,srmid,itype,"DEMAND_SOLUTION",newname,"",attachmentname);
       
	   path=path+"\\"+newname;//web服务器为windows
       
	   //path=path+"/"+newname;//web服务器为linux
       
	   out.print("<br>path="+path);
       java.io.File temp =new java.io.File(path);
       //File temp = new File(path);   
       if(temp.isFile()) 
       {  
         temp.delete(); 
       }
	   //out.print("<script language='javascript'>alert('删除成功!');</script>");
	}
	else if(sOperType.equals("3")==true)//新增 参数附件
	{	 
	 //上传文件
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

	    out.print("<br>附件原文件名="+myFileName);
	    out.print("<br>上传附件新文件名="+NewFileName);
	    //myFile.saveAs("AICMS/upload/solution/"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//qcs
	    myFile.saveAs("upload\\solution\\"+NewFileName,mySmartUpload.SAVE_VIRTUAL);//windows
	  }
	  CaseInfo.updateDemandAttachmentInfo(1,"",srmid,itype,"REMARK3",NewFileName,"",myFileName);
	  
	  out.print("<br>处理成功！");
			   
	  //out.print("<script language='javascript'>alert('新增成功!');</script>");
	  
	}
	else if(sOperType.equals("4")==true)//删除 参数附件
	{
	   String attachmentname=mySmartUpload.getRequest().getParameter("attachmentname");
	   String newname=mySmartUpload.getRequest().getParameter("newname");
	   out.print("<br>attachmentname="+attachmentname);		   
	   CaseInfo.updateDemandAttachmentInfo(2,attachmentseq,srmid,itype,"REMARK3",newname,"",attachmentname);
       path=path+"\\"+newname;//web服务器为windows
       //path=path+"/"+newname;//web服务器为linux
       out.print("<br>path="+path);
       java.io.File temp =new java.io.File(path);
       //File temp = new File(path);   
       if(temp.isFile()) 
       {  
         temp.delete(); 
       }
	   //out.print("<script language='javascript'>alert('删除成功!');</script>");
	}
	else
	{
		out.print("/n 操作类型未知!");
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