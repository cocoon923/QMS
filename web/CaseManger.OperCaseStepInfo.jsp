
<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*" %>
<%@ page import="com.jspsmart.upload.*" %>

<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />
<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>OperCaseStep</title>
</head>
<% 
   out.print("提交数据中...请等待...");
   String sOperType=request.getParameter("sOperType");
   String sCASESEQ="";
   String sRMId="";
   
   if(sOperType!=null && !sOperType.equals(""))  //表示删除或者复制
   {
       out.print("进入删除或者复制");
       sRMId=request.getParameter("requirement"); 
       sCASESEQ=request.getParameter("CaseSeq");
       if(sOperType.equals("3")==true)//删除
	   {
	   
	     //获取对于的步骤编号
	    String sPROCESSID=request.getParameter("PROCESSID");
	    
	    //以下操作主要删除服务器上的文件
	    //1、根据caseSeq和步骤编号获取附件信息
	    String sAccessory="";
	    Vector vProcess =CaseOpera.querycaseProcess(sCASESEQ,sPROCESSID);
	    if(vProcess.size()>0)
	    {
	       HashMap hash = (HashMap) vProcess.get(0);
           sAccessory = (String) hash.get("ACCESSORY");
           if(sAccessory!=null && !sAccessory.equals("")) //当附件存在的情况才删除文件
           {
              //String   path=request.getRealPath("AICMS/upload");//QCS
              String   path=request.getRealPath("upload");//windows
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
		out.print("sCASESEQ="+sCASESEQ +"sPROCESSID"+sPROCESSID);
		//删除数据库记录
		CaseOpera.deleteCaseProcessInfo(sCASESEQ,sPROCESSID);
		response.sendRedirect("CaseManager.NewCase.jsp?caseId="+sCASESEQ+"&iFlag=1&requirement="+sRMId);
	  }
	  else if(sOperType.equals("4")==true)//复制
	  {
		String sPROCESSID=request.getParameter("PROCESSID");
		out.print("sCASESEQ="+sCASESEQ +"sPROCESSID"+sPROCESSID);
		
		
		//String   path=request.getRealPath("AICMS/upload");//QCS
		 String   path=request.getRealPath("upload");//windows
		 String sLeftStr=path;
		 int iCount=0;
	     String sPath="";
	     while(sLeftStr.indexOf("\\")>=0)
	     {
	       iCount=sLeftStr.indexOf("\\");
	       sPath=sPath+sLeftStr.substring(0,iCount)+"\\"+"\\";
	       sLeftStr=sLeftStr.substring(iCount+1,sLeftStr.length());
	    }
	    sPath=sPath+sLeftStr;
			//out.print("<br>sPath="+sPath);		
		CaseOpera.copyCaseProcessInfo(sCASESEQ,sPROCESSID,sPath);
		response.sendRedirect("CaseManager.NewCase.jsp?caseId="+sCASESEQ+"&iFlag=1&requirement="+sRMId);
	  }
	  else
	  {
		out.print("/n 未提交数据!");
	  }
       
   }
   else
   {
      String myFileName="";
      String sTime="";
      //修改上传附件名称：获取系统上传时间
      java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
      java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
      sTime = sdf.format(date);


   	  SmartUpload mySmartUpload = new SmartUpload();
      mySmartUpload.initialize(pageContext);
//--	  mySmartUpload.initialize(getServlet().getServletConfig(),httpServletRequest,httpServletResponse);
    // 设定上传限制
	// 1.限制每个上传文件的最大长度。
	//mySmartUpload.setMaxFileSize(10000);
	// 2.限制总上传数据的长度。
	// mySmartUpload.setTotalMaxFileSize(5);
	// 3.设定允许上传的文件（通过扩展名限制）,仅允许doc,txt文件。
	///mySmartUpload.setAllowedFilesList("gif,jpg");
	// 4.设定禁止上传的文件（通过扩展名限制）,禁止上传带有exe,bat,
	//jsp,htm,html扩展名的文件和没有扩展名的文件。
	// su.setDeniedFilesList("exe,bat,jsp,htm,html,,");
    //mySmartUpload.setMaxFileSize(500*1024*1024);
       mySmartUpload.upload();

	//此处由CaseManager.CaseStep.jsp跳转，此jsp的form类型为：ENCTYPE="multipart/form-data"，故只能通过mySmartUpload的方法获取值
//      sCASESEQ=mySmartUpload.getRequest().getParameter("CaseSeq");
//      sOperType=mySmartUpload.getRequest().getParameter("sOperType");
//	  sRMId=mySmartUpload.getRequest().getParameter("requirement"); 
//	  String sSOURCEPROCESS=mySmartUpload.getRequest().getParameter("sCaseProcessID"); //修改时需要取原步骤id
      sCASESEQ=new String(mySmartUpload.getRequest().getParameter("CaseSeq").getBytes(),"GBK");	  
      sOperType=new String(mySmartUpload.getRequest().getParameter("sOperType").getBytes(),"GBK");	 
      sRMId=new String(mySmartUpload.getRequest().getParameter("requirement").getBytes(),"GBK");	 
      String sSOURCEPROCESS=new String(mySmartUpload.getRequest().getParameter("sCaseProcessID").getBytes(),"GBK");	 
                     
		if(sOperType.equals("1")==true)//新增
		{
		   out.print("\n结果\n");
		   String sPROCESSDESC=new String(mySmartUpload.getRequest().getParameter("PROCESSDESC").getBytes(),"GBK");	 
//		   String sPROCESSDESC=mySmartUpload.getRequest().getParameter("PROCESSDESC");
		   out.print("\nsPROCESSDESC="+sPROCESSDESC+"\n");
		   
		   String sEXPRESULT=new String(mySmartUpload.getRequest().getParameter("EXPRESULT").getBytes(),"GBK");	 
//		   String sEXPRESULT=mySmartUpload.getRequest().getParameter("EXPRESULT"); 
		   out.print("\nsEXPRESULT="+sEXPRESULT+"\n");
		   
		   String sCASEDATACHECK=new String(mySmartUpload.getRequest().getParameter("CASEDATACHECK").getBytes(),"GBK");	 
//		   String sCASEDATACHECK=mySmartUpload.getRequest().getParameter("CASEDATACHECK");
		   out.print("\nsCASEDATACHECK="+sCASEDATACHECK+"\n");
		    
		   String sCASELOG=new String(mySmartUpload.getRequest().getParameter("CASELOG").getBytes(),"GBK");	 
//		   String sCASELOG=mySmartUpload.getRequest().getParameter("CASELOG");
		   out.print("\nsCASELOG="+sCASELOG+"\n");
		  
		   String sREALRESULT=new String(mySmartUpload.getRequest().getParameter("REALRESULT").getBytes(),"GBK");	 
//		   String sREALRESULT=mySmartUpload.getRequest().getParameter("REALRESULT"); 
		   out.print("\nsREALRESULT="+sREALRESULT+"\n");
		  
		  
		   String sINDUMP=new String(mySmartUpload.getRequest().getParameter("INDUMP").getBytes(),"GBK");	 
//		   String sINDUMP=mySmartUpload.getRequest().getParameter("INDUMP"); 
		   out.print("\nsINDUMP="+sINDUMP+"\n");
		 
		   String sOUTDUMP=new String(mySmartUpload.getRequest().getParameter("OUTDUMP").getBytes(),"GBK");	 
//		   String sOUTDUMP=mySmartUpload.getRequest().getParameter("OUTDUMP");  
		   out.print("\nsOUTDUMP="+sOUTDUMP+"\n");

		   String sPROCESSID=new String(mySmartUpload.getRequest().getParameter("PROCESSID").getBytes(),"GBK");	 
//		   String sPROCESSID=mySmartUpload.getRequest().getParameter("PROCESSID");  
		   out.print("\nsPROCESSID="+sPROCESSID+"\n");

		 
		 //上传文件
		  com.jspsmart.upload.File myFile=mySmartUpload.getFiles().getFile(0);
	
		  if (!myFile.isMissing())
		  {
		    //myFileName=myFile.getFileName();
		    myFileName=sCASESEQ+"-"+sPROCESSID+"-"+sTime+".jpg";
		    out.print("文件名="+myFileName);
		    //qcs适用路径：
		    //myFile.saveAs("AICMS/upload/"+myFileName,mySmartUpload.SAVE_VIRTUAL);
		    myFile.saveAs("upload\\"+myFileName,mySmartUpload.SAVE_VIRTUAL);//windows
		  }
		   String sACCESSORY=myFileName;
		   CaseOpera.addCaseProcessInfo(sCASESEQ,sPROCESSID,sPROCESSDESC,sEXPRESULT,sCASEDATACHECK,sCASELOG,sREALRESULT,sINDUMP,sOUTDUMP,sACCESSORY);
		   //out.print("<script language='javascript'>alert('新增成功!');</script>");
		   session.setAttribute("addStepFlag","sucess");
		}
		else if(sOperType.equals("2")==true)//修改
		{
		   out.print("2");
		 	   out.print("\n结果\n");

		   String sPROCESSDESC=new String(mySmartUpload.getRequest().getParameter("PROCESSDESC").getBytes(),"GBK");	 
//		   String sPROCESSDESC=mySmartUpload.getRequest().getParameter("PROCESSDESC"); 
		   
		   String sEXPRESULT=new String(mySmartUpload.getRequest().getParameter("EXPRESULT").getBytes(),"GBK");	 
//		   String sEXPRESULT=mySmartUpload.getRequest().getParameter("EXPRESULT");  
		   
		   String sCASEDATACHECK=new String(mySmartUpload.getRequest().getParameter("CASEDATACHECK").getBytes(),"GBK");	 
//		   String sCASEDATACHECK=mySmartUpload.getRequest().getParameter("CASEDATACHECK");   
		    
		   String sCASELOG=new String(mySmartUpload.getRequest().getParameter("CASELOG").getBytes(),"GBK");	 
//		   String sCASELOG=mySmartUpload.getRequest().getParameter("CASELOG"); 
		  
		   String sREALRESULT=new String(mySmartUpload.getRequest().getParameter("REALRESULT").getBytes(),"GBK");	 
//		   String sREALRESULT=mySmartUpload.getRequest().getParameter("REALRESULT"); 
		  
		   String sINDUMP=new String(mySmartUpload.getRequest().getParameter("INDUMP").getBytes(),"GBK");	 
//		   String sINDUMP=mySmartUpload.getRequest().getParameter("INDUMP");
		 
		   String sOUTDUMP=new String(mySmartUpload.getRequest().getParameter("OUTDUMP").getBytes(),"GBK");	 
//		   String sOUTDUMP=mySmartUpload.getRequest().getParameter("OUTDUMP");  

		   String sPROCESSID=new String(mySmartUpload.getRequest().getParameter("PROCESSID").getBytes(),"GBK");	 
//		   String sPROCESSID=mySmartUpload.getRequest().getParameter("PROCESSID");
		   		   
		   com.jspsmart.upload.File myFile=mySmartUpload.getFiles().getFile(0);
		   if (!myFile.isMissing())
		   {
		      myFileName=sCASESEQ+"-"+sPROCESSID+"-"+sTime+".jpg";
		     // myFileName=myFile.getFileName();
		      out.print("文件名="+myFileName);
		      //qcs适用路径：
		      //myFile.saveAs("AICMS/upload/"+myFileName,mySmartUpload.SAVE_VIRTUAL);
		      myFile.saveAs("upload\\"+myFileName,mySmartUpload.SAVE_VIRTUAL); //windows
		   }
		   String sACCESSORY=myFileName;
	       CaseOpera.updateCaseProcessInfo(sCASESEQ,sSOURCEPROCESS,sPROCESSID,sPROCESSDESC,sEXPRESULT,sCASEDATACHECK,sCASELOG,sREALRESULT,sINDUMP,sOUTDUMP,sACCESSORY);
		   //out.print("<script language='javascript'>alert('修改成功!');</script>");
	       session.setAttribute("updateStepFlag","sucess");
		}
		else
		{
			out.print("/n 未提交数据!");
		}
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