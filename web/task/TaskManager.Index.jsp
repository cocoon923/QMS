<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*"%>

<%
  request.setCharacterEncoding("gb2312");
%>

<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���������ҳ</title>
<script language="JavaScript">

function textCounter(field,iCount)
{
   var text=field.value;
   var iCount1=iCount+1;
   if (text==null)
   {
   	 text="";
   }
   if(text.replace(/[^\x00-\xff]/g,"xx").length>iCount)
   {
     alert("���볬��"+iCount1+"�ַ���");
     var str = "";  
     var l = 0;  
     var schar;  
     for(var i=0; schar=text.charAt(i); i++)  
     {  
        str += schar;  
        l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);  
        if(l >= iCount)  
        {  
            break;  
        }  
     }  
    field.value=str; 
   }
}


function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}	


</script>
<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">

</head>
<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">  
  <tr class="title">δ���������б�<br></tr>
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
  <td width="3%" class="pagecontenttitle"><div align="center"></div></td>
  <td width="3%" class="pagecontenttitle">���</td>
  <td width="10%" class="pagecontenttitle">������<br></td>
  <td width="30%" class="pagecontenttitle">��������<br></td>
  <td width="30%" class="pagecontenttitle">���������<br></td>
  <td width="10%" class="pagecontenttitle">����ִ����<br></td>
  <td width="14%" class="pagecontenttitle">�������ʱ��<br></td>
  </tr></table></td></tr></table></tr></table>
  
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr>
  <table  border="0" align="left" cellpadding="0" cellspacing="0">
  
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" >��������<br></td>
  </tr></table></td>
 	
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" >ת������<br></td>
  </tr></table></td>

  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" >�ر�����<br></td>
  </tr></table></td>
  
  </table></tr></table>
  
  
</body>
</html>


