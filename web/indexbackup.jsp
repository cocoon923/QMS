<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<title>主页</title>
<script language="JavaScript">
<!--
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

function FP_goToURL(url) {//v1.0
 window.location=url;
}
// -->
</script>
</head>
<%
    String sUserName=(String)session.getValue("OpName");  //获取登陆名称
    Date dDate=new Date();   //获取系统时间
    Calendar calendar = new GregorianCalendar();
    java.util.Date trialTime = new java.util.Date();
    calendar.setTime(trialTime);
    int year = calendar.get(Calendar.YEAR);
    int month = calendar.get(Calendar.MONTH);
    int day = calendar.get(Calendar.DAY_OF_MONTH);
    int hour = calendar.get(Calendar.HOUR_OF_DAY);
    int minute = calendar.get(Calendar.MINUTE);
    int second = calendar.get( Calendar.SECOND); 
    
    //session.getValue("admin");
%>

<body bgcolor="#E8F9F4" onload="FP_preloadImgs(/*url*/'images/button3.jpg', /*url*/'images/button4.jpg', /*url*/'主页/button6.jpg', /*url*/'images/button7.jpg', /*url*/'images/button9.jpg', /*url*/'images/buttonA.jpg', /*url*/'images/button10.jpg', /*url*/'images/button11.jpg')" background="images/130.jpg" style="background-attachment: fixed">

<div style="position: absolute; width: 127px; height: 568px; z-index: 3; left: 10px; top: 13px; border-right-style: solid; border-right-width: 1px; padding-right: 4px" id="layer3">
&nbsp;<p>&nbsp;<img border="0" id="img9" src="images/button2.jpg" height="20" width="100" alt="用例管理" onmouseover="FP_swapImg(1,0,/*id*/'img9',/*url*/'images/button3.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img9',/*url*/'images/button2.jpg')" onmousedown="FP_swapImg(1,0,/*id*/'img9',/*url*/'images/button4.jpg')" onmouseup="FP_swapImg(0,0,/*id*/'img9',/*url*/'images/button3.jpg')" fp-style="fp-btn: Embossed Rectangle 5; fp-font: 微软雅黑" fp-title="用例管理" onclick="FP_goToURL(/*href*/'用例管理-空.htm')"></p>
	<p>&nbsp;<img border="0" id="img10" src="images/button5.jpg" height="20" width="100" alt="用例执行" onmouseover="FP_swapImg(1,0,/*id*/'img10',/*url*/'images/button6.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img10',/*url*/'images/button5.jpg')" onmousedown="FP_swapImg(1,0,/*id*/'img10',/*url*/'images/button7.jpg')" onmouseup="FP_swapImg(0,0,/*id*/'img10',/*url*/'images/button6.jpg')" fp-style="fp-btn: Embossed Rectangle 5; fp-font: 微软雅黑" fp-title="用例执行" onclick="FP_goToURL(/*href*/'用例执行-选择用例1.htm')"></p>
	<p>&nbsp;<img border="0" id="img11" src="images/button8.jpg" height="20" width="100" alt="查    询" fp-style="fp-btn: Embossed Rectangle 5; fp-font: 微软雅黑" fp-title="查    询" onmouseover="FP_swapImg(1,0,/*id*/'img11',/*url*/'images/button9.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img11',/*url*/'images/button8.jpg')" onmousedown="FP_swapImg(1,0,/*id*/'img11',/*url*/'images/buttonA.jpg')" onmouseup="FP_swapImg(0,0,/*id*/'img11',/*url*/'images/button9.jpg')" onclick="FP_goToURL(/*href*/'查询统计.htm')"></p>
	<p>&nbsp;<img border="0" id="img12" src="images/buttonF.jpg" height="20" width="100" alt="统    计" fp-style="fp-btn: Embossed Rectangle 5; fp-font: 微软雅黑" fp-title="统    计" onmouseover="FP_swapImg(1,0,/*id*/'img12',/*url*/'images/button10.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img12',/*url*/'images/buttonF.jpg')" onmousedown="FP_swapImg(1,0,/*id*/'img12',/*url*/'images/button11.jpg')" onmouseup="FP_swapImg(0,0,/*id*/'img12',/*url*/'images/button10.jpg')" onclick="FP_goToURL(/*href*/'查询统计-统计.htm')"></div>

<p>　</p>
<div style="position: absolute; width: 771px; height: 53px; z-index: 1; left: 138px; top: 13px; border-bottom-style: solid; border-bottom-width: 1px; padding-bottom: 1px" id="layer1">
<p><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp; 登录者：<%=sUserName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
系统时间：<!--webbot bot="Timestamp" S-Type="REGENERATED" S-Format="%Y-%m-%d %H:%M:%S" startspan --><%out.print(year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second);%><!--webbot bot="Timestamp" endspan i-checksum="25980" --> </font></div>
<div style="position: absolute; width: 772px; height: 389px; z-index: 2; left: 168px; top: 67px" id="layer2">
　<p><b><font face="微软雅黑">未完成需求：</font></b></p>
	<table border="1" width="774" cellspacing="1" style="background-color: #FFFFFF">
		<tr>
			<td width="32" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">选中</font></b></td>
			<td width="38" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">序号</font></b></td>
			<td width="75" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">需求id</font></b></td>
			<td width="361" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">需求名称</font></b></td>
			<td width="64" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">需求状态</font></b></td>
			<td align="center" width="75" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">case编号</font></b></td>
			<td align="center" width="91" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">case执行状态</font></b></td>
		</tr>
		<tr>
			<td width="32" height="10" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R6" tabindex="1"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(1)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19790">
			<strong><font size="2">19790</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19790">
			<font size="2">关于定制终端手机卖场模式支撑的补充需求</font></a></td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">开发中</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">编写未完成</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未执行</font></td>
		</tr>
		<tr>
			<td width="32" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R2" tabindex="2"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(2)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19808">
			<strong><font size="2">19808</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19808">
			<font size="2">关于广西2008100700565漫游产品受理优化的需求[本地开发]</font></a></td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">开发中</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未编写</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未执行</font></td>
		</tr>
		<tr>
			<td width="32" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R3" tabindex="3"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(3)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19878">
			<strong><font size="2">19878</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19878">
			<font size="2">关于广西2008101600589实现随E行卡销售的需求（阶段一）</font></a></td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font color="#ffcc00" size="2">再处理中</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font size="2" color="#660000">编写完成</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#ffcc00" size="2">执行中</font></td>
		</tr>
		<tr>
			<td width="32" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R4" tabindex="4"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(4)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19916">
			<strong><font size="2">19916</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=19916">
			<font size="2">BOSS3.0项目关于促销品管理的补充需求三</font></a></td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font color="#ffff00" size="2">测试中</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未编写</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未执行</font></td>
		</tr>
		<tr>
			<td width="32" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R5" tabindex="5"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(5)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=20017">
			<strong><font size="2">20017</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=20017">
			<font size="2">研发自优化需求-辽宁欠费风险控制，下周期生，失效问题。</font></a></td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">开发中</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未编写</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2">未执行</font></td>
		</tr>
	</table>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</p>
	<p><b><font face="微软雅黑">未关闭故障：</font></b></p>
	<table border="1" width="774" cellspacing="1" style="background-color: #FFFFFF">
		<tr>
			<td width="32" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">选中</font></b></td>
			<td width="38" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">序号</font></b></td>
			<td width="75" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">故障id</font></b></td>
			<td width="361" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">需求名称</font></b></td>
			<td width="64" align="center" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">故障状态</font></b></td>
			<td align="center" width="75" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">case编号</font></b></td>
			<td align="center" width="91" style="background-color: #E8F9F4"><b>
			<font face="微软雅黑" size="2">case执行状态</font></b></td>
		</tr>
		<tr>
			<td width="32" height="10" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R7" tabindex="1"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(1)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=12184">
			<strong><font size="2" face="宋体">12184</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<table border="0" cellpadding="0" cellspacing="0" width="200" style="border-collapse:
 collapse;width:150pt">
				<colgroup>
					<col width="200" style="width: 150pt">
				</colgroup>
				<tr height="19" style="height:14.25pt">
					<td height="19" width="200" style="height: 14.25pt; width: 150pt; color: blue; text-decoration: underline; text-underline-style: single; text-align: left; font-size: 12.0pt; font-weight: 400; font-style: normal; font-family: 宋体; vertical-align: middle; white-space: nowrap; border: medium none; padding: 0px">
					<a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=12184">
					<font size="2">活动受理费用计算不正确</font></a></td>
				</tr>
			</table>
			</td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font size="2" face="宋体">待QA测试</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2" face="宋体">编写未完成</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2" face="宋体">未执行</font></td>
		</tr>
		<tr>
			<td width="32" style="background-color: #E8F9F4">
			<input type="radio" value="V1" name="R8" tabindex="2"></td>
			<td width="38" align="center" style="background-color: #E8F9F4">
			<font size="2">(2)</font></td>
			<td width="75" style="background-color: #E8F9F4">
			<a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=12207">
			<strong><font size="2" face="宋体">12207</font></strong></a></td>
			<td width="361" style="background-color: #E8F9F4">
			<table border="0" cellpadding="0" cellspacing="0" width="250" style="border-collapse:
 collapse;width:188pt">
				<colgroup>
					<col width="250" style="width: 188pt">
				</colgroup>
				<tr height="19" style="height:14.25pt">
					<td height="19" width="250" style="height: 14.25pt; width: 188pt; color: blue; text-decoration: underline; text-underline-style: single; text-align: left; font-size: 12.0pt; font-weight: 400; font-style: normal; font-family: 宋体; vertical-align: middle; white-space: nowrap; border: medium none; padding: 0px">
					<a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=12207">
					<font size="2">转品牌的时候userinfochg core</font></a></td>
				</tr>
			</table>
			</td>
			<td width="64" align="center" style="background-color: #E8F9F4">
			<font color="#009900" size="2" face="宋体">待QA诊断</font></td>
			<td width="75" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2" face="宋体">未编写</font></td>
			<td width="91" align="center" style="background-color: #E8F9F4">
			<font color="#660000" size="2" face="宋体">未执行</font></td>
		</tr>
		</table>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="编写case" name="B3" tabindex="6" style="font-family: 微软雅黑" onclick="FP_goToURL(/*href*/'用例管理.htm')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="编辑case" name="B4" tabindex="7" style="font-family: 微软雅黑" onclick="FP_goToURL(/*href*/'用例管理.htm')">&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="生成测试文档" name="B5" tabindex="8" style="font-family: 微软雅黑"></p>
	<p>　</div>

</body>

</html>
