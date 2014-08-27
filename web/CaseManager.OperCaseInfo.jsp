<%@include file="allcheck.jsp"%>
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>

<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>caseinfo操作</title>
</head>
<% 
   String sRMId=request.getParameter("requirement");
   String sCASESEQ=request.getParameter("CaseInfo");
   String sCASEID=request.getParameter("getCASEID");
   String sCASENAME=request.getParameter("CASENAME");
   String sCASEDESC=request.getParameter("CASEDESC"); 
   String sEXPRESULT=request.getParameter("EXPRESULT");
   String sCLIINFOID=request.getParameter("CLIINFOID");
   String sSVRINFOID=request.getParameter("SVRINFOID");
   String sCASEENV=request.getParameter("CASEENV");
   String sCASEDATAPREPARE=request.getParameter("CASEDATAPREPARE");   
   String sSUBSYSID=request.getParameter("SUBSYSID");
   String sMODULEID=request.getParameter("MODULEID");  
   String sOPID=request.getParameter("OPID");
   String sCASETYPE=request.getParameter("CASETYPE");   
   String sCASECONCLUSION=request.getParameter("CASECONCLUSION");
   String sPROGRAMNAME=request.getParameter("PROGRAMNAME");
   String sCaseSeq="";
   //out.print("sCASESEQ="+sCASESEQ +";sCASEID="+sCASEID+";sCASENAME="+sCASENAME+";sCASEDESC="+sCASEDESC+";sEXPRESULT="+sEXPRESULT+";sCLIINFOID="+sCLIINFOID+";sSVRINFOID="+sSVRINFOID+";sCASEENV="+sCASEENV+";sCASEDATAPREPARE="+sCASEDATAPREPARE+";sSUBSYSID="+sSUBSYSID+";sMODULEID="+sMODULEID+";sOPID="+sOPID+";sCASETYPE="+sCASETYPE+";sCASECONCLUSION="+sCASECONCLUSION+";sPROGRAMNAME="+sPROGRAMNAME+";"); 
   System.out.println("sCASESEQ="+sCASESEQ +";sCASEID="+sCASEID+";sCASENAME="+sCASENAME+";sCASEDESC="+sCASEDESC+";sEXPRESULT="+sEXPRESULT+";sCLIINFOID="+sCLIINFOID+";sSVRINFOID="+sSVRINFOID+";sCASEENV="+sCASEENV+";sCASEDATAPREPARE="+sCASEDATAPREPARE+";sSUBSYSID="+sSUBSYSID+";sMODULEID="+sMODULEID+";sOPID="+sOPID+";sCASETYPE="+sCASETYPE+";sCASECONCLUSION="+sCASECONCLUSION+";sPROGRAMNAME="+sPROGRAMNAME+";");

   String stype="";    
   String sSubRMId=sRMId.substring(1);
   int iRMId=sRMId.indexOf("R");
   if(iRMId>=0)
	  stype="1";
   else
      stype="2";
      
   String sPROVERSIONCODE="";
   Vector PROVERSIONCODE=QueryBaseData.getVerInfo (stype,sSubRMId);
   if(PROVERSIONCODE.size()>0)
      {
       	for(int i=PROVERSIONCODE.size()-1;i>=0;i--)
         {
			HashMap PROVERSIONCODEhash = (HashMap) PROVERSIONCODE.get(i);
			sPROVERSIONCODE = (String) PROVERSIONCODEhash.get("PRODUCT_VERSION_ID");
          	}
       }

//  String sCaseSeq=CaseOpera.addcaseinfo(stype,sSubRMId,sCASEID,sCASENAME,sCASEDESC,sCASEDATAPREPARE,sEXPRESULT,sPROVERSIONCODE,sCLIINFOID,sSVRINFOID,sSUBSYSID,sMODULEID,sPROGRAMNAME,sCASETYPE,sOPID,sCASEENV,sCASECONCLUSION);  

   
   if((sCASESEQ!=null) && (!sCASESEQ.equals(""))&&(sCASESEQ!="null"))
   {	
   		sCaseSeq=CaseOpera.updatecaseinfo(sCASESEQ,sCASENAME,sCASEDESC,sCASEDATAPREPARE,sEXPRESULT,sPROVERSIONCODE,sCLIINFOID,sSVRINFOID,sSUBSYSID,sMODULEID,sPROGRAMNAME,sCASETYPE,sOPID,sCASEENV,sCASECONCLUSION);  	   	   	
   }
   else
   {	
 		sCaseSeq=CaseOpera.addcaseinfo(stype,sSubRMId,sCASEID,sCASENAME,sCASEDESC,sCASEDATAPREPARE,sEXPRESULT,sPROVERSIONCODE,sCLIINFOID,sSVRINFOID,sSUBSYSID,sMODULEID,sPROGRAMNAME,sCASETYPE,sOPID,sCASEENV,sCASECONCLUSION);  
   }
response.sendRedirect("CaseManager.NewCase.jsp?requirement="+sRMId+"&updateInfo=1&caseId="+sCaseSeq);

	
	
%>
<body>

</body>
</html>


