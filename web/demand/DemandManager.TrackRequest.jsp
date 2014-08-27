
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<jsp:useBean id="DemandManager" scope="page"
	class="dbOperation.DemandManager" />

<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.util.*,java.io.*,java.sql.*"%>

<%
	request.setCharacterEncoding("gb2312");
	String sDemandId = request.getParameter("demandID");
	String loginName = (String) session.getValue("OpName");
	String sDemandSts = request.getParameter("demandStatus");
	int tarckCount = 0;
%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	Vector vTrackRequest = DemandManager.getTrackInfo(sDemandId);
	if (vTrackRequest.size() > 0) {
		tarckCount = vTrackRequest.size();
	}
%>
<html>
<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<base target="_self">
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>需求追踪</title>
<script language="JavaScript" src="../JSFiles/JSCalendar/JSCalendar.js"
	type="text/JavaScript"></script>
<script language="JavaScript">
var trackCount=<%=tarckCount%>+1;
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
   var ableCreate=true;
	window.location.reload();
	function changecolor(obj) {
		obj.className = "buttonstyle2";
	}

	function restorcolor(obj) {
		obj.className = "buttonstyle";
	}

	function editTrack(){
		if(ableCreate){
		var deman
		var op_name='<%=loginName%>';
		var tBody=document.getElementById("tbody");
		if(trackCount-1>0){
	     demandsts=tBody.rows[trackCount-1].cells[3].innerHTML;
		}else{
			demandsts='<%=sDemandSts%>';
		}
			var tr = document.createElement("tr");
			var opNametd = document.createElement("td");
			var statustd = document.createElement("td");
			var createTimeTd = document.createElement("td");
			var blanktd = document.createElement("td");
			var replyMsgTd = document.createElement("td");
			var replyMsgArea = document.createElement("textarea");
			replyMsgArea.setAttribute("name", "replyMsg");
			replyMsgArea.setAttribute("id", "replyMsg");
			replyMsgArea.setAttribute("wrap", "hard");
			replyMsgArea.style.width = "100%";
			replyMsgArea.style.height = "100px";
			blanktd.setAttribute("className", "coltext");
			opNametd.setAttribute("className", "coltext");
			statustd.setAttribute("className", "coltext");
			createTimeTd.setAttribute("className", "coltext");
			replyMsgTd.setAttribute("className", "coltext");
			blanktd
					.appendChild(document
							.createTextNode('(' + trackCount + ')'));
			statustd.appendChild(document.createTextNode(demandsts));
			opNametd.appendChild(document.createTextNode(op_name));
			createTimeTd.appendChild(document.createTextNode(new Date()
					.Format("yyyy-MM-dd hh:mm:ss")));
			replyMsgTd.appendChild(replyMsgArea);
			tr.appendChild(blanktd);
			tr.appendChild(replyMsgTd);
			tr.appendChild(opNametd);
			tr.appendChild(statustd);
			tr.appendChild(createTimeTd);
			tBody.appendChild(tr);
			ableCreate = false;
		} else {
			return;
		}
	}
	function submitTrack() {
		var form = document.getElementById("trackRequest");
		var reply = document.getElementById("replyMsg");
		
		if (reply != null && reply.value != null && reply.value != '') {
			form.submit();
		} else {
			alert("请输入数据再提交！");
		}
	}
	window.onload=function(){
		if(trackCount==1){
			editTrack();
		}
	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="trackRequest" id="trackRequest" method="post"
		action="DemandManager.OperTrack.jsp">
		<input type="hidden" name='demandID' value='<%=sDemandId%>' />
		<table id="trackTable" width="100%" border="0" cellspacing="0"
			cellpadding="0" id="steplist">
			<tbody id="tbody">
				<tr>
					<td width="2%" class="pagecontenttitle">编号<br></td>
					<td width="18%" class="pagecontenttitle">回复信息<br></td>
					<td width="3%" class="pagecontenttitle">创建人员<br></td>
					<td width="3%" class="pagecontenttitle">状态<br></td>
					<td width="8%" class="pagecontenttitle">创建时间<br></td>

				</tr>
				<%
					String sStatus = "";
					String sOpName = "";
					String sDemandStatus = "";
					String sCreateTime = "";
					String sReplyMsg = "";
					int j = 1;

					if (vTrackRequest.size() > 0) {
						for (int i = 0; i < vTrackRequest.size(); i++) {
							HashMap reqMap = (HashMap) vTrackRequest.get(i);
							sStatus = (String) reqMap.get("STA_NAME");
							sOpName = (String) reqMap.get("OP_NAME");
							sCreateTime = (String) reqMap.get("CREATE_TIME");
							sReplyMsg = (String) reqMap.get("REPLY_MSG");
				%>
				<tr id="">
					<td class="coltext">(<%=j%>)
					</td>
					<td class="coltext"><%=sReplyMsg%></td>
					<td class="coltext"><%=sOpName%></td>
					<td class="coltext"><%=sStatus%></td>
					<td class="coltext"><%=sCreateTime%></td>
				</tr>
				<%
					j = j + 1;
						}
					}
				%>
			</tbody>
		</table>
		 <table width="100%" border="0" cellspacing="5" cellpadding="5">
		            <tr>
		            <td  height="20"></td>
		            </tr>
	                <tr>   
	                <td width="30%" height="30"></td>
	             
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                      <tr> 
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="editTrack()">新增</td>
	                      </tr>
	                    </table></td>
	                    <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                      <tr> 
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" type="submit" name="B6" onclick="submitTrack()">保存<br></td>
	                      </tr>
	                    </table></td>
	                   <td width="30%" height="30"></td>
	                </tr>
	              </table>
	</form>
</body>
</html>