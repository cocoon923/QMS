<%@include file="allcheck.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

<SCRIPT language="Javascript">


var NaviArray = new Array();
//deep从1开始.
function addNavi(newValue,deep)
{
   //alert("deep="+deep);
   while(NaviArray.length>(deep-1))
      NaviArray.pop();
   NaviArray.push(newValue);
   var tmp = '';
   //alert("array length="+NaviArray.length);
   for(i=0;i<NaviArray.length;i++){
     if(i==0)
       tmp+=NaviArray[i];
     else
       tmp+='>>'+NaviArray[i];
   }
   var Navi = document.all.item("Navi");
   Navi.innerText=""
   Navi.innerText=tmp;
}
function removeAll(){
  tmp = NaviArray.length;
  for(i=0;i<tmp;i++){
    NaviArray.pop();
  }
  var Navi = document.all.item("Navi");
  Navi.innerText=tmp;
}
function postFunc(pFuncId,pViewName)
{
   if(pViewName==null || pFuncId==null)
     return;
   //alert("in postfunc viewname="+pViewName);
   if(pViewName!="menuRight" && pViewName!="" && pViewName!=" ")
     {
	   //alert("in postfunc,ok,will post id="+pFuncId);
	   var msg = PostInfo("","aibusiness.custservice.CrmAgent",1001,"Func_ID="+pFuncId);
	   //alert("msg="+msg);
	 }
  
}
function closeWin()
{
   top.opener=null;   
   top.close(); 
  // top.window.close();
}


</SCRIPT>
<% 
    String sUserName=(String)session.getValue("OpName");  //获取登陆名称
        Date dDate=new Date();   //获取系统时间
//    Calendar calendar = new GregorianCalendar();
//    java.util.Date trialTime = new java.util.Date();
//    calendar.setTime(trialTime);
    int year = Calendar.getInstance().get(Calendar.YEAR);
    int month = Calendar.getInstance().get(Calendar.MONTH)+1;
    int date = Calendar.getInstance().get(Calendar.DATE);
//    int day = calendar.get(Calendar.DAY_OF_MONTH);
//    int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
//    int minute = Calendar.getInstance().get(Calendar.MINUTE);
//    int second = Calendar.getInstance().get( Calendar.SECOND); 

	
%>
<head>
<META HTTP-EQUIV="Expires" CONTENT="Mon, 04 Dec 1999 21:29:02 GMT">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma"  CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<%@page contentType="text/html; charset=gb2312"%>
<%@page buffer="none"%>
<title>TOP页面</title>
<link href="css/topstyle.css" rel="stylesheet" type="text/css">
</head>

<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="toptable1">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="62%" class="comumberinfo"> <span class="redtag">|</span> 
            <span class="comumberinfor2">操作员：</span><%=sUserName%><span class="redtag">|</span> 
            <span class="comumberinfor2">所属公司：</span>亚信 <span class="redtag">| 
            </span><span class="comumberinfor2">所属组：</span>CRM<span class="redtag">|</span>
            <span class="comumberinfor2">系统时间：</span><%out.print(year+"-"+month+"-"+date);%><span class="redtag">|</span></td>
          <td width="38%"><div align="right"><!--img src="images/bigtitle.gif" width="307" height="25"--></div></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="58"><table width="100%" height="58" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="351" valign="top" background="images/titlebg.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td bgcolor="#FF4A00"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr align="center" valign="middle" onclick="WindowClose()"> 
                            <td width="26"><img src="images/back.gif" width="22" height="19"></td>
                            <td width="51" class="functiontext"><a href="admin.jsp" target="_parent" class="functiontext">返回首页</a></td>
                            <td width="23"><img src="images/hindpage.gif" width="22" height="19"></td>
                            <td width="57"><a href="#" class="functiontext">隐藏首页</a></td>
                            <td width="22"><img src="images/off.gif" width="22" height="19"></td>
                            <td width="35"><a href="login.jsp" target="_parent"  class="functiontext">注销</a></td>
                            <td width="24"><img src="images/close.gif" width="22" height="19"></td>
                            <td width="31")"><a href="" class="functiontext" onclick="closeWin()">关闭</a></td>
                            <td width="22"><img src="images/help.gif" width="22" height="19"></td>
                            <td width="40"><a href="admin.jsp" target="_parent"    class="functiontext">帮助</a></td>
                          </tr>
                        </table></td>
                      <td width="19">
<div align="right"><img src="images/topminedge.gif" width="19" height="21"></div></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td></td>
              </tr>
            </table>
          </td>
          <td width="284" valign="middle" background="images/titlebg.gif"> 
					  
            <div align="center" ><font color="#444444" size="+3" face="黑体"><strong><label id='Navi'></label> 
              </strong></font></div></td>

          <!-- <td width="153" align="right" valign="bottom" background="images/logobg.gif"> 
            <div align="right"><img src="images/logo.gif" width="151" height="52"></div></td> -->
        </tr>
      </table></td>
  </tr>
</table>
</body>

</html>
