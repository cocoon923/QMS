
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
   out.print("�ύ������...��ȴ�...");
   String sOperType=request.getParameter("sOperType");
   String sCASESEQ="";
   String sRMId="";
   
   if(sOperType!=null && !sOperType.equals(""))  //��ʾɾ�����߸���
   {
       out.print("����ɾ�����߸���");
       sRMId=request.getParameter("requirement"); 
       sCASESEQ=request.getParameter("CaseSeq");
       if(sOperType.equals("3")==true)//ɾ��
	   {
	   
	     //��ȡ���ڵĲ�����
	    String sPROCESSID=request.getParameter("PROCESSID");
	    
	    //���²�����Ҫɾ���������ϵ��ļ�
	    //1������caseSeq�Ͳ����Ż�ȡ������Ϣ
	    String sAccessory="";
	    Vector vProcess =CaseOpera.querycaseProcess(sCASESEQ,sPROCESSID);
	    if(vProcess.size()>0)
	    {
	       HashMap hash = (HashMap) vProcess.get(0);
           sAccessory = (String) hash.get("ACCESSORY");
           if(sAccessory!=null && !sAccessory.equals("")) //���������ڵ������ɾ���ļ�
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
		//ɾ�����ݿ��¼
		CaseOpera.deleteCaseProcessInfo(sCASESEQ,sPROCESSID);
		response.sendRedirect("CaseManager.NewCase.jsp?caseId="+sCASESEQ+"&iFlag=1&requirement="+sRMId);
	  }
	  else if(sOperType.equals("4")==true)//����
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
		out.print("/n δ�ύ����!");
	  }
       
   }
   else
   {
      String myFileName="";
      String sTime="";
      //�޸��ϴ��������ƣ���ȡϵͳ�ϴ�ʱ��
      java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
      java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
      sTime = sdf.format(date);


   	  SmartUpload mySmartUpload = new SmartUpload();
      mySmartUpload.initialize(pageContext);
//--	  mySmartUpload.initialize(getServlet().getServletConfig(),httpServletRequest,httpServletResponse);
    // �趨�ϴ�����
	// 1.����ÿ���ϴ��ļ�����󳤶ȡ�
	//mySmartUpload.setMaxFileSize(10000);
	// 2.�������ϴ����ݵĳ��ȡ�
	// mySmartUpload.setTotalMaxFileSize(5);
	// 3.�趨�����ϴ����ļ���ͨ����չ�����ƣ�,������doc,txt�ļ���
	///mySmartUpload.setAllowedFilesList("gif,jpg");
	// 4.�趨��ֹ�ϴ����ļ���ͨ����չ�����ƣ�,��ֹ�ϴ�����exe,bat,
	//jsp,htm,html��չ�����ļ���û����չ�����ļ���
	// su.setDeniedFilesList("exe,bat,jsp,htm,html,,");
    //mySmartUpload.setMaxFileSize(500*1024*1024);
       mySmartUpload.upload();

	//�˴���CaseManager.CaseStep.jsp��ת����jsp��form����Ϊ��ENCTYPE="multipart/form-data"����ֻ��ͨ��mySmartUpload�ķ�����ȡֵ
//      sCASESEQ=mySmartUpload.getRequest().getParameter("CaseSeq");
//      sOperType=mySmartUpload.getRequest().getParameter("sOperType");
//	  sRMId=mySmartUpload.getRequest().getParameter("requirement"); 
//	  String sSOURCEPROCESS=mySmartUpload.getRequest().getParameter("sCaseProcessID"); //�޸�ʱ��Ҫȡԭ����id
      sCASESEQ=new String(mySmartUpload.getRequest().getParameter("CaseSeq").getBytes(),"GBK");	  
      sOperType=new String(mySmartUpload.getRequest().getParameter("sOperType").getBytes(),"GBK");	 
      sRMId=new String(mySmartUpload.getRequest().getParameter("requirement").getBytes(),"GBK");	 
      String sSOURCEPROCESS=new String(mySmartUpload.getRequest().getParameter("sCaseProcessID").getBytes(),"GBK");	 
                     
		if(sOperType.equals("1")==true)//����
		{
		   out.print("\n���\n");
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

		 
		 //�ϴ��ļ�
		  com.jspsmart.upload.File myFile=mySmartUpload.getFiles().getFile(0);
	
		  if (!myFile.isMissing())
		  {
		    //myFileName=myFile.getFileName();
		    myFileName=sCASESEQ+"-"+sPROCESSID+"-"+sTime+".jpg";
		    out.print("�ļ���="+myFileName);
		    //qcs����·����
		    //myFile.saveAs("AICMS/upload/"+myFileName,mySmartUpload.SAVE_VIRTUAL);
		    myFile.saveAs("upload\\"+myFileName,mySmartUpload.SAVE_VIRTUAL);//windows
		  }
		   String sACCESSORY=myFileName;
		   CaseOpera.addCaseProcessInfo(sCASESEQ,sPROCESSID,sPROCESSDESC,sEXPRESULT,sCASEDATACHECK,sCASELOG,sREALRESULT,sINDUMP,sOUTDUMP,sACCESSORY);
		   //out.print("<script language='javascript'>alert('�����ɹ�!');</script>");
		   session.setAttribute("addStepFlag","sucess");
		}
		else if(sOperType.equals("2")==true)//�޸�
		{
		   out.print("2");
		 	   out.print("\n���\n");

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
		      out.print("�ļ���="+myFileName);
		      //qcs����·����
		      //myFile.saveAs("AICMS/upload/"+myFileName,mySmartUpload.SAVE_VIRTUAL);
		      myFile.saveAs("upload\\"+myFileName,mySmartUpload.SAVE_VIRTUAL); //windows
		   }
		   String sACCESSORY=myFileName;
	       CaseOpera.updateCaseProcessInfo(sCASESEQ,sSOURCEPROCESS,sPROCESSID,sPROCESSDESC,sEXPRESULT,sCASEDATACHECK,sCASELOG,sREALRESULT,sINDUMP,sOUTDUMP,sACCESSORY);
		   //out.print("<script language='javascript'>alert('�޸ĳɹ�!');</script>");
	       session.setAttribute("updateStepFlag","sucess");
		}
		else
		{
			out.print("/n δ�ύ����!");
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