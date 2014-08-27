<%@include file="../allcheck.jsp"%>
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*"%>
<jsp:useBean id="importRequirment" scope="page" class="dbOperation.ImportRequriment" />
<%
  request.setCharacterEncoding("gb2312");
%>

<html>
<head>
<% 
   String loginName=(String)session.getValue("loginName");
   loginName=loginName+"@asiainfo.com";
   int iSumbitCount=0;
   
//获取系统时间
String sdate_s="";
String sDate="";    
   Vector vDataBaseDate=importRequirment.getDataBaseDate();
	if(vDataBaseDate.size()>0)
	{
	  HashMap dataBaseMap=(HashMap) vDataBaseDate.get(0);
	  sdate_s=(String) dataBaseMap.get("SDATE_S");
	  sDate=(String) dataBaseMap.get("SDATE");
	}   
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>重点需求录入管理</title>
<script language="JavaScript">
function move(fbox,tbox)  {
   for(var i=0; i<fbox.options.length; i++)  {
     if(fbox.options[i].selected && fbox.options[i].value != "")  {
        // 增加项目列表到右侧
        var no = new Option();
        no.value = fbox.options[i].value
        no.text = fbox.options[i].text
        tbox.options[tbox.options.length] = no;

        //  清空左侧的项目列表
        fbox.options[i].value = ""
        fbox.options[i].text = ""
     }
   }
   BumpUp(fbox);
   //SortD(tbox);
}
// 清除空的项目列表
function BumpUp(box)  {
  for(var i=0; i<box.options.length; i++)  {
     if(box.options[i].value == "")  {
       for(var j=i; j<box.options.length-1; j++)  {
         box.options[j].value = box.options[j+1].value
         box.options[j].text = box.options[j+1].text
       }
       var ln = i
       break
     }
   }
   if(ln < box.options.length)  {
     box.options.length -= 1;
     BumpUp(box);
   }
}

function clear_list2(fbox)  {
   for(var i=0; i<fbox.options.length; i++)  {
        //  清空项目列表
        fbox.options[i].value = ""
        fbox.options[i].text = ""
     }
   BumpUp(fbox);
   //SortD(tbox);
}



function FP_swapImg() {//v1.0
 var doc=document,args=arguments,elm,n; doc.$imgSwaps=new Array(); for(n=2; n<args.length;
 n+=2) { elm=FP_getObjectByID(args[n]); if(elm) { doc.$imgSwaps[doc.$imgSwaps.length]=elm;
 elm.$src=elm.src; elm.src=args[n+1]; } }
}

function FP_preloadImgs() {//v1.0
 var d=document,a=arguments; if(!d.FP_imgs) d.FP_imgs=new Array();
 for(var i=0; i<a.length; i++) { d.FP_imgs[i]=new Image; d.FP_imgs[i].src=a[i]; }
}

function FP_getObjectByID(id,o) {//v1.0
 var c,el,els,f,m,n; if(!o)o=document; if(o.getElementById) el=o.getElementById(id);
 else if(o.layers) c=o.layers; else if(o.all) el=o.all[id]; if(el) return el;
 if(o.id==id || o.name==id) return o; if(o.childNodes) c=o.childNodes; if(c)
 for(n=0; n<c.length; n++) { el=FP_getObjectByID(id,c[n]); if(el) return el; }
 f=o.forms; if(f) for(n=0; n<f.length; n++) { els=f[n].elements;
 for(m=0; m<els.length; m++){ el=FP_getObjectByID(id,els[n]); if(el) return el; } }
 return null;
}

function FP_changeProp() {//v1.0
 var args=arguments,d=document,i,j,id=args[0],o=FP_getObjectByID(id),s,ao,v,x;
 d.$cpe=new Array(); if(o) for(i=2; i<args.length; i+=2) { v=args[i+1]; s="o"; 
 ao=args[i].split("."); for(j=0; j<ao.length; j++) { s+="."+ao[j]; if(null==eval(s)) { 
  s=null; break; } } x=new Object; x.o=o; x.n=new Array(); x.v=new Array();
 x.n[x.n.length]=s; eval("x.v[x.v.length]="+s); d.$cpe[d.$cpe.length]=x;
 if(s) eval(s+"=v"); }
}







function changecolor(obj){
obj.className = "buttonstyle2"}

function restorcolor(obj){
obj.className = "buttonstyle"}	

function FP_goToQueryURL(url)
{
   var reqId=document.getElementById('requirement').value;
   window.location=url+"?requirement="+reqId;
}

function ToSubmit(form1)
{
   var sSumbitId =document.getElementById("sSumbitId").value;
   if(sSumbitId==1)
   {
     var iCount=document.open.list2.length;
     var no = new Option();
     no.value = "<%=loginName%>";
     no.text = "<%=loginName%>";
     document.open.list2.options[iCount] = no;
     for (i=0; i<document.open.list2.length; i++)
     {
       document.open.list2.options[i].selected = true;
     }
     form1.submit();
   }
   else
   {
      alert("没有重要需求故障录入，请查询后再提交!");
   }
}

</script>
<script language="JavaScript"  src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<% 
    String sRMId=request.getParameter("requirement");
   // String[] arrRmid=new String[100];
    if(sRMId!=null && sRMId!="") 
       sRMId=sRMId.toUpperCase();
    if(sRMId==null)
      sRMId="";
  //  out.print("需求或者故障编号："+sRMId+"<br>");
    String arrRmid[]=sRMId.split(",");
   // out.print("<script language=JavaScript>window.confirm('是否确定删除?');</script>");
%>

</head>
<body>
<form method="post" action="ImportRequirementManagerdo.jsp" name="open">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="pagetitle1"> 
          <td>需求/故障编号（如编号12345是需求，请以R开头，例如：R12345；如是故障编号，请以F开头，例如：F12345,支持多个需求故障同时查询,请以英文逗号分割，如：R123,F234,R345）：<br></td>
          <td width="24"> <div align="left"><br></div>
        <tr> 
         <td>
          <input type="text" name="requirement" id="requirement" class="inputstyle"  value="<%=sRMId%>" size="100">
          </td>
        </tr>
</table>

<tr> 
   <td><div align="left">
   <table width="146" border="0" cellspacing="5" cellpadding="5">
   <tr>
	<td width="100">
	<table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" type="submit" name="B3" onclick="FP_goToQueryURL(/*href*/'ImportRequirementManager.jsp')">查询<br></td>
    	</tr> 
     </table>
    </td>
   </tr>
   </table>
  </td>
</tr>
<tr>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr class="title"> 
          <td>需求/故障信息<br></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="3%" class="pagecontenttitle">ID</td>
                <td width="10%" class="pagecontenttitle">产品<br></td>
                <td width="15%" class="pagecontenttitle">名称<br></td>
                <td width="7%" class="pagecontenttitle">省份<br></td>
                <td width="7%" class="pagecontenttitle">状态<br></td>
                <td width="10%" class="pagecontenttitle">计划开发提交时间<br></td>
                <td width="10%" class="pagecontenttitle">实际开发提交时间<br></td>
                <td width="9%" class="pagecontenttitle">开发人员<br></td>
                <td width="9%" class="pagecontenttitle">测试人员<br></td>
                <td width="10%" class="pagecontenttitle">计划测试完成时间<br></td>
                <td width="10%" class="pagecontenttitle">实际测试完成时间<br></td>
              </tr>
		<% 
		   if(!sRMId.equals(""))
		   {
              for(int i=0;i<arrRmid.length;i++)
              {    
                 int iRMId=arrRmid[i].indexOf("R");
		         if(iRMId>=0)
		           iRMId=1;
		         else
		           iRMId=2; 
		          String sSubRMId=arrRmid[i].substring(1);
		          Vector ver = importRequirment.getImportRequirementInfo(sSubRMId,iRMId);
		          if(ver.size()>0)
		          {
		            iSumbitCount=1;
		            HashMap map =(HashMap) ver.get(0);
		            String sFuncName=(String) map.get("FUNCNAME");
		            String sDEMAND_PROV=(String)map.get("DEMAND_PROV");
		            String sSTATE=(String) map.get("STATE");
		            String PLAN_DEV_TIME=(String) map.get("PLAN_DEV_TIME");
		            String REAL_DEV_TIME=(String) map.get("REAL_DEV_TIME");
        			String PLAN_TEST_TIME=(String) map.get("PLAN_TEST_TIME");
        			String REAL_TEST_TIME=(String) map.get("REAL_TEST_TIME");
        			String PRODUCT=(String)map.get("PRODUCT");
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
        			//获取测试人员（编号和名称）
        			Vector vtest =importRequirment.getImportRequirementTesterInfo(sSubRMId,iRMId);
        			String sTestName="";
        			String sTestId="";
        			if(vtest.size()>0)
        			{
        			   for(int itest=0;itest<vtest.size();itest++)
        			   {
        			      HashMap testMap =(HashMap) vtest.get(itest);
        			      if(itest==0)
        			      {
        			         sTestName=(String) testMap.get("TESTER_NAME");
        			      }
                          else
                          {
                             sTestName=sTestName+";"+(String) testMap.get("TESTER_NAME");
                          }
        			   }
        			}
        			//获取开发人员编号和名称

        			Vector vdve =importRequirment.getImportRequirementDevInfo(sSubRMId,iRMId);
        			String sDevName="";
        			String sDevId="";
        			if(vdve.size()>0)
        			{
        			   for(int idev=0;idev<vdve.size();idev++)
        			   {
        			      HashMap devMap =(HashMap) vdve.get(idev);
        			      if(idev==0)
        			      {
        			         sDevName=(String) devMap.get("DEV_NAME");
        			      }
                          else
                          {
                             sDevName=sDevName+";"+(String) devMap.get("DEV_NAME");
                          }
        			   }
        			}
        			
        			if(i%2!=0)
        			{
        		 %>
			        <tr> 
			             <td class="coltext">(<%=i+1%>)</td>
			             <td class="coltext"><%=PRODUCT%></td>
			             <td class="coltext"><%=sFuncName%></td>
			             <td class="coltext"><%=sDEMAND_PROV%></td>
			             <td class="coltext"><%=sSTATE%></td>
			             <td class="coltext"><%=PLAN_DEV_TIME%></td>
			             <td class="coltext"><%=REAL_DEV_TIME%></td>
			             <td class="coltext"><%=sDevName%></td>
			             <td class="coltext"><%=sTestName%></td>
			             <td class="coltext"><%=PLAN_TEST_TIME%></td>
			             <td class="coltext"><%=REAL_TEST_TIME%></td>
			         </tr>
         	<%
         		    }
         	 	   if(i%2==0)
         	 	   {
         	  %>
			        <tr> 
			             <td class="coltext2" >(<%=i+1%>)</td>
			             <td class="coltext2"><%=PRODUCT%></td>
			             <td class="coltext2"><%=sFuncName%></td>
			             <td class="coltext2"><%=sDEMAND_PROV%></td>
			             <td class="coltext2"><%=sSTATE%></td>
			             <td class="coltext2"><%=PLAN_DEV_TIME%></td>
			             <td class="coltext2"><%=REAL_DEV_TIME%></td>
			              <td class="coltext2"><%=sDevName%></td>
			             <td class="coltext2"><%=sTestName%></td>
			             <td class="coltext2"><%=PLAN_TEST_TIME%></td>
			             <td class="coltext2"><%=REAL_TEST_TIME%></td>
			         </tr>         	  
        <%
                   }
                 }
               }      
          }   
          
             if(iSumbitCount==1)
             {
         %>
                <input type="hidden" name="sSumbitId" id='sSumbitId' value="1">
                
         <%
             }
             else
             {
         %>
              <input type="hidden" name="sSumbitId" id='sSumbitId' value="0">
         <%
             }
         %>
              <tr> 
                <td width="3%" class="pagecontenttitle">ID</td>
                <td width="10%" class="pagecontenttitle">产品<br></td>
                <td width="15%" class="pagecontenttitle">名称<br></td>
                <td width="7%" class="pagecontenttitle">省份<br></td>
                <td width="7%" class="pagecontenttitle">状态<br></td>
                <td width="10%" class="pagecontenttitle">计划开发提交时间<br></td>
                <td width="10%" class="pagecontenttitle">实际开发提交时间<br></td>
                <td width="9%" class="pagecontenttitle">开发人员<br></td>
                <td width="9%" class="pagecontenttitle">测试人员<br></td>
                <td width="10%" class="pagecontenttitle">计划测试完成时间<br></td>
                <td width="10%" class="pagecontenttitle">实际测试完成时间<br></td>
              </tr>
	</table>
</td>
</tr>
</table>
</tr>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr class="title">
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="title">
            <td>重点需求录入
            </td>
            <td width="24"  height="24"><br></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
               
              <tr class="contentbg"> 
                <td class="pagetitle1">
                <input type="checkbox" name="ck1" value="1">计划提交时间：</td>
                <td class="pagetitle1">
                <input style= "width: 80px; " name="PLAN_DEV_TIME" class="inputstyle" id="PLAN_DEV_TIME" onClick="JSCalendar(this);" value="<%=sDate%>"> 提前<input type=text name="dvetime" class="inputstyle" size="3">天 </td>
              </tr>
              
              <tr> 
                <td class="pagetitle1"><input type="checkbox" name="ck2" value="1">计划测试时间：</td>
                <td class="pagetitle1"><input style= "width: 80px; " name="PLAN_TEST_TIME" class="inputstyle" id="PLAN_TEST_TIME" onClick="JSCalendar(this);" value="<%=sDate%>"> 提前<input type=text name="testtime" class="inputstyle" size="3">天
                  </td>
              </tr>
              
              <tr class="contentbg"> 
                <td class="pagetitle1">
                <input type="checkbox" name="ck3" value="1">计划发布时间：</td>
                <td class="pagetitle1">
                <input style= "width: 80px; " name="PLAN_RELEASE_TIME" class="inputstyle" id="PLAN_RELEASE_TIME" onClick="JSCalendar(this);" value="<%=sDate%>"> 提前<input type=text name="releasetime" class="inputstyle" size="3">天 </td>
              </tr>
              
              <tr> 
                <td class="pagetitle1">备注：</td>
                <td class="pagetitle1">
                <textarea type="text" name="remark" class="inputstyle" id="remark" style= "width: 500px; "></textarea> </td>
              </tr>
              
               <tr  class="contentbg">
                  <td class="pagetitle1">抄送：</td>
                  <td class="pagetitle1">
                  <input type="text" name="email" class="inputstyle" id="title" style= "width: 500px; "></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">

              </table></td>
          </tr>
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="10%">&nbsp;</td>
                  <td width="34%" class="pagetitle1">员工列表:</td>
                  <td width="12%" class="pagetitle1">&nbsp;</td>
                  <td width="44%" class="pagetitle1">抄送人员列表：</td>
                </tr>
                <tr>
                  <td class="pagetitle1">抄送：</td>
                  <td><div onDblClick="move(document.open.list1,document.open.list2)">
                      <select name="list1" size="8" multiple class="inputstyle" width=150 >
                        <%String sgroupid;
 sgroupid="2";                       
 Vector ver =importRequirment.getAllMailInfo(sgroupid);
 for(int j=0;j<ver.size();j++)
 {
    HashMap map =(HashMap) ver.get(j);
    String sMail=(String) map.get("OP_MAIL");
    String sName=(String) map.get("OP_NAME");
%>
                        <option value=<%=sMail%>> <font size="2"><%=sMail%></font>-<%=sName%> </option>
                        <%
}
%>
                      </select>
                    </div></td>
                  <td align="center" valign="middle"><div align="center"> <br>
                      <table width="100%" border="0" cellspacing="1" cellpadding="1">
                        <tr>
                          <td><div align="center">
                              <table width="34" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                  <td width="30" class="buttonstyle" onClick="move(document.open.list1,document.open.list2)" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" >&gt;&gt;&gt;</td>
                                </tr>
                              </table>
                            </div></td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <table width="34" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                  <td width="30" class="buttonstyle" onClick="move(document.open.list2,document.open.list1);" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)">&lt;&lt;&lt;</td>
                                </tr>
                              </table>
                            </div></td>
                        </tr>
                      </table>
                      <br>
                      <br>
                    </div></td>
                  <td><div onDblClick="move(document.open.list2,document.open.list1);">
                      <select name="list2" size="8" multiple class="inputstyle" width=150>
                      </select>
                    </div></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td><div align="center">
                <table width="146" border="0" cellspacing="5" cellpadding="5">
                  <tr>
                    <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                        <tr>
                          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)"  onClick="hiddenButton.click();">提 交</td>
                          <input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="ToSubmit(this.form)" >
                        </tr>
                      </table></td>
                  </tr>
                </table>
              </div></td>
          </tr>
        </table></td>
    </tr>
  </table>

</form>

</body>

</html>