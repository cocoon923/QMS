<%@ page contentType="application/msword; charset=UTF-8" import="java.util.*,java.io.*,java.sql.*"   language="java"%>

<jsp:useBean id="dataBean" scope="page" class="dbOperation.wordResult" />
<jsp:useBean id="CaseInfo" scope="page" class="dbOperation.CaseInfo" />
<%
  request.setCharacterEncoding("gb2312");

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">


<%
    StringBuffer hostur=request.getRequestURL();  //获取当前页面URL地址
    String hosturl=hostur.toString();
    hosturl=hosturl.substring(0,hosturl.indexOf("AICMS"));
    
    String sRMId=request.getParameter("requirement");
	//String sRMId="R20030";
	int iRMId=0;
	String sSubRMId=sRMId.substring(1);
    iRMId=sRMId.indexOf("R");
    if(iRMId>=0)
		iRMId=1;
	else
		iRMId=2; 
	Vector aAuthorInfo=dataBean.getAuthorInfo(sSubRMId,iRMId);
	String sAuthorName="";
	String sAuthorName1="";
	String sAuthorDate="";
	String sTemp="";
	String sTemp1 ="";
	String sTemp2="";
	//获取作者(包括登陆的用户名和中文名)和时间记录
	ArrayList arrAuthorInfo=new ArrayList();
	ArrayList arrAuthorDate=new ArrayList();
	if(aAuthorInfo.size()>0)
	{
	   for(int i=aAuthorInfo.size()-1;i>=0;i--)
	   {
	       HashMap hash = (HashMap) aAuthorInfo.get(i);
           sTemp = (String) hash.get("OP_NAME");  //获取中文名
		   sTemp1 = (String) hash.get("OP_LOGIN");  //获取登陆名
		   sTemp2=(String) hash.get("OP_ID");
		   if(i==(aAuthorInfo.size()-1))
		   {
		     sAuthorName=sTemp;
			 sAuthorName1=sTemp1;
		   }
		   else
		   {
		      sAuthorName=sAuthorName+"、"+sTemp;
			  sAuthorName1=sAuthorName1+","+sTemp1;
			}
		   arrAuthorInfo.add(sTemp);  //将编写者放到arraylist中
		   
		   //获取一个编写者最大的编写时间
		   Vector aAuthorMaxDate=dataBean.getAuthorMaxDate(sSubRMId,iRMId,sTemp2);
		   if(aAuthorMaxDate.size()>0)
		   {   
		       HashMap hashDate = (HashMap) aAuthorMaxDate.get(0);
		       sTemp=(String) hashDate.get("OP_TIME");
		   }
		   else
		   {
		     sTemp="";
		   }
		   //sTemp=(String) hash.get("OP_TIME");
		   arrAuthorDate.add(sTemp);
		   
		  // if(i==aAuthorInfo.size()-1)
		  //   sAuthorDate=sTemp;
	   }
	}
	if(arrAuthorDate.size()>0)
		{sAuthorDate=(String)arrAuthorDate.get(0);}
	String sWordName="";
	String sWordDate="";
	Vector aWordName=dataBean.getWordName(sSubRMId,iRMId);
	if(aWordName.size()>0)
	{
        HashMap hash2 = (HashMap) aWordName.get(0);
		sWordName=(String) hash2.get("NEWCASEID");
		sWordDate=(String) hash2.get("NEWDATE");
		
	}
	sWordName=sWordName+"-"+sAuthorName1+"-"+sWordDate+".doc";
	
	int iCountAttachment=0;
	Vector vAttachment=new Vector();
	vAttachment=CaseInfo.getDemandAttachmentInfo(sSubRMId,iRMId,"DEMAND_SOLUTION","");
	iCountAttachment=vAttachment.size();
	
	int iCountAttachment1=0;
	Vector vAttachment1=new Vector();
	vAttachment1=CaseInfo.getDemandAttachmentInfo(sSubRMId,iRMId,"REMARK3","");
	iCountAttachment1=vAttachment1.size();
%>
<%
   //记得不要不屏蔽
     response.setHeader( "Content-Disposition", "attachment;filename="  + new String( sWordName.getBytes("gb2312"), "ISO8859-1" ) );

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>生成word</title>
<style type="text/css">
/* Page Definitions */ 
@page Section1 
{size:841.9pt 595.3pt; 
mso-page-orientation:landscape; 
margin:89.85pt 72.0pt 89.85pt 3.0cm; 
layout-grid:15.6pt;} 


div.Section1
	{page:Section1;}
 p.MsoNormal
	{margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman","serif";
		margin-left: 0cm;
	margin-right: 0cm;
	margin-top: 0cm;
	}
  p.MsoNormalleft
	{margin-bottom:.0001pt;
	text-align:left;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman","serif";
		margin-left: 0cm;
	margin-right: 0cm;
	margin-top: 0cm;
	}
 table.MsoNormalTable
	{font-size:10.0pt;
	font-family:"Times New Roman","serif";
}
h1
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-left:21.6pt;
	text-indent:-21.6pt;
	page-break-before:always;
	page-break-after:avoid;
	tab-stops:list 21.6pt;
	font-size:22.0pt;
	font-family:"Times New Roman","serif";
	}
h2
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-left:28.8pt;
	text-indent:-28.8pt;
	page-break-after:avoid;
	tab-stops:list 28.8pt;
	font-size:16.0pt;
	font-family:"Times New Roman","serif";
	}
p.MsoNormalIndent
	{margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:"Times New Roman","serif";
		margin-left: 0cm;
	margin-right: 0cm;
	margin-top: 0cm;
}
h3
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-left:36.0pt;
	text-indent:-36.0pt;
	page-break-after:avoid;
	tab-stops:list 36.0pt;
	font-size:16.0pt;
	font-family:"Times New Roman","serif";
}
</style>
</head>

<body>

<div class="Section1" style="layout-grid:15.6pt">
	<p class="MsoNormal" align="center" style="text-align:center">
	<a name="_Toc52455870"><span lang="EN-US" style="color:black"><o:p>&nbsp;</o:p></span></a></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="color:black"><o:p>&nbsp;</o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="color:black"><o:p>&nbsp;</o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="color:black"><o:p>&nbsp;</o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="font-size:36.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
黑体;color:black">OPENBOSS-OB</span><span style="font-size:36.0pt;mso-bidi-font-size:12.0pt;font-family:黑体;mso-ascii-font-family:
&quot;Century Gothic&quot;;color:black">营帐</span><span lang="EN-US" style="font-size:36.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:黑体;color:black"><o:p></o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870"><b>
	<span style="font-size:28.0pt;mso-bidi-font-size:
12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;;color:black">
	功能测试文档</span></b><span lang="EN-US" style="font-size:36.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
黑体;color:black"><o:p></o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870"><b>
	<span style="font-size:24.0pt;mso-bidi-font-size:
12.0pt;font-family:黑体;mso-ascii-font-family:&quot;Century Gothic&quot;;color:black">
	版本：</span></b></span><st1:chsdate
IsROCDate="False" IsLunarDate="False" Day="30" Month="12" Year="1899" w:st="on"><span style="mso-bookmark:_Toc52455870"><b><span lang="EN-US" style="font-size:24.0pt;
 mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
 mso-fareast-font-family:黑体;color:black">3.0.0</span></b></span></st1:chsdate><span style="mso-bookmark:_Toc52455870"><b><span lang="EN-US" style="font-size:24.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
黑体;color:black"><o:p></o:p></span></b></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="color:black"><o:p>&nbsp;</o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="color:black"><o:p>&nbsp;</o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;mso-fareast-font-family:楷体_GB2312;mso-no-proof:yes"><o:p>
	&nbsp;</o:p></span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span lang="EN-US" style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;mso-fareast-font-family:楷体_GB2312;mso-no-proof:yes"><o:p>
	&nbsp;</o:p></span></span></p>
	<table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" style="margin-left:77.4pt;border-collapse:collapse;border:none;mso-border-alt:
 solid windowtext .5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext">
		<tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:16.7pt">
			<td width="96" valign="top" style="width:72.0pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			编</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> </span>
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:楷体_GB2312;
  mso-ascii-font-family:&quot;Century Gothic&quot;">写</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> <span lang="EN-US"><o:p></o:p></span></span></span></p>
			</td>
			<td width="324" colspan="4" valign="top" style="width:243.0pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Century Gothic&quot;"><%=sAuthorName%></span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="153" colspan="2" valign="top" style="width:114.65pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			编写</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> </span>
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:楷体_GB2312;
  mso-ascii-font-family:&quot;Century Gothic&quot;">时间</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="123" valign="top" style="width:92.35pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870"><st1:chsdate IsROCDate="False"
  IsLunarDate="False" Day="31" Month="10" Year="2008" w:st="on">
			<span lang="EN-US" style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:
   &quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:楷体_GB2312">
			<%=sAuthorDate%></span></st1:chsdate><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:1;height:20.75pt">
			<td width="96" valign="top" style="width:72.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:20.75pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:9.0pt;font-family:
  楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;;color:black;mso-font-kerning:
  10.0pt;mso-bidi-font-weight:bold">电子版文件名</span></span><span style="mso-bookmark:
  _Toc52455870"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="600" colspan="7" valign="top" style="width:450.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:20.75pt">
			<p class="MsoNormal" style="margin-left:63.0pt;text-indent:-63.0pt;mso-char-indent-count:
  -7.0"><span style="mso-bookmark:_Toc52455870">
			<span style="font-size:9.0pt;
  font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Century Gothic&quot;;color:black;mso-font-kerning:10.0pt;mso-bidi-font-weight:
  bold"><%=sWordName%><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:2;height:17.55pt">
			<td width="96" valign="top" style="width:72.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			审</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> </span>
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:楷体_GB2312;
  mso-ascii-font-family:&quot;Century Gothic&quot;">核</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="324" colspan="4" valign="top" style="width:243.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			审核者姓名（及其职务）</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="153" colspan="2" valign="top" style="width:114.65pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			审核</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> </span>
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:楷体_GB2312;
  mso-ascii-font-family:&quot;Century Gothic&quot;">时间</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="123" valign="top" style="width:92.35pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p>&nbsp;</o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:3;height:16.7pt">
			<td width="96" valign="top" style="width:72.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			审</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> </span>
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:楷体_GB2312;
  mso-ascii-font-family:&quot;Century Gothic&quot;">批</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="324" colspan="4" valign="top" style="width:243.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			审批者姓名（及其职务）</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="153" colspan="2" valign="top" style="width:114.65pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			审批</span><span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
  楷体_GB2312"> </span>
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:楷体_GB2312;
  mso-ascii-font-family:&quot;Century Gothic&quot;">时间</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="123" valign="top" style="width:92.35pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.7pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p>&nbsp;</o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:4;page-break-inside:avoid;height:17.55pt">
			<td width="96" rowspan="2" style="width:72.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			文档管理</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="48" valign="top" style="width:35.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			页码</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="125" valign="top" style="width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			共</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312;mso-hansi-font-family:&quot;Times New Roman&quot;">25</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"> </span></span>
			<span style="mso-bookmark:
  _Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;
  font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">页</span></span><span style="mso-bookmark:_Toc52455870"><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="125" valign="top" style="width:93.65pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			修订次数</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="125" colspan="2" valign="top" style="width:93.55pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			共</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312">1</span></span><span style="mso-bookmark:
  _Toc52455870"><span style="font-size:10.0pt;mso-bidi-font-size:12.0pt;
  font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">次</span></span><span style="mso-bookmark:_Toc52455870"><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="55" valign="top" style="width:40.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			版本</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="123" valign="top" style="width:92.35pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.55pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312">V3.0<o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:5;mso-yfti-lastrow:yes;page-break-inside:avoid;
  height:8.0pt">
			<td width="48" valign="top" style="width:35.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:8.0pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span style="font-size:10.0pt;mso-bidi-font-size:
  12.0pt;font-family:楷体_GB2312;mso-ascii-font-family:&quot;Century Gothic&quot;">
			编号</span><span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p></o:p></span></span></p>
			</td>
			<td width="552" colspan="6" valign="top" style="width:414.05pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:8.0pt">
			<p class="MsoNormal" align="center" style="text-align:center">
			<span style="mso-bookmark:_Toc52455870">
			<span lang="EN-US" style="font-size:10.0pt;
  mso-bidi-font-size:12.0pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  mso-fareast-font-family:楷体_GB2312"><o:p>&nbsp;</o:p></span></span></p>
			</td>
		</tr>
		<![if !supportMisalignedColumns]>
		<tr height="0">
			<td width="88" style="border:none"></td>
			<td width="46" style="border:none"></td>
			<td width="113" style="border:none"></td>
			<td width="114" style="border:none"></td>
			<td width="24" style="border:none"></td>
			<td width="89" style="border:none"></td>
			<td width="52" style="border:none"></td>
			<td width="118" style="border:none"></td>
		</tr>
		<![endif]>
	</table>
	<p class="MsoNormal" align="center" style="margin-top:12.0pt;text-align:center;
mso-pagination:widow-orphan"><span style="mso-bookmark:_Toc52455870">
	<b style="mso-bidi-font-weight:normal">
	<span style="font-family:宋体;mso-ascii-font-family:
&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">
	亚信科技（中国）有限公司版权所有</span><span lang="EN-US"><o:p></o:p></span></b></span></p>
	<p class="MsoNormal" align="center" style="margin-top:12.0pt;text-align:center;
mso-pagination:widow-orphan"><span style="mso-bookmark:_Toc52455870">
	<span style="font-family:宋体;mso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;">文档中的全部内容属亚信科技（中国）有限公司所有，</span></span></p>
	<p class="MsoNormal" align="center" style="text-align:center">
	<span style="mso-bookmark:_Toc52455870">
	<span style="font-family:宋体;mso-ascii-font-family:
&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">
	未经允许，不可全部或部分发表、复制、使用于任何目的</span><span lang="EN-US" style="mso-fareast-font-family:
楷体_GB2312"><o:p></o:p></span></span></p>
</div>
<span lang="EN-US" style="font-size:10.5pt;mso-bidi-font-size:12.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:楷体_GB2312;mso-font-kerning:
1.0pt;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:
AR-SA">
<br clear="all" style="page-break-before:always;mso-break-type:section-break" />
</span>
<p class="MsoNormal" align="center" style="text-align:center;line-height:150%;page-break-before:always;mso-pagination:widow-orphan lines-together;page-break-after:avoid">
<span style="mso-bookmark:_Toc52455870">
<b style="mso-bidi-font-weight:
normal">
<span style="font-size:12.0pt;line-height:150%;font-family:宋体;
mso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;;
color:black">文档修改记录</span></b><b style="mso-bidi-font-weight:normal"><span lang="EN-US" style="font-size:12.0pt;
line-height:150%;color:black"><o:p></o:p></span></b></span></p>
<table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" width="804" style="border: medium none ; margin-left: 78.35pt; border-collapse: collapse;" height="183">
	<tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;page-break-inside:avoid;
  height:22.4pt">
		<td width="98" style="width:73.75pt;border:solid windowtext 1.0pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.4pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<b style="mso-bidi-font-weight:normal">
		<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;">日期</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></b></span></p>
		</td>
		<td width="59" style="width:44.55pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.4pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<b style="mso-bidi-font-weight:normal">
		<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;">修订号</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></b></span></p>
		</td>
		<td width="427" style="width:320.6pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.4pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<b style="mso-bidi-font-weight:normal">
		<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;">描述</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></b></span></p>
		</td>
		<td width="104" style="width:77.7pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.4pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<b style="mso-bidi-font-weight:normal">
		<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;">著者</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></b></span></p>
		</td>
	</tr>
	<%
	   if(arrAuthorInfo.size()>0)
	   {
	      for(int i=0;i<arrAuthorInfo.size();i++)
		  {
	%>
	<tr style="mso-yfti-irow:1;page-break-inside:avoid;height:24.45pt">
		<td width="98" style="width:73.75pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870"><st1:chsdate IsROCDate="False"
  IsLunarDate="False" Day="31" Month="10" Year="2008" w:st="on">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;">
		<%=arrAuthorDate.get(i)%></span></st1:chsdate><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></span></p>
		</td>
		<td width="59" style="width:44.55pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;">
		1.<%=i%><o:p></o:p></span></span></p>
		</td>
		<td width="427" style="width:320.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal"><span style="mso-bookmark:_Toc52455870">
		<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Century Gothic&quot;">
	 <% 
		if(i==0)
		{
			out.print("新增测试文档");
		}
		else
		{
			out.print("修改测试文档");
		}
	 %>
	</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></span></p>
		</td>
		<td width="104" style="width:77.7pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span style="font-family:宋体;mso-ascii-font-family:
  &quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Century Gothic&quot;">
		<%=arrAuthorInfo.get(i) %></span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></span></p>
		</td>
	</tr>
	<%
		}
	  }  
	  else
	  {
	%>
	<tr style="mso-yfti-irow:2;page-break-inside:avoid;height:24.45pt">
		<td width="98" style="width:73.75pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
		<td width="59" style="width:44.55pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
		<td width="427" style="width:320.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal"><span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
		<td width="104" style="width:77.7pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
	</tr>
	<%
		}
	%>
	<tr style="mso-yfti-irow:3;mso-yfti-lastrow:yes;page-break-inside:avoid;  height:24.45pt">
		<td width="98" style="width:73.75pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
		<td width="59" style="width:44.55pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
		<td width="427" style="width:320.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal"><span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
		<td width="104" style="width:77.7pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.45pt">
		<p class="MsoNormal" align="center" style="text-align:center">
		<span style="mso-bookmark:_Toc52455870">
		<span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p>
		&nbsp;</o:p></span></span></p>
		</td>
	</tr>
</table>
<h1 style="margin-top:1.0pt"><span style="mso-bookmark:_Toc52455870">
<a name="_Toc91473623"><![if !supportLists]>
<span lang="EN-US" style="mso-fareast-font-family:
&quot;Times New Roman&quot;;color:black"><span style="mso-list:Ignore">1<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:宋体;mso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">引言</span></a><span lang="EN-US" style="color:black"><o:p></o:p></span></span></h1>
<h2 style="margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt;margin-left:
28.9pt;text-indent:-28.9pt"><span style="mso-bookmark:_Toc52455870">
<a name="_Toc91473624"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:
16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;color:black">
<span style="mso-list:Ignore">1.1<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:黑体;mso-ascii-font-family:
&quot;Times New Roman&quot;;color:black">编写目的</span></a></span><span lang="EN-US" style="color:black"><o:p></o:p></span></h2>
<p class="MsoNormal" style="text-indent:1.0cm;mso-char-indent-count:2.7">
<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">《</span><span lang="EN-US" style="font-family:
&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">OB</span><span style="font-family:
宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;;
color:black">营帐</span><span style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
color:black"> </span>
<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">功能测试确认文档》是为测试人员对</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">OPENBOSS</span><span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">顺利地进行测试和确认而编写。</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
<p class="MsoNormal" style="text-indent:1.0cm;mso-char-indent-count:2.7">
<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">此功能测试文档的读者是</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">OB</span><span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">营帐系统项目管理人员、技术负责人、软件开发人员、软件测试人员、局方测试人员。</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></p>
<h2 style="margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt;margin-left:
28.9pt;text-indent:-28.9pt"><a name="_Toc91473625"></a><a name="_Toc52455871">
<span style="mso-bookmark:_Toc91473625"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;
color:black"><span style="mso-list:Ignore">1.2<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:黑体;mso-ascii-font-family:
&quot;Times New Roman&quot;;color:black">背景</span></span></a><span lang="EN-US" style="color:black"><o:p></o:p></span></h2>
<p class="MsoNormal" style="margin-left:21.0pt"><a name="_Toc91473626"></a>
<a name="_Toc52455873"><span style="mso-bookmark:_Toc91473626"><b>
<span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;">项目名称</span></b></span></a><span style="mso-bookmark:_Toc52455873"><span style="mso-bookmark:_Toc91473626"><span style="font-family:宋体;mso-ascii-font-family:
&quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">：</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><span style="mso-spacerun:yes">&nbsp;
</span>BOSS3.0<o:p></o:p></span></span></span></p>
<p class="MsoNormal" style="margin-left:21.0pt">
<span style="mso-bookmark:_Toc52455873"><span style="mso-bookmark:_Toc91473626">
<b>
<span style="font-family:宋体;mso-ascii-font-family:
&quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">
项目开发者</span></b><span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;">：亚信科技（中国）有限公司</span></span></span><span style="mso-bookmark:
_Toc52455873"><span style="mso-bookmark:_Toc91473626"><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></span></span></p>
<p class="MsoNormal" style="margin-left:21.0pt">
<span style="mso-bookmark:_Toc52455873"><span style="mso-bookmark:_Toc91473626">
<b>
<span style="font-family:宋体;mso-ascii-font-family:
&quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">
项目用户</span></b><span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;">：</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;
</span></span></span></span><span style="mso-bookmark:
_Toc52455873"><span style="mso-bookmark:_Toc91473626">
<span style="font-family:
宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">
移动通信责任有限公司</span></span></span><span style="mso-bookmark:_Toc52455873"><span style="mso-bookmark:_Toc91473626"><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></span></span></p>
<p class="MsoNormal" style="text-indent:21.0pt">
<span style="mso-bookmark:_Toc52455873"><span style="mso-bookmark:_Toc91473626">
<b>
<span style="font-family:宋体;mso-ascii-font-family:
&quot;Century Gothic&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">
软件产品</span></b><span style="font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;">：</span><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><span style="mso-spacerun:yes">&nbsp;
</span>AIOPENBOSS</span></span></span><a name="_Toc91473627"></a><span style="mso-bookmark:_Toc91473627"><span lang="EN-US" style="font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;"><o:p></o:p></span></span></p>
<h1 style="margin-left:21.55pt;text-indent:-21.55pt;line-height:150%;
page-break-before:auto"><span style="mso-bookmark:_Toc91473627"><![if !supportLists]>
<span lang="EN-US" style="mso-fareast-font-family:&quot;Times New Roman&quot;;color:black;
mso-bidi-font-weight:bold"><span style="mso-list:Ignore">2<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:宋体;mso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black;mso-bidi-font-weight:bold">测试环境</span><span lang="EN-US" style="color:black;
mso-bidi-font-weight:bold"><o:p></o:p></span></span></h1>
<h2 style="margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt;margin-left:
28.9pt;text-indent:-28.9pt"><span style="mso-bookmark:_Toc91473627">
<a name="_Toc98944223"></a><a name="_Toc97975421"></a><a name="_Toc97200731">
</a><a name="_Toc20800528"></a><a name="_Toc19179477">
<span style="mso-bookmark:_Toc20800528"><span style="mso-bookmark:_Toc97200731">
<span style="mso-bookmark:_Toc97975421"><span style="mso-bookmark:_Toc98944223">
<![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;
color:black"><span style="mso-list:Ignore">2.1<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:黑体;mso-ascii-font-family:
&quot;Times New Roman&quot;;color:black">硬件环境</span></span></span></span></span></a><span style="font-family:黑体;mso-ascii-font-family:
&quot;Times New Roman&quot;;color:black">：</span><span lang="EN-US" style="color:black"><o:p></o:p></span></span></h2>
<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">数据库主机：</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">IBM 
P690<o:p></o:p></span></span></p>
<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">应用服务器主机：</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">HP 
rp8420<o:p></o:p></span></span></p>
<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">客户端</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">PC</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">：</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
color:black">DELL D600</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">，安装</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">windows2000</span><span style="mso-bidi-font-size:10.5pt;
font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
&quot;Times New Roman&quot;;color:black">，内存</span></span><st1:chmetcnv TCSC="0"
NumberType="1" Negative="False" HasSpace="False" SourceValue="256" UnitName="m"
w:st="on"><span style="mso-bookmark:_Toc91473627"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
 color:black">256m</span></span></st1:chmetcnv><span style="mso-bookmark:_Toc91473627"><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">以上，若干台</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">网络：</span><span lang="EN-US" style="mso-bidi-font-size:
10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">10/100 
LAN<o:p></o:p></span></span></p>
<h2 style="margin-top:1.0pt;margin-right:0cm;margin-bottom:1.0pt;margin-left:
28.9pt;text-indent:-28.9pt"><span style="mso-bookmark:_Toc91473627">
<a name="_Toc98944224"></a><a name="_Toc97975422"></a><a name="_Toc97200732">
</a><a name="_Toc20800529"></a><a name="_Toc19179478">
<span style="mso-bookmark:_Toc20800529"><span style="mso-bookmark:_Toc97200732">
<span style="mso-bookmark:_Toc97975422"><span style="mso-bookmark:_Toc98944224">
<![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;
color:black"><span style="mso-list:Ignore">2.2<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:黑体;mso-ascii-font-family:
&quot;Times New Roman&quot;;color:black">软件环境</span></span></span></span></span></a><span style="font-family:黑体;mso-ascii-font-family:
&quot;Times New Roman&quot;;color:black">：</span><span lang="EN-US" style="color:black"><o:p></o:p></span></span></h2>
<table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" width="697" style="width:523.0pt;margin-left:40.4pt;border-collapse:collapse;border:none;
 mso-border-alt:solid windowtext .5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext">
	<tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:19.85pt">
		<td width="132" valign="top" style="width: 99.0pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; background: #A6A6A6; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">软件项</span><span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="193" valign="top" style="width: 145.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; background: #A6A6A6; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">SERVER</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">软件及版本</span><span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="276" valign="top" style="width: 207.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; background: #A6A6A6; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">CLIENT</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">软件及版本</span><span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="96" valign="top" style="width: 72.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; background: #A6A6A6; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.85pt">
		<p class="MsoNormal" style="margin-left:21.0pt">
		<span style="mso-bookmark:_Toc91473627">
		<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">备注</span><span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style="mso-yfti-irow:1;height:19.85pt">
		<td width="132" style="width:99.0pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent" style="text-indent:0cm;mso-char-indent-count:0">
		<span style="mso-bookmark:_Toc91473627">
		<span style="mso-bidi-font-size:10.5pt;
  font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;;color:black">数据库</span></span><span style="mso-bookmark:
  _Toc91473627"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:
  &quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="193" style="width:145.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">ORACLE 9.i<o:p></o:p></span></span></p>
		</td>
		<td width="276" valign="top" style="width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent" style="text-indent:0cm;mso-char-indent-count:0">
		<span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black">
		Windows2000</span><span style="mso-bidi-font-size:10.5pt;
  font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;;color:black">、</span><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">WindowsXP </span>
		<span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">为主</span><span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="96" style="width:72.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormal" style="margin-left:21.0pt">
		<span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
	</tr>
	<tr style="mso-yfti-irow:2;height:19.85pt">
		<td width="132" style="width:99.0pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent" style="text-indent:0cm;mso-char-indent-count:0">
		<span style="mso-bookmark:_Toc91473627">
		<span style="mso-bidi-font-size:10.5pt;
  font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;;color:black">主机操作系统</span></span><span style="mso-bookmark:
  _Toc91473627"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:
  &quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="193" style="width:145.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">HP UNIX<o:p></o:p></span></span></p>
		</td>
		<td width="276" valign="top" style="width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
		<td width="96" style="width:72.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormal" style="margin-left:21.0pt">
		<span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
	</tr>
	<tr style="mso-yfti-irow:3;height:19.85pt">
		<td width="132" style="width:99.0pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent" style="text-indent:0cm;mso-char-indent-count:0">
		<span style="mso-bookmark:_Toc91473627">
		<span style="mso-bidi-font-size:10.5pt;
  font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;;color:black">中间件</span></span><span style="mso-bookmark:
  _Toc91473627"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:
  &quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="193" style="width:145.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">BEA TUXEDO 8.0<o:p></o:p></span></span></p>
		</td>
		<td width="276" valign="top" style="width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
		<td width="96" style="width:72.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormal" style="margin-left:21.0pt">
		<span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
	</tr>
	<tr style="mso-yfti-irow:4;mso-yfti-lastrow:yes;height:19.85pt">
		<td width="132" style="width:99.0pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent" style="text-indent:0cm;mso-char-indent-count:0">
		<span style="mso-bookmark:_Toc91473627">
		<span style="mso-bidi-font-size:10.5pt;
  font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;mso-hansi-font-family:
  &quot;Times New Roman&quot;;color:black">编译器</span></span><span style="mso-bookmark:
  _Toc91473627"><span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:
  &quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></span></p>
		</td>
		<td width="193" style="width:145.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black">C++BUILDER</span><span style="mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:&quot;Century Gothic&quot;;
  mso-hansi-font-family:&quot;Times New Roman&quot;;color:black">、</span><span lang="EN-US" style="mso-bidi-font-size:
  10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;color:black"> 
		aCC<o:p></o:p></span></span></p>
		</td>
		<td width="276" valign="top" style="width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormalIndent"><span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
		<td width="96" style="width:72.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:19.85pt">
		<p class="MsoNormal" style="margin-left:21.0pt">
		<span style="mso-bookmark:_Toc91473627">
		<span lang="EN-US" style="mso-bidi-font-size:10.5pt;font-family:&quot;Century Gothic&quot;,&quot;sans-serif&quot;;
  color:black"><o:p>&nbsp;</o:p></span></span></p>
		</td>
	</tr>
</table>

<%    //获取原始需求内容、需求的解决方案、变更确认信息、测试确认中的注意事项
	  	String ORI_DEMAND_INFO="";
	    String DEMAND_SOLUTION="";
	    String DEMAND_CHG_INFO="";
	    String REMARK1="";
	    String REMARK2="";
	    String REMARK3="";
	    String REMARK4="";
	    String REMARK5="";
	    String REMARK6="";
	   if(sRMId!=null)
	   { 
	      Vector vDemand =dataBean.getDemandInfo(sSubRMId,iRMId);
	      if(vDemand.size()>0)
	      {
	        HashMap hash = (HashMap) vDemand.get(0);
	        ORI_DEMAND_INFO=(String)hash.get("ORI_DEMAND_INFO");
	        DEMAND_SOLUTION=(String)hash.get("DEMAND_SOLUTION");
	        DEMAND_CHG_INFO=(String)hash.get("DEMAND_CHG_INFO");
	        REMARK1=(String)hash.get("REMARK1");
	        REMARK2=(String)hash.get("REMARK2");
	        REMARK3=(String)hash.get("REMARK3");
	        REMARK4=(String)hash.get("REMARK4");
	        REMARK5=(String)hash.get("REMARK5");
			REMARK6=(String)hash.get("REMARK6");
			
	      }
	    }
    
%>

<h1 style="line-height:150%"><span style="mso-bookmark:_Toc91473627"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:22.0pt;line-height:150%;font-family:宋体;
mso-bidi-font-family:宋体;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">3<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="mso-bidi-font-size:22.0pt;
line-height:150%;font-family:宋体;color:black;mso-bidi-font-weight:bold">原始需求<span lang="EN-US"><o:p></o:p></span></span></span></h1>

<p class="MsoNormal"><span style="mso-bookmark:_Toc91473627">
<%
  if(ORI_DEMAND_INFO!=null)
     out.print(ORI_DEMAND_INFO);
%>
</span></p>

<h1 style="line-height:150%"><span style="mso-bookmark:_Toc91473627"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:22.0pt;line-height:150%;font-family:宋体;
mso-bidi-font-family:宋体;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">4<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="mso-bidi-font-size:22.0pt;
line-height:150%;font-family:宋体;color:black;mso-bidi-font-weight:bold">测试分析<span lang="EN-US"><o:p></o:p></span></span></span></h1>

<p class="MsoNormal"><span style="mso-bookmark:_Toc91473627">
<%
  if(REMARK6!=null)
    out.print(REMARK6);
%>
</span></p>


<h1 style="line-height:150%"><span style="mso-bookmark:_Toc91473627"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:22.0pt;line-height:150%;font-family:宋体;
mso-bidi-font-family:宋体;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">5<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="mso-bidi-font-size:22.0pt;
line-height:150%;font-family:宋体;color:black;mso-bidi-font-weight:bold">解决方案<span lang="EN-US"><o:p></o:p></span></span></span></h1>

<p class="MsoNormal"><span style="mso-bookmark:_Toc91473627">
<%
  if(DEMAND_SOLUTION!=null)
    out.print(DEMAND_SOLUTION);
%>
</span></p>



<%
	String sAttachmentSeqname="";
	String sOldName="";
	int ishapeid=4;
	if(iCountAttachment>0)
      {
%>
<p><span style="MsoNormal"><b style="mso-bidi-font-weight:normal">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">附件：</span></b></span></p>

<%       	
      	
      	for(int m=vAttachment.size()-1;m>=0;m--)
      	{
      		ishapeid=ishapeid+1;
      		HashMap Attachmenthash = (HashMap) vAttachment.get(m);
      		sAttachmentSeqname=(String)Attachmenthash.get("ATTACHMENT_NAME");
      		sOldName=(String)Attachmenthash.get("OLD_NAME");

%>

<p><span style="MsoNormal">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black"><a href="<%=hosturl%>AICMS/upload/solution/<%=sAttachmentSeqname%>">
<%out.print(sOldName); %><%//out.print("<br>Moniker="+hosturl+"AICMS/upload/solution/"+sAttachmentSeqname); %></a></span></span></p>
<%
	      	}
      }
%>


<h1 style="line-height:150%"><span style="mso-bookmark:_Toc91473627"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:22.0pt;line-height:150%;font-family:宋体;
mso-bidi-font-family:宋体;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">6<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="mso-bidi-font-size:22.0pt;
line-height:150%;font-family:宋体;color:black;mso-bidi-font-weight:bold">变更确认信息<span lang="EN-US"><o:p></o:p></span></span></span></h1>

<p class="MsoNormal"><span style="mso-bookmark:_Toc91473627">
<%
  if(DEMAND_CHG_INFO!=null)
   out.print(DEMAND_CHG_INFO);
%>
</span></p>


<h1 style="line-height:150%"><span style="mso-bookmark:_Toc91473627"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:22.0pt;line-height:150%;font-family:宋体;
mso-bidi-font-family:宋体;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">7<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="mso-bidi-font-size:22.0pt;
line-height:150%;font-family:宋体;color:black;mso-bidi-font-weight:bold">测试确认<span lang="EN-US"><o:p></o:p></span></span></span></h1>


<h2 style="line-height:150%"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:16.0pt;line-height:150%;mso-fareast-font-family:&quot;Times New Roman&quot;;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">7.1
<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>
<span style="font-family:黑体;mso-ascii-font-family:&quot;Times New Roman&quot;;color:black;mso-bidi-font-weight:bold">注意事项</span>
<span lang="EN-US" style="color:black;mso-bidi-font-weight:bold"><o:p></o:p></span></h2>

<p class="MsoNormalleft" style="margin-left:42.0pt;mso-para-margin-left:4.0gd;line-height:150%"><b style="mso-bidi-font-weight:normal">
<span style="font-size: 9.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: Verdana; color: black; background: silver; mso-highlight: silver">[注释一] 功能适用：</span></b></p>

<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;line-height:150%">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">
 <%
      if(REMARK1!=null)
      {
	     //REMARK1=REMARK1.replaceAll("</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">","<br>"); 
	     REMARK1=REMARK1.replaceAll("\n","<br>");
	     out.print(REMARK1);
	  }
 %>
</span></p>

<p class="MsoNormalleft" style="margin-left:42.0pt;mso-para-margin-left:4.0gd;line-height:150%"><b style="mso-bidi-font-weight:normal">
<span style="font-size: 9.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: Verdana; color: black; background: silver; mso-highlight: silver">[注释二] 需求单号：</span></b></p>

<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;line-height:150%">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">
<%
	if(REMARK2!=null)
	{
	   //REMARK2=REMARK2.replaceAll("</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">","<br>"); 
	   REMARK2=REMARK2.replaceAll("\n","<br>");
	   out.print(REMARK2);
	}
%>
</span></p>


<p class="MsoNormalleft" style="margin-left:42.0pt;mso-para-margin-left:4.0gd;line-height:150%"><b style="mso-bidi-font-weight:normal">
<span style="font-size: 9.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: Verdana; color: black; background: silver; mso-highlight: silver">[注释三] 涉及修改：</span></b></p>

<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;text-indent:0cm;line-height:150%;mso-list:l11 level1 lfo3;tab-stops:list 99.75pt 117.75pt">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">
<%
      if(REMARK3!=null)
	  {
	     //REMARK3=REMARK3.replaceAll("</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">","<br>"); 
	     REMARK3=REMARK3.replaceAll("\n","<br>");
	     out.print(REMARK3);
	  }
%>
</span></p>


<%
	String sAttachmentSeqname1="";
	String sOldName1="";
	if(iCountAttachment1>0)
      {
%>
<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;text-indent:0cm;line-height:150%;mso-list:l11 level1 lfo3;tab-stops:list 99.75pt 117.75pt">
<b style="mso-bidi-font-weight:normal">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">附件：</span></b></p>

<%for(int m=vAttachment1.size()-1;m>=0;m--) 
      	{ 
      		HashMap Attachmenthash1 = (HashMap) vAttachment1.get(m); 
      		sAttachmentSeqname1=(String)Attachmenthash1.get("ATTACHMENT_NAME"); 
      		sOldName1=(String)Attachmenthash1.get("OLD_NAME"); 
%>
<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;text-indent:0cm;line-height:150%;mso-list:l11 level1 lfo3;tab-stops:list 99.75pt 117.75pt">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green"><a href="<%=hosturl%>AICMS/upload/solution/<%=sAttachmentSeqname1%>">

<%out.print(sOldName1); %><%//out.print("<br>Moniker="+hosturl+"AICMS/upload/solution/"+sAttachmentSeqname); %></a></span></p>
<%
	      	}
      }
%>



<p class="MsoNormalleft" style="margin-left:42.0pt;mso-para-margin-left:4.0gd;line-height:150%"><b style="mso-bidi-font-weight:normal">
<span style="font-size: 9.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: Verdana; color: black; background: silver; mso-highlight: silver">[注释四] 测试结论：</span></b></p>

<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;text-indent:0cm;line-height:150%;mso-list:l11 level1 lfo3;tab-stops:list 99.75pt 117.75pt">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:blue">
<%
      if(REMARK4!=null)
      {
	     //REMARK4=REMARK4.replaceAll("</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">","<br>"); 
	     REMARK4=REMARK4.replaceAll("\n","<br>");
	     out.print(REMARK4);
	  }
%>
</span></p>


<p class="MsoNormalleft" style="margin-left:42.0pt;mso-para-margin-left:4.0gd;line-height:150%"><b style="mso-bidi-font-weight:normal">
<span style="font-size: 9.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: Verdana; color: black; background: silver; mso-highlight: silver">[注释五] 备注|特别提醒：</span></b></p>

<p class="MsoNormalleft" style="margin-top:0cm;margin-right:84.0pt;margin-bottom:0cm;margin-left:77.95pt;margin-bottom:.0001pt;mso-para-margin-top:0cm;mso-para-margin-right:8.0gd;mso-para-margin-bottom:0cm;mso-para-margin-left:77.95pt;mso-para-margin-bottom:.0001pt;text-indent:0cm;line-height:150%;mso-list:l11 level1 lfo3;tab-stops:list 99.75pt 117.75pt">
<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:red">
<%
      if(REMARK5!=null)
      {
	     //REMARK5=REMARK5.replaceAll("</span></p><p class=\"MsoNormal\" style=\"line-height: 120%; margin-left: 77.95pt; margin-right: 84.0pt; margin-top: 0cm; margin-bottom: .0001pt\"><span style=\"font-size: 9.0pt; line-height: 120%; font-family: 宋体; color: black\">","<br>"); 
	     REMARK5=REMARK5.replaceAll("\n","<br>");
	     out.print(REMARK5);
	  }
%>
</span></p>	


<h2 style="line-height:150%"><![if !supportLists]>
<span lang="EN-US" style="mso-bidi-font-size:16.0pt;line-height:150%;mso-fareast-font-family:&quot;Times New Roman&quot;;color:black;mso-bidi-font-weight:bold">
<span style="mso-list:Ignore">7.2
<span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]> <span style="font-family:黑体;mso-ascii-font-family:&quot;Times New Roman&quot;;color:black;mso-bidi-font-weight:bold">测试案例</span>
</h2>


<%
    //获取模块名
    if(sRMId!=null)  //判断需求跟故障编号不为空的情况
	  { 
	   Vector vModuleName=dataBean.getModuleNameInfo(sSubRMId,iRMId);
       for(int i=0;i<vModuleName.size();i++)
       {
          HashMap map =(HashMap) vModuleName.get(i);
          String sName=(String) map.get("MODULE_NAME");
		  String sModuleId=(String) map.get("MODULE_ID");
		  if(sName==null) sName="";
		  if(sModuleId==null) sModuleId="";
%>

<h3 style="margin-top:13.0pt;text-align:justify;text-justify:inter-ideograph;line-height:173%"><![if !supportLists]>
<span lang="EN-US" style="font-size:14.0pt;line-height:173%;mso-fareast-font-family:&quot;Times New Roman&quot;">
<span style="mso-list:Ignore">7.2.<%=(i+1)%><span style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;</span></span></span><![endif]>
<span lang="EN-US">CASE<%=(i+1)%>-</span>
<span style="font-family:宋体;mso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;"><% if(sName!=null) out.print(sName);%></span></h3>



<div align="center">
	<table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="832" style="margin-left:-31.4pt;border-collapse:collapse;mso-table-layout-alt:fixed; mso-padding-alt:0cm 5.4pt 0cm 5.4pt">
		<tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:26.25pt">
			<td width="832" colspan="2" style="width: 22.0cm; border: none; border-bottom: solid windowtext 1.0pt; mso-border-bottom-alt: solid windowtext .5pt; background: silver; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.65pt">
			<p class="MsoNormal" style="mso-pagination:widow-orphan"><b>
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;mso-bidi-font-family:Arial;color:black;mso-font-kerning:0pt">测试验证步骤</span>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black;mso-font-kerning:0pt"><o:p></o:p></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:2;mso-yfti-lastrow:yes;height:15.15pt">
			<td width="832" colspan="2" style="width:22.0cm;border-top:none;border-left:solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;mso-border-left-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.15pt">
			

<%
	//获取某个模块的所有CASE
	Vector vCaseAllInfo=dataBean.getModuleCaseInfo(sSubRMId,iRMId,sModuleId);
	int k=0;
	if(vCaseAllInfo.size()>0)
	{
		for(int j=vCaseAllInfo.size()-1;j>=0;j--)
        {
			k=k+1;
            HashMap map1 =(HashMap) vCaseAllInfo.get(j);
			String CASE_SEQ=(String) map1.get("CASE_SEQ");
			String CASE_NAME=(String) map1.get("CASE_NAME");
			String EXP_RESULT=(String ) map1.get("EXP_RESULT");
			String CASE_ENV=(String ) map1.get("CASE_ENV");
			String CASE_DATA_PREPARE=(String ) map1.get("CASE_DATA_PREPARE");
			String CASE_CONCLUSION=(String ) map1.get("CASE_CONCLUSION");
			String CASE_ID=(String ) map1.get("CASE_ID");
			String CASE_DESC=(String ) map1.get("CASE_DESC");
			String CLI_INFO_ID_NAME=(String ) map1.get("CLI_INFO_ID_NAME");
			String SVR_INFO_ID_NAME=(String ) map1.get("SVR_INFO_ID_NAME");
			String PROGRAM_NAME=(String ) map1.get("PROGRAM_NAME");
			String CASE_TYPE_NAME=(String ) map1.get("CASE_TYPE_NAME");
			if(CASE_NAME==null)CASE_NAME="";
			if(EXP_RESULT==null)EXP_RESULT="";
			if(CASE_DATA_PREPARE==null)CASE_DATA_PREPARE="";
			if(CASE_CONCLUSION==null)CASE_CONCLUSION="";
			if(CASE_ID==null)CASE_ID="";
			if(CASE_DESC==null)CASE_DESC="";
			if(CLI_INFO_ID_NAME==null)CLI_INFO_ID_NAME="";
			if(SVR_INFO_ID_NAME==null)SVR_INFO_ID_NAME="";
			if(PROGRAM_NAME==null)PROGRAM_NAME="";
			if(CASE_TYPE_NAME==null)CASE_TYPE_NAME="";
			if(CASE_ENV==null)CASE_ENV="";
		 %>

			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:Arial;mso-bidi-font-family:Arial">测试案例<%out.print(k+"&nbsp;("+CASE_ID+")&nbsp;:&nbsp;"); %></span></b>
			<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">			
			<%
				CASE_NAME=CASE_NAME.replaceAll("\n","<br>");
				out.print(CASE_NAME);
			%>
			<o:p></o:p></p>
			
			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family: Arial;mso-bidi-font-family:Arial;mso-font-kerning:0pt;color:black">案例描述：</span></b>
			<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">
			<%
				CASE_DESC=CASE_DESC.replaceAll("\n","<br>");
				out.print(CASE_DESC); 
			%></span><o:p></o:p></p>

			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family: Arial;mso-bidi-font-family:Arial;mso-font-kerning:0pt;color:black">期望结果:</span></b>
			<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">
			<%
				EXP_RESULT=EXP_RESULT.replaceAll("\n","<br>");
				out.print(EXP_RESULT); 
			%>
			</span><o:p></o:p></p>
			
			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:  Arial;mso-bidi-font-family:Arial;mso-font-kerning:0pt;color:black">测试环境:</span></b>
			<p class="MsoNormalleft">
			<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">环境：
			<%
				CASE_ENV=CASE_ENV.replaceAll("\n","<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				out.print(CASE_ENV); 
			%>
			</span></p>
			<%
				if(!CLI_INFO_ID_NAME.equals(""))
				{
			%>
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">前台版本：
			<%
					CLI_INFO_ID_NAME=CLI_INFO_ID_NAME.replaceAll("\n","<br>");
					out.print(CLI_INFO_ID_NAME+"</span></p>");
				} 
			%>
			<%
				if(!SVR_INFO_ID_NAME.equals(""))
				{
			%>
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">后台版本：
			<%
					SVR_INFO_ID_NAME=SVR_INFO_ID_NAME.replaceAll("\n","<br>");
					out.print(SVR_INFO_ID_NAME+"</span></p>"); 
				}
			%>
			<%
				if(!PROGRAM_NAME.equals(""))
				{
			%>
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">涉及接口/进程：
			<%
					PROGRAM_NAME=PROGRAM_NAME.replaceAll("\n","<br>");
					out.print(PROGRAM_NAME+"</span></p>");
				} 
			%>
			<o:p></o:p></p>
			
			
			<%
				if(!CASE_DATA_PREPARE.equals(""))
				{
			%>
			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:  Arial;mso-bidi-font-family:Arial;mso-font-kerning:0pt;color:black">数据准备:</span></b>
			<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:green">
			<%
				CASE_DATA_PREPARE=CASE_DATA_PREPARE.replaceAll("\n","<br>");
				out.print(CASE_DATA_PREPARE); 
				}
			%>
			</span><o:p></o:p></p>
						
			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:  Arial;mso-bidi-font-family:Arial;mso-font-kerning:0pt;color:black">测试步骤及验证：</span>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-font-kerning:0pt"><o:p></o:p></span></b></p>
			<%
			     //获取一个case下所有的步骤
				 Vector vStepAllInfo=dataBean.getCaseStepInfo(CASE_SEQ);
				 if(vStepAllInfo.size()>0)
				 {
				     int m1=0;
				     for(int m=vStepAllInfo.size()-1;m>=0;m--)
             		{
                 		m1=m1+1;
                 		HashMap map2 =(HashMap) vStepAllInfo.get(m);
						String PROCESS_ID=(String) map2.get("PROCESS_ID");
						String PROCESS_DESC=(String) map2.get("PROCESS_DESC");
						String STEP_EXP_RESULT=(String) map2.get("EXP_RESULT");
						String CASE_DATA_CHECK=(String) map2.get("CASE_DATA_CHECK");
						String STEP_PROCESS_ID=(String) map2.get("PROCESS_ID");
						String REAL_RESULT=(String) map2.get("REAL_RESULT");
						String CASE_LOG=(String) map2.get("CASE_LOG");
						String IN_DUMP=(String) map2.get("IN_DUMP");
						String OUT_DUMP=(String) map2.get("OUT_DUMP");
						String ACCESSORY=(String) map2.get("ACCESSORY");
						
						if(PROCESS_ID==null) PROCESS_ID="";
						if(PROCESS_DESC==null) PROCESS_DESC="";
						if(STEP_EXP_RESULT==null) STEP_EXP_RESULT="";
						if(STEP_PROCESS_ID==null) STEP_PROCESS_ID="";
						if(REAL_RESULT==null) REAL_RESULT="";
						if(CASE_LOG==null) CASE_LOG="";
						if(IN_DUMP==null) IN_DUMP="";
						if(OUT_DUMP==null) OUT_DUMP="";
						if(ACCESSORY==null) ACCESSORY="";
						if(CASE_DATA_CHECK==null) CASE_DATA_CHECK="";
			%>
			
			<p class="MsoNormalleft" style="margin-left:18.0pt;text-indent:-18.0pt;mso-list:  l6 level1 lfo6;tab-stops:list 18.0pt"><![if !supportLists]>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">
			<%
				PROCESS_DESC=PROCESS_DESC.replaceAll("\n","<br>");
				out.print(m1+"."+PROCESS_DESC);
				if(!STEP_EXP_RESULT.equals(""))
				{
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">预期结果：</b>
			<%
					STEP_EXP_RESULT=STEP_EXP_RESULT.replaceAll("\n","<br>");
					out.print("&nbsp;&nbsp;"+STEP_EXP_RESULT+"</span></p>");
				}
				if(!REAL_RESULT.equals(""))
				{
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">实际结果：</b>
			<%
					REAL_RESULT=REAL_RESULT.replaceAll("\n","<br>");
					out.print("&nbsp;&nbsp;"+REAL_RESULT+"</span></p>");
				}
				if(!IN_DUMP.equals(""))
				{
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">DUMP-IN：</b>
			<%
					IN_DUMP=IN_DUMP.replaceAll("\n","<br>");
					out.print("&nbsp;&nbsp;"+IN_DUMP+"</span></p>");
				}
				if(!OUT_DUMP.equals(""))
				{
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">DUMP-OUT：</b>
			<%
					OUT_DUMP=OUT_DUMP.replaceAll("\n","<br>");
					out.print("&nbsp;&nbsp;"+OUT_DUMP+"</span></p>");
				}
				if(!CASE_DATA_CHECK.equals(""))
				{
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">数据检查：</b>
			<%
					CASE_DATA_CHECK=CASE_DATA_CHECK.replaceAll("\n","<br>");
					out.print("&nbsp;&nbsp;"+CASE_DATA_CHECK+"</span></p>");
				}
				if(!CASE_LOG.equals(""))
				{
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">后台日志：</b>
			<%
					CASE_LOG=CASE_LOG.replaceAll("\n","<br>");
					out.print("&nbsp;&nbsp;"+CASE_LOG+"</span></p>");
				}
				if(!ACCESSORY.equals(""))   //输出附件
				{
					StringBuffer url=request.getRequestURL();  //获取当前页面URL地址
                    String url1=url.toString();
                    url1=url1.substring(0,url1.indexOf("createWord"));
			%>
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:  Arial;mso-font-kerning:0pt">
			<p class="MsoNormalleft"><span style="font-size:9.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:Verdana;color:black">&nbsp;&nbsp;<b style="mso-bidi-font-weight:normal">附件：</b>
			<p class="MsoNormalleft"><img src="<%=url1%>/upload/<%=ACCESSORY%>"></p>
			<%
				}
			%>
			</span></span><![endif]>
			<%
				}
				}
			%>
			<p class="MsoNormalleft"><b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:  Arial;mso-bidi-font-family:Arial;mso-font-kerning:0pt">结论：</span></b>

  			<b style="mso-bidi-font-weight:normal">
			<span style="font-size:9.0pt;font-family:宋体;mso-ascii-font-family:Arial;mso-hansi-font-family:  Arial;mso-bidi-font-family:Arial;color:#993366;mso-font-kerning:0pt">
			<%
				CASE_CONCLUSION=CASE_CONCLUSION.replaceAll("\n","<br>");
				out.print(CASE_CONCLUSION);
			%>
			</span>
			<span lang="EN-US" style="font-size:9.0pt;  font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#993366;mso-font-kerning:0pt"><o:p></o:p></span></b></p>
			
			<p class="MsoNormalleft">
			<span lang="EN-US" style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;; color:black;mso-font-kerning:0pt">
			------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			<o:p></o:p></span></p>
  
			</td>
		</tr>
			<%
				}
				}
			%>
	</table>
</div>
<%
       }
    }		  
%>

<p class="MsoNormalleft"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>

</body>

</html>
