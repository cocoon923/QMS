<%@include file="../allcheck.jsp"%>
<jsp:useBean id="importRequirment" scope="page" class="dbOperation.ImportRequriment" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%
  request.setCharacterEncoding("gb2312");
%>
<% 
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<%@ page contentType="text/html; charset=gb2312"%>


<script language="javascript">

function empty()    
	{
		document.open.submit();	
	}
	
function ToSubmit(form1)
{
   form1.submit();
}

function Update_GoToUrl(url)
{
   window.location=url;
}

function openNewWindow(sid)
{
       var sId=sid.substr(1,sid.length);
       if((sid.substr(0,1))=="R") //����
       {
          //window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sId);
       }
       else     //����F
       {
          //window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sId);
       }
}


</script>
<%
    //��ȡ��½��
    //String opId=(String)session.getValue("OpId");
    String opId=""; //���谴¼���û�����ѯ
	String sdate_s ="";
	String sDate="";
    String sSelectDate=request.getParameter("cdate");
    if(sSelectDate==null)
       sSelectDate="";
   // out.print("�Ƿ�ѡ¼��ʱ��="+sSelectDate+"<br>");
    String sSelectStartDate=request.getParameter("startTime");
    String sSelectEndDate=request.getParameter("endTime");
    if(sSelectStartDate==null)
      sSelectStartDate="";
    if(sSelectEndDate==null)
      sSelectEndDate="";
    //out.print("��ʼʱ��="+sSelectStartDate+";����ʱ��="+sSelectEndDate+"<br>");
    String[] sSelectProduct =(String[])request.getParameterValues("productName");
  //  if (sSelectProduct!=null)
  //  {
  //    for(int k=0;k<sSelectProduct.length;k++)
  //     out.print("��Ʒ����="+sSelectProduct[k]+"<br>"); 
  //  } 
    String[] sSelectRequirement=request.getParameterValues("productState");
  //  if (sSelectRequirement!=null)
  //  {
  //    for(int k=0;k<sSelectRequirement.length;k++)
   //     out.print("����״̬="+sSelectRequirement[k]+"<br>");
  //  }
    String[] sSelectmalfuctionState=request.getParameterValues("malfuctionState");
  //  if (sSelectmalfuctionState!=null)
  //  {
  //    for(int k=0;k<sSelectmalfuctionState.length;k++)
  //      out.print("����״̬="+sSelectmalfuctionState[k]+"<br>");
  //  }
    String rId=request.getParameter("rId");
    String gId=request.getParameter("gId");
    if(rId==null)
       rId="";
    if(gId==null)
       gId=""; 
    String sNewRid=rId.replaceAll(";",",");
    sNewRid=sNewRid.replaceAll("R","");
    sNewRid=sNewRid.replaceAll("r","");
    String sNewGid=gId.replaceAll(";",",");
    sNewGid=sNewGid.replaceAll("F","");
    sNewGid=sNewGid.replaceAll("f","");
  //  out.print("������="+rId+"<br>");
  //  out.print("���ϱ��="+gId+"<br>");
    
    String QueryStartTime="";
    String QueryEndTime="";
    String QueryProduct="";
    if(sSelectDate.equals("1"))  //����ѡʱ��Ž�����ʱ������ѯ����
    {
       QueryStartTime=sSelectStartDate;
       QueryEndTime=sSelectEndDate;
    }
    if(sSelectProduct!=null)    //����ѡ��Ʒ���ƲŽ�����ʱ������ѯ����
    {
      for(int k=0;k<sSelectProduct.length;k++)
      {
         if(k==0)
         {
            QueryProduct=sSelectProduct[k];
         }
         else
         {
            QueryProduct=QueryProduct+","+sSelectProduct[k];
         }
      }
    }
    String QueryReq="";
    if (sSelectRequirement!=null)  //����ѡ����״̬�Ž�����ʱ������ѯ����
    {
      for(int k=0;k<sSelectRequirement.length;k++)
      {
         if(k==0)
         {
           QueryReq=sSelectRequirement[k];
         }
         else
         {
           QueryReq=QueryReq+","+sSelectRequirement[k];
         }
      }
    }
    String QueryGu="";
    if (sSelectmalfuctionState!=null)   //����
    {
      for(int k=0;k<sSelectmalfuctionState.length;k++)
      {
         if(k==0)
         {
            QueryGu=sSelectmalfuctionState[k];
         }
         else
         {
            QueryGu=QueryGu+","+sSelectmalfuctionState[k];
         }
       }
     }
     String sQueryDate=request.getParameter("sCheckDate");
     if(sQueryDate==null)
       sQueryDate="";
     int iCheckAllCount=0;
     
     String sdemandflag="";
     sdemandflag=request.getParameter("demandflag");
 %>
<title>plantask</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<script language="JavaScript" type="text/JavaScript">
function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}

function loadPage(url) 
{
	window.location = url;
}

function empty()    
{
	document.open.submit();	
}



</script>
</head>

<form method="post" action="QueryImportRequirement.jsp"> 
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>�ص�������ϲ�ѯ:<br></td>
          <td width="24" height="5"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
                <%
                   
                   	Vector vDataBaseDate=importRequirment.getDataBaseDate();
	                if(vDataBaseDate.size()>0)
	                {
	                   HashMap dataBaseMap=(HashMap) vDataBaseDate.get(0);
	                   sdate_s=(String) dataBaseMap.get("SDATE_S");
	                   sDate=(String) dataBaseMap.get("SDATE");
	                }
	                if(!sSelectStartDate.equals(""))
	                   sdate_s=sSelectStartDate;
	                if(!sSelectEndDate.equals(""))
	                   sDate=sSelectEndDate;
                %>
                <tr >
                  <td width="15%" class="pagetitle1" style= "height: 40px; "><div align="left">¼��ʱ�䣺 </div>
                    <div align="right"> </div></td>
                  <td width="85%" class="pagetextdetails">
                  <% 
                    if(sQueryDate.equals("1"))
                    {
                      if(sSelectDate.equals("1"))
                      {
                  %>
                <input name="cdate" type="checkbox" id="chk_date" value="1" checked>
                 <% 
                       }
                       else
                       {
                 %>
                  <input name="cdate" type="checkbox" id="chk_date" value="1">
                 <%
                       }
                    }
                    else
                    {
                  %>
                   <input name="cdate" type="checkbox" id="chk_date" value="1">
                 <%
                    }
                 %>
                    <input name="startTime" type="text" class="inputstyle" id="startTime"  onClick="JSCalendar(this);"  value="<%=sdate_s%>" size="10">
                    ---
                    <input name="endTime" type="text" class="inputstyle" id="endTime" value="<%=sDate%>" size="10"  onClick="JSCalendar(this);" ></td>
                </tr>
                <input type="hidden" name="sCheckDate" value="1">
                <tr class="contentbg">
                  <td class="pagetitle1" style= "height: 40px; " >��Ʒ���ƣ�</td>
                  <td><font class="pagetextdetails">
                     <%
                         Vector vProductInfo=importRequirment.getAllProductInfo("1");
                         if(vProductInfo.size()>0)
                         {
                            for(int i=vProductInfo.size()-1;i>=0;i--)
                            {
                                HashMap productInfoMap = (HashMap) vProductInfo.get(i);
                                String PRODUCT_ID =(String) productInfoMap.get("PRODUCT_ID");
                                String PRODUCT_NAME=(String) productInfoMap.get("PRODUCT_NAME");
                                int k=0;
                             if(sSelectProduct!=null)
                             {
                                for(int z=0;z<sSelectProduct.length;z++)
                                {
                                   if(PRODUCT_ID.equals(sSelectProduct[z]))
                                   {
                                       k=1;
                                       break;
                                   }
                                 }
                             }
                              if(k==0)
                              {
                      %>
                      <input type="checkbox" value="<%=PRODUCT_ID%>" name="productName"><font class="pagetextdetails"><%=PRODUCT_NAME%>&nbsp;&nbsp;      
                    <%        }
                              else
                              {
                     %>
                     <input type="checkbox" value="<%=PRODUCT_ID%>" name="productName" checked><font class="pagetextdetails"><%=PRODUCT_NAME%>&nbsp;&nbsp;      
                     
                     <%       
                              }
                            }
                         }
                     %>
                    </font></td>
                </tr>
                
                <tr>
                  <td class="pagetitle1" style= "height: 40px; ">����״̬��</td>
                  <td><font class="pagetextdetails">
                      <%
                         Vector vRequirement=importRequirment.getAllRequirement("1,2,3,4,5");
                         if(vRequirement.size()>0)
                         {
                           for(int i=vRequirement.size()-1;i>=0;i--)
                           {
                                HashMap RequirementMap = (HashMap) vRequirement.get(i);
                                String PRODUCT_ID =(String) RequirementMap.get("ID");
                                String NAME=(String) RequirementMap.get("NAME");
                                int ik=0;
                                if (sSelectRequirement!=null)
                                {
                                   for(int z=0;z<sSelectRequirement.length;z++)
                                   {
                                      if(PRODUCT_ID.equals(sSelectRequirement[z]))
                                      {
                                         ik=1;
                                         break;
                                      }
                                   }
                                }
                                if(ik==0)
                                {
                       %>
                      <input type="checkbox" value="<%=PRODUCT_ID%>" name="productState"><font class="pagetextdetails"><%=NAME%>&nbsp;&nbsp;             
                      <%
                                }
                                else
                                {
                       %>
                      <input type="checkbox" value="<%=PRODUCT_ID%>" name="productState" checked><font class="pagetextdetails"><%=NAME%>&nbsp;&nbsp;              
                      <%
                                } 
                           }
                         }
                      %>
                     
                    </font></td>
                </tr>
             
                <tr class="contentbg">
                  <td class="pagetitle1" style= "height: 40px; ">����״̬��</td>
                  <td><font class="pagetextdetails">
                      <%
                         Vector vMalfunction=importRequirment.getAllMalfunction("1,2,3,4,5,6");
                         if(vMalfunction.size()>0)
                         {
                           for(int i=vMalfunction.size()-1;i>=0;i--)
                           {
                                HashMap MalfunctionMap = (HashMap) vMalfunction.get(i);
                                String Malfunction_ID =(String) MalfunctionMap.get("ID");
                                String NAME=(String) MalfunctionMap.get("NAME");
                                int ip=0;
                                if(sSelectmalfuctionState!=null)
                                {
                                   for(int z=0;z<sSelectmalfuctionState.length;z++)
                                   {
                                       if(Malfunction_ID.equals(sSelectmalfuctionState[z]))
                                       {
                                          ip=1;
                                          break;
                                       }
                                   }
                                }
                                if(ip==0)
                                {
                      %>
                      <input type="checkbox" value="<%=Malfunction_ID%>" name="malfuctionState"><font class="pagetextdetails"><%=NAME%>&nbsp;&nbsp;               
                      <%
                                }
                                else
                                {
                      %>
                      <input type="checkbox" value="<%=Malfunction_ID%>" name="malfuctionState" checked><font class="pagetextdetails"><%=NAME%>&nbsp;&nbsp;               
                      <% 
                                }
                           }
                         }
                      %>
                    </font>            
                    </td>
                </tr>
             	<tr>
                  <td class="pagetitle1" style= "height: 30px; ">�ص�����״̬��</td>
                  <td>
                  <select style= "width: 315px; " name="demandflag" class="inputstyle" id="demandflag">
                    <%
                      if(sdemandflag==null)
                      {
                    %>
                      <option value="" class="pagetextdetails" > -------------- ѡ������ -------------- </option>
                      <option value="0" class="pagetextdetails" > [0] ʧЧ <br></option>
                      <option value="1" class="pagetextdetails" selected> [1] ��Ч <br></option>                    
                    <%                      	
                      }
                      else
                      {
                    	if(sdemandflag.equals(""))
                    	{
                     %>
                      <option value="" class="pagetextdetails" selected> -------------- ѡ������ -------------- </option>
                      <option value="0" class="pagetextdetails" > [0] ʧЧ <br></option>
                      <option value="1" class="pagetextdetails" > [1] ��Ч <br></option>
                     <%
                     	}
                     	else if(sdemandflag.equals("0"))
                     	{
                     %>
                      <option value="" class="pagetextdetails" > -------------- ѡ������ -------------- </option>
                      <option value="0" class="pagetextdetails" selected> [0] ʧЧ <br></option>
                      <option value="1" class="pagetextdetails" > [1] ��Ч <br></option>
                     <%
                     	}
                     	else if(sdemandflag.equals("1"))
                     	{
                     %>
                      <option value="" class="pagetextdetails" > -------------- ѡ������ -------------- </option>
                      <option value="0" class="pagetextdetails" > [0] ʧЧ <br></option>
                      <option value="1" class="pagetextdetails" selected> [1] ��Ч <br></option>
                     <%	
                     	}
                     	else
                     	{
                     %>
                      <option value="" class="pagetextdetails" > -------------- ѡ������ -------------- </option>
                      <option value="0" class="pagetextdetails" > [0] ʧЧ <br></option>
                      <option value="1" class="pagetextdetails" selected> [1] ��Ч <br></option>
                     <%
                     	}
                       }
                     %>
                    </select>      
                    </td>
                </tr>             
             
                <tr  class="contentbg">
                  <td class="pagetitle1" style= "height: 35px; ">�����ţ�</td>
                  <td class="pagetextdetails">
                  <input name="rId" type="text" class="inputstyle" id="rId"   size="50" value="<%=rId%>"></td>
                </tr>
                
                <tr>
                  <td class="pagetitle1" style= "height: 35px; ">���ϱ�ţ�</td>
                  <td class="pagetextdetails">
                  <input name="gId" type="text" class="inputstyle" id="gId"   size="50" value="<%=gId%>"></td>
                </tr>

              </table></td>
			 </tr>
	  		<tr> 
	          <td class="contentbottomline"><div align="left"> 
	              <table width="146" border="0" cellspacing="5" cellpadding="5">
	                <tr> 
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                      <tr> 
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">�� ѯ</td>
                             <input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="ToSubmit(this.form)" >
	                      </tr>
	                    </table></td>
	                  <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                      <tr> 
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" type="submit" name="B3" onclick="Update_GoToUrl(/*href*/'QueryImportRequirement.jsp?iCheckDate=1')">ͬ������<br></td>
	                      </tr>
	                    </table></td>
	                  <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                      <tr> 
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" type="submit" name="B1" onclick="toExport(/*href*/'exportQueryImportRequirementExcel.jsp?QueryStartTime=<%=QueryStartTime%>&QueryEndTime=<%=QueryEndTime%>&QueryProduct=<%=QueryProduct%>&QueryReq=<%=QueryReq%>&QueryGu=<%=QueryGu%>&sNewRid=<%=sNewRid%>&sNewGid=<%=sNewGid%>')">����EXCEL<br></td>
	                        <!--  td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="toExport.click()">����EXCEL</td>
    	                    <input type="toExport" name="toExport" id="CreatWord" runat="server"  style="display:none;" OnClick="toExport(this.form)" -->           
	                      </tr>
	                    </table></td>
	                </tr>
	              </table>
	            </div></td>
	        </tr>
	      </table></td>
	  	</tr>
</table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title"> 
          <td>�ص���������б�<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="3%" class="pagecontenttitle">ID</td>
                <td width="8%" class="pagecontenttitle">��Ʒ<br></td>
                <td width="17%" class="pagecontenttitle">����<br></td>
                <td width="5%" class="pagecontenttitle">ʡ��<br></td>
                <td width="5%" class="pagecontenttitle">״̬<br></td>
                <td width="8%" class="pagecontenttitle">�ƻ������ύʱ��<br></td>
                <td width="8%" class="pagecontenttitle">ʵ�ʿ����ύʱ��<br></td>
                <td width="8%" class="pagecontenttitle">�ƻ��������ʱ��<br></td>
                <td width="7%" class="pagecontenttitle">������Ա<br></td>
                <td width="8%" class="pagecontenttitle">������Ա<br></td>
                <td width="23%" class="pagecontenttitle">��ע<br></td>


              </tr>
			 <% 
			   if(sQueryDate.equals("1"))
			   {
			    // Vector vImportReq=importRequirment.getQueryImportRequirement(QueryStartTime,QueryEndTime,QueryProduct,QueryReq,QueryGu,rId,gId);
               	 Vector vImportReq=importRequirment.getQueryImportRequirement(QueryStartTime,QueryEndTime,QueryProduct,QueryReq,QueryGu,sNewRid,sNewGid,opId,sdemandflag);
                 if(vImportReq.size()>0)
                 {
                     iCheckAllCount=1;
			         for(int i=0;i<vImportReq.size();i++)
			         {
			            HashMap ImportReqMap=(HashMap) vImportReq.get(i);
			            String PRODUCT=(String)ImportReqMap.get("PRODUCT");
			            String NAME=(String)ImportReqMap.get("NAME");
			            String DEMAND_PROV=(String)ImportReqMap.get("DEMAND_PROV");
			            String STATE=(String)ImportReqMap.get("STATE");
			            //String STATE_NAME=(String)ImportReqMap.get("STATE_NAME");
			            //String PLAN_DEV_TIME=(String)ImportReqMap.get("PLAN_DEV_TIME");
	        		    //String REAL_DEV_TIME=(String)ImportReqMap.get("REAL_DEV_TIME");
	        		    //String DEV_NAME=(String)ImportReqMap.get("DEV_NAME");
	        		    //String TESTER_NAME=(String)ImportReqMap.get("TESTER_NAME");
	        		    //String PLAN_TEST_TIME=(String)ImportReqMap.get("PLAN_TEST_TIME");
	        		    //String REAL_TEST_TIME=(String)ImportReqMap.get("REAL_TEST_TIME");
	        		    String REMARK = (String)ImportReqMap.get("REMARK");
	        		    String TYPE=(String)ImportReqMap.get("TYPE");
	        		    String VALUE=(String)ImportReqMap.get("VALUE");
	        		    int iTYPE= Integer.parseInt(TYPE) ;
	        		    
	        		    
		        	  Vector ver = importRequirment.getImportRequirementInfo(VALUE,iTYPE);
			          if(ver.size()>0)
			          {
			            //iSumbitCount=1;
			            HashMap map =(HashMap) ver.get(0);
			            String STATE_NAME=(String) map.get("STATE");
			            String PLAN_DEV_TIME=(String) map.get("PLAN_DEV_TIME");
			            String REAL_DEV_TIME=(String) map.get("REAL_DEV_TIME");
	        			String PLAN_TEST_TIME=(String) map.get("PLAN_TEST_TIME");
	        			String REAL_TEST_TIME=(String) map.get("REAL_TEST_TIME");
	        			if(PLAN_DEV_TIME!=null)
	        		    {
	        			  if(PLAN_DEV_TIME.length()>10)
	        			    PLAN_DEV_TIME=PLAN_DEV_TIME.substring(0,10);
	        			}
	        			if(REAL_DEV_TIME!=null)
	        			{
	        			  if(REAL_DEV_TIME.length()>10)
	        			    REAL_DEV_TIME=REAL_DEV_TIME.substring(0,10);
	        		    }
	        		    if(PLAN_TEST_TIME!=null)
	        		    {
	        			  if(PLAN_TEST_TIME.length()>10)
	        			    PLAN_TEST_TIME=PLAN_TEST_TIME.substring(0,10);
	        			}
	        			if(REAL_TEST_TIME!=null)
	        			{
	        			  if(REAL_TEST_TIME.length()>10)
	        			    REAL_TEST_TIME=REAL_TEST_TIME.substring(0,10);
	        			}
	        			//��ȡ������Ա����ź����ƣ�
	        			Vector vtest =importRequirment.getImportRequirementTesterInfo(VALUE,iTYPE);
	        			String TESTER_NAME="";
	        			String sTestId="";
	        			if(vtest.size()>0)
	        			{
	        			   for(int itest=0;itest<vtest.size();itest++)
	        			   {
	        			      HashMap testMap =(HashMap) vtest.get(itest);
	        			      if(itest==0)
	        			      {
	        			         TESTER_NAME=(String) testMap.get("TESTER_NAME");
	        			      }
	                          else
	                          {
	                             TESTER_NAME=TESTER_NAME+";"+(String) testMap.get("TESTER_NAME");
	                          }
	        			   }
	        			}
	        			//��ȡ������Ա��ź�����
	
	        			Vector vdve =importRequirment.getImportRequirementDevInfo(VALUE,iTYPE);
	        			String DEV_NAME="";
	        			String sDevId="";
	        			if(vdve.size()>0)
	        			{
	        			   for(int idev=0;idev<vdve.size();idev++)
	        			   {
	        			      HashMap devMap =(HashMap) vdve.get(idev);
	        			      if(idev==0)
	        			      {
	        			         DEV_NAME=(String) devMap.get("DEV_NAME");
	        			      }
	                          else
	                          {
	                             DEV_NAME=DEV_NAME+";"+(String) devMap.get("DEV_NAME");
	                          }
	        			   }
	        			}
	        		    
	        		   
	        		 %>
				        <tr> 
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">(<%=i+1%>)</td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>"><%=PRODUCT%></td>
			              <td class="<%if(i%2!=0) out.print("coltext10"); else out.print("coltext20");%>"><a href="
				             <%
				             	if(TYPE.equals("1"))  //����
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+VALUE);
				             	}
				             	else  //if(TYPE.equals("2"))����
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+VALUE);
				             	}
				             %>"   target="_blank"><%=NAME%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>"><%=DEMAND_PROV%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>"><%=STATE_NAME%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(PLAN_DEV_TIME==null) out.print("&nbsp;");else out.print(PLAN_DEV_TIME);%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(REAL_DEV_TIME==null) out.print("&nbsp;");else out.print(REAL_DEV_TIME);%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(PLAN_TEST_TIME==null) out.print("&nbsp;");else out.print(PLAN_TEST_TIME);%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(DEV_NAME==null) out.print("&nbsp;");else out.print(DEV_NAME);%></td>
			              <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(TESTER_NAME==null) out.print("&nbsp;");else out.print(TESTER_NAME);%></td>
			              <td class="<%if(i%2!=0) out.print("coltext10"); else out.print("coltext20");%>">&nbsp;<%if(REMARK==null) out.print("&nbsp;");else out.print(REMARK);%></td>
			            </tr>
	         <%
	         	  	  } 
	         	  	}
	         	  }
	         	}
	         %>
             
            <tr> 
                <td width="3%" class="pagecontenttitle">ID</td>
                <td width="8%" class="pagecontenttitle">��Ʒ<br></td>
                <td width="17%" class="pagecontenttitle">����<br></td>
                <td width="5%" class="pagecontenttitle">ʡ��<br></td>
                <td width="5%" class="pagecontenttitle">״̬<br></td>
                <td width="8%" class="pagecontenttitle">�ƻ������ύʱ��<br></td>
                <td width="8%" class="pagecontenttitle">ʵ�ʿ����ύʱ��<br></td>
                <td width="8%" class="pagecontenttitle">�ƻ��������ʱ��<br></td>
                <td width="7%" class="pagecontenttitle">������Ա<br></td>
                <td width="8%" class="pagecontenttitle">������Ա<br></td>
                <td width="23%" class="pagecontenttitle">��ע<br></td>
            </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
        </table>      
<%
    String iCheckDate=request.getParameter("iCheckDate");
//    out.print("iCheckDate="+iCheckDate);
    if(iCheckDate!=null)
    {
      if(iCheckDate.equals("1"))
      {
         importRequirment.updateDate();
         out.print("<script language=javascript>alert('�����Ѿ�ͬ����');</script>");
      }
    }
 %>
<script language="javascript">
 //����excel
function toExport(url)
{
 
  // window.open("exportQueryImportRequirementExcel.jsp");
  var iCount=<%=iCheckAllCount%>;
  if(iCount==1)
  {
    window.open(url);
  }
  else
  {
    alert("û���κ����ݣ������²�ѯ���ٽ��е�����");
  }
  
  // window.open(url);
   // QueryStartTime,QueryEndTime,QueryProduct,QueryReq,QueryGu,sNewRid,sNewGid
}
</script>
</body>
</form>
</html>
