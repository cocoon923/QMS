<%@include file="../allcheck.jsp" %>
<jsp:useBean id="importRequirment" scope="page" class="dbOperation.ImportRequriment"/>
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData"/>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.HashMap,java.util.Vector" %>
<%
    request.setCharacterEncoding("gb2312");
%>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../datatables/css/dataTables.colVis.css">
<link rel="stylesheet" type="text/css" href="../datatables/css/dataTables.tableTools.css">
<link rel="stylesheet" type="text/css" href="../datatables/css/jquery.dataTables.css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%@ page contentType="text/html; charset=gb2312" %>
<script language="javascript">
    window.onload = function () {

        setTableColor();
    }

    function empty() {
        document.open.submit();
    }

    function ToSubmit(form1) {
        form1.submit();
    }

    function Update_GoToUrl(url) {
        /*add by huyf start */
        var demandID = '';
        var demandRadio = document.getElementsByName("demandradio");
        for (var i = 0; i < demandRadio.length; i++) {
            if (demandRadio[i].checked) {
                demandID = demandRadio[i].value.split('|')[0];
                break;
            }
        }
        if (url.indexOf('TaskManager.NewTask.jsp') > 0) {
            if (demandID != '') {
                url = url + '&demandID=' + demandID;
            } else {
                alert("请选择需要创建任务单的需求！");
                return;
            }
        }

        if (url.indexOf('ModifyDemand.jsp') > 0) {
            if (demandID != '') {
                url = url + '&demandID=' + demandID;
            } else {
                alert("请选择需要编辑的需求！");
                return;
            }
        }

        /*add by huyf end*/
        window.location = url;
    }

    function openNewWindow(sid) {
        var sId = sid.substr(1, sid.length);
        if ((sid.substr(0, 1)) == "R") //需求
        {
            //window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sId);
        }
        else     //故障F
        {
            //window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sId);
        }
    }


</script>
<%
    String currentURL = request.getRequestURL().toString();
    System.out.println("currentURL:" + currentURL);
    //获取登陆名
    //String opId=(String)session.getValue("OpId");
    String opId = ""; //不需按录入用户名查询
    String sdate_s = "";
    String sDate = "";
    String sSelectDate = request.getParameter("cdate");
    if (sSelectDate == null)
        sSelectDate = "";
    // out.print("是否勾选录入时间="+sSelectDate+"<br>");
    String sSelectStartDate = request.getParameter("startTime");
    String sSelectEndDate = request.getParameter("endTime");
    if (sSelectStartDate == null)
        sSelectStartDate = "";
    if (sSelectEndDate == null)
        sSelectEndDate = "";
    //out.print("开始时间="+sSelectStartDate+";结束时间="+sSelectEndDate+"<br>");
    String[] sSelectProduct = (String[]) request.getParameterValues("productName");
    //  if (sSelectProduct!=null)
    //  {
    //    for(int k=0;k<sSelectProduct.length;k++)
    //     out.print("产品名称="+sSelectProduct[k]+"<br>");
    //  }
    String[] sSelectRequirement = request.getParameterValues("productState");
    //  if (sSelectRequirement!=null)
    //  {
    //    for(int k=0;k<sSelectRequirement.length;k++)
    //     out.print("需求状态="+sSelectRequirement[k]+"<br>");
    //  }
    String[] sSelectmalfuctionState = request.getParameterValues("malfuctionState");
    //  if (sSelectmalfuctionState!=null)
    //  {
    //    for(int k=0;k<sSelectmalfuctionState.length;k++)
    //      out.print("故障状态="+sSelectmalfuctionState[k]+"<br>");
    //  }
    String rId = request.getParameter("rId");
    String gId = request.getParameter("gId");
    if (rId == null)
        rId = "";
    if (gId == null)
        gId = "";
    String sNewRid = rId.replaceAll(";", ",");
    sNewRid = sNewRid.replaceAll("R", "");
    sNewRid = sNewRid.replaceAll("r", "");
    String sNewGid = gId.replaceAll(";", ",");
    sNewGid = sNewGid.replaceAll("F", "");
    sNewGid = sNewGid.replaceAll("f", "");
    //  out.print("需求编号="+rId+"<br>");
    //  out.print("故障编号="+gId+"<br>");

    String QueryStartTime = "";
    String QueryEndTime = "";
    String QueryProduct = "";
    if (sSelectDate.equals("1"))  //当勾选时间才将界面时当作查询条件
    {
        QueryStartTime = sSelectStartDate;
        QueryEndTime = sSelectEndDate;
    }
    if (sSelectProduct != null)    //当勾选产品名称才将界面时当作查询条件
    {
        for (int k = 0; k < sSelectProduct.length; k++) {
            if (k == 0) {
                QueryProduct = sSelectProduct[k];
            } else {
                QueryProduct = QueryProduct + "," + sSelectProduct[k];
            }
        }
    }
    String QueryReq = "";
    if (sSelectRequirement != null)  //当勾选需求状态才将界面时当作查询条件
    {
        for (int k = 0; k < sSelectRequirement.length; k++) {
            if (k == 0) {
                QueryReq = sSelectRequirement[k];
            } else {
                QueryReq = QueryReq + "," + sSelectRequirement[k];
            }
        }
    }
    String QueryGu = "";
    if (sSelectmalfuctionState != null)   //故障
    {
        for (int k = 0; k < sSelectmalfuctionState.length; k++) {
            if (k == 0) {
                QueryGu = sSelectmalfuctionState[k];
            } else {
                QueryGu = QueryGu + "," + sSelectmalfuctionState[k];
            }
        }
    }
    String sQueryDate = request.getParameter("sCheckDate");
    if (sQueryDate == null)
        sQueryDate = "";

    int demandCount = 0;

    String sdemandflag = "";
    sdemandflag = request.getParameter("demandflag");

    String demandTitle = "";
    demandTitle = request.getParameter("demandTitle");
    if (demandTitle == null) demandTitle = "";

    Vector vDelayDay = QueryBaseData.querySysBaseType("DEMAND_REQUEST", "DELAY_DAY");
    String sDelayDay = "0";
    if (vDelayDay.size() > 0) {
        HashMap delayDayMap = (HashMap) vDelayDay.get(0);
        sDelayDay = (String) delayDayMap.get("CODE_VALUE");
        System.out.println("sDelayDay:" + sDelayDay);
    }

%>
<title>plantask</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<script language="JavaScript" type="text/JavaScript">
    function changecolor(obj) {
        obj.className = "buttonstyle2"
    }

    function restorcolor(obj) {
        obj.className = "buttonstyle"
    }

    function loadPage(url) {
        window.location = url;
    }

    function empty() {

        document.open.submit();
    }


</script>
</head>

<form method="post" onSubmit="return empty()" action="">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr class="title">
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr class="title">
                <td>需求查询:<br></td>
                <td width="24" height="5">
                    <div align="right"><br></div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
<td class="contentoutside">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>
<td class="contentoutside">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="contentbottomline">
<table width="100%" border="0" cellspacing="0" cellpadding="1">
    <%

        Vector vDataBaseDate = importRequirment.getDataBaseDate();
        if (vDataBaseDate.size() > 0) {
            HashMap dataBaseMap = (HashMap) vDataBaseDate.get(0);
            sdate_s = (String) dataBaseMap.get("SDATE_S");
            sDate = (String) dataBaseMap.get("SDATE");
        }
        if (!sSelectStartDate.equals(""))
            sdate_s = sSelectStartDate;
        if (!sSelectEndDate.equals(""))
            sDate = sSelectEndDate;
    %>
    <tr>
        <td width="15%" class="pagetitle1" style="height: 40px; ">
            <div align="left">录入时间：</div>
            <div align="right"></div>
        </td>
        <td width="85%" class="pagetextdetails">
            <%
                if (sQueryDate.equals("1")) {
                    if (sSelectDate.equals("1")) {
            %>
            <input name="cdate" type="checkbox" id="chk_date" value="1" checked>
            <%
            } else {
            %>
            <input name="cdate" type="checkbox" id="chk_date" value="1">
            <%
                }
            } else {
            %>
            <input name="cdate" type="checkbox" id="chk_date" value="1">
            <%
                }
            %>
            <input name="startTime" type="text" class="inputstyle" id="startTime" onClick="JSCalendar(this);"
                   value="<%=sdate_s%>" size="10">
            ---
            <input name="endTime" type="text" class="inputstyle" id="endTime" value="<%=sDate%>" size="10"
                   onClick="JSCalendar(this);"></td>
    </tr>
    <input type="hidden" name="sCheckDate" value="1">
    <tr class="contentbg">
        <td class="pagetitle1" style="height: 40px; ">产品名称：</td>
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
            <input type="checkbox" value="<%=PRODUCT_ID%>" name="productName"><font
                class="pagetextdetails"><%=PRODUCT_NAME%>&nbsp;&nbsp;
                <%        }
                              else
                              {
                     %>
            <input type="checkbox" value="<%=PRODUCT_ID%>" name="productName" checked><font
                    class="pagetextdetails"><%=PRODUCT_NAME%>&nbsp;&nbsp;

                <%
                            }
                        }
                    }
                %>
            </font></td>
    </tr>

    <tr>
        <td class="pagetitle1" style="height: 40px; ">需求状态：</td>
        <td><font class="pagetextdetails">
                <%
                      	 //Vector vRequirement=QueryBaseData.querySysBaseType("DEMAND_REQUEST","STATUS");
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
            <input type="checkbox" value="<%=PRODUCT_ID%>" name="productState"><font
                class="pagetextdetails"><%=NAME%>&nbsp;&nbsp;

                <%
                                }
                                else
                                {
                       %>
            <input type="checkbox" value="<%=PRODUCT_ID%>" name="productState" checked><font
                    class="pagetextdetails"><%=NAME%>&nbsp;&nbsp;
                <%
                            }
                        }
                    }
                %>

            </font></td>
    </tr>

    <tr style="display:none">
        <td class="pagetitle1" style="height: 30px; ">需求状态：</td>
        <td>
            <select style="width: 315px; " name="demandflag" class="inputstyle" id="demandflag">
                <%
                    if (sdemandflag == null) {
                %>
                <option value="" class="pagetextdetails"> -------------- 选择所有 --------------</option>
                <option value="0" class="pagetextdetails"> [0] 失效 <br></option>
                <option value="1" class="pagetextdetails" selected> [1] 生效 <br></option>
                <%
                } else {
                    if (sdemandflag.equals("")) {
                %>
                <option value="" class="pagetextdetails" selected> -------------- 选择所有 --------------</option>
                <option value="0" class="pagetextdetails"> [0] 失效 <br></option>
                <option value="1" class="pagetextdetails"> [1] 生效 <br></option>
                <%
                } else if (sdemandflag.equals("0")) {
                %>
                <option value="" class="pagetextdetails"> -------------- 选择所有 --------------</option>
                <option value="0" class="pagetextdetails" selected> [0] 失效 <br></option>
                <option value="1" class="pagetextdetails"> [1] 生效 <br></option>
                <%
                } else if (sdemandflag.equals("1")) {
                %>
                <option value="" class="pagetextdetails"> -------------- 选择所有 --------------</option>
                <option value="0" class="pagetextdetails"> [0] 失效 <br></option>
                <option value="1" class="pagetextdetails" selected> [1] 生效 <br></option>
                <%
                } else {
                %>
                <option value="" class="pagetextdetails"> -------------- 选择所有 --------------</option>
                <option value="0" class="pagetextdetails"> [0] 失效 <br></option>
                <option value="1" class="pagetextdetails" selected> [1] 生效 <br></option>
                <%
                        }
                    }
                %>
            </select>
        </td>
    </tr>

    <!--
                <tr  class="contentbg">
                  <td class="pagetitle1" style= "height: 35px; ">需求编号：</td>
                  <td class="pagetextdetails">
                  <input name="rId" type="text" class="inputstyle" id="rId"   size="50" value="<%=rId%>"></td>
                </tr> -->

    <tr class="contentbg">
        <td class="pagetitle1" style="height: 45px; ">需求标题：</td>
        <td class="pagetextdetails">
            <input name="demandTitle" type="text" class="inputstyle" id="demandTitle" size="50"
                   value="<%=demandTitle%>">
        </td>
    </tr>

    <!--
                <tr>
                  <td class="pagetitle1" style= "height: 35px; ">故障编号：</td>
                  <td class="pagetextdetails">
                  <input name="gId" type="text" class="inputstyle" id="gId"   size="50" value="<%=gId%>"></td>
                </tr>-->

</table>
</td>
</tr>
<tr>
    <td class="contentbottomline">
        <div align="left">
            <table width="146" border="0" cellspacing="5" cellpadding="5">
                <tr>
                    <td width="100" height="30">
                        <table width="80" border="0" cellspacing="1" cellpadding="1">
                            <tr>
                                <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                    onclick="hiddenButton.click()">查 询
                                </td>
                                <input type="button" name="hiddenButton" id="hiddenButton" runat="server"
                                       style="display:none;" OnClick="ToSubmit(this.form)">
                            </tr>
                        </table>
                    </td>
                    <td width="101">
                        <table width="80" border="0" cellspacing="1" cellpadding="1">
                            <tr>
                                <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                    type="submit" name="B3"
                                    onclick="Update_GoToUrl(/*href*/'QueryImportRequirement.jsp?iCheckDate=1')">同步数据<br>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="101">
                        <table width="80" border="0" cellspacing="1" cellpadding="1">
                            <tr>
                                <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                    type="submit" name="B1"
                                    onclick="toExport(/*href*/'DemandManager.DemandInfoExportExcel.jsp?QueryStartTime=<%=QueryStartTime%>&QueryEndTime=<%=QueryEndTime%>&QueryProduct=<%=QueryProduct%>&QueryReq=<%=QueryReq%>&QueryGu=<%=QueryGu%>&sNewRid=<%=sNewRid%>&sNewGid=<%=sNewGid%>')">
                                    导出EXCEL<br></td>
                                <!--  td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="toExport.click()">导出EXCEL</td>
                                <input type="toExport" name="toExport" id="CreatWord" runat="server"  style="display:none;" OnClick="toExport(this.form)" -->
                            </tr>
                        </table>
                    </td>
                    <td width="101">
                        <table width="100" border="0" cellspacing="1" cellpadding="1">
                            <tr>
                                <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                    type="submit" name="B4"
                                    onclick="Update_GoToUrl(/*href*/'../task/TaskManager.NewTask.jsp?iCheckDate=1')">
                                    生成任务单<br></td>
                            </tr>
                        </table>
                    </td>

                    <td width="101">
                        <table width="100" border="0" cellspacing="1" cellpadding="1">
                            <tr>
                                <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                    type="submit" name="B5"
                                    onclick="Update_GoToUrl(/*href*/'DemandManager.ModifyDemand.jsp?iCheckDate=1')">需求补录<br>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <!--
                      <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
                          <tr>
                            <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" type="submit" name="B6" onclick="importRequest();">需求导入<br></td>
                          </tr>
                        </table></td> -->
                    <td width="101">
                        <table width="80" border="0" cellspacing="1" cellpadding="1">
                            <tr>
                                <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                    type="submit" name="B6" onclick="trackRequest();">需求追踪<br></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </td>
</tr>
</table>
</td>
</tr>
</table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr class="title">
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr class="title">
                    <td>需求列表<br></td>
                    <td width="24">
                        <div align="right"><br></div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
                            <thead>
                            <tr>
                                <td width="3%" class="pagecontenttitle">
                                    <div align="center"></div>
                                </td>
                                <td width="5%" class="pagecontenttitle">序号</td>
                                <td width="3%" class="pagecontenttitle">需求ID</td>
                                <td width="17%" class="pagecontenttitle">名称<br></td>
                                <td width="5%" class="pagecontenttitle">状态<br></td>
                                <td width="5%" class="pagecontenttitle">子系统<br></td>
                                <td width="5%" class="pagecontenttitle">模块<br></td>
                                <td width="8%" class="pagecontenttitle">项目名称<br></td>
                                <td width="8%" class="pagecontenttitle">紧急程度<br></td>
                                <td width="8%" class="pagecontenttitle">开发计划开始时间<br></td>
                                <td width="8%" class="pagecontenttitle">开发计划提交时间<br></td>
                                <td width="7%" class="pagecontenttitle">开发人员<br></td>
                                <td width="8%" class="pagecontenttitle">测试人员<br></td>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                String sDEMAND_ID = "";
                                String sDemandName = "";
                                String sProjectName = "";
                                String sDemandStatus = "";
                                String sLevelId = "";
                                String sFinishTime = "";
                                String sSubSysName = "";
                                String sModuleName = "";
                                String sDevId = "";
                                String sTesterId = "";
                                String sReportTime = "";
                                String sPlanDevBeginTime = "";
                                String sPlanDevTime = "";


                                int j = 1;

                                Vector vDemandRequest = importRequirment.getRequirementList(demandTitle, QueryStartTime, QueryEndTime, QueryProduct, QueryReq, "");
                                if (vDemandRequest.size() > 0) {
                                    demandCount = vDemandRequest.size();
                                    for (int i = 0; i < vDemandRequest.size(); i++) {
                                        HashMap reqMap = (HashMap) vDemandRequest.get(i);
                                        sDEMAND_ID = (String) reqMap.get("DEMAND_ID");
                                        sDemandName = (String) reqMap.get("DEMAND_NAME");
                                        sDemandStatus = (String) reqMap.get("STATE");
                                        sProjectName = (String) reqMap.get("PROJECT_NAME");
                                        sLevelId = (String) reqMap.get("LEVEL_ID");
                                        sSubSysName = (String) reqMap.get("SUBSYS_NAME");
                                        sModuleName = (String) reqMap.get("MODULE_NAME");
                                        sFinishTime = (String) reqMap.get("FINISHTIME");
                                        sDevId = (String) reqMap.get("DEV_ID");
                                        sTesterId = (String) reqMap.get("TESTER_ID");
                                        sReportTime = (String) reqMap.get("REPORT_TIME");
                                        sPlanDevBeginTime = (String) reqMap.get("PLAN_DEV_BEGIN_TIME");
                                        sPlanDevTime = (String) reqMap.get("PLAN_DEV_TIME");


                            %>


                            <tr>
                                <td class="coltext">
                                    <div align="center"><input type="radio" name="demandradio"
                                                               value="<%out.print(sDEMAND_ID+"|"+sDemandStatus);%>">
                                    </div>
                                </td>
                                <td class="coltext">(<%=j%>)</td>
                                <td class="coltext"><a href="#"
                                                       onclick="goToURL(/*href*/'DemandManager.DemandInfo.jsp?planid=<%=sDEMAND_ID%>')"><%=sDEMAND_ID%>
                                </a></td>
                                <td class="coltext"><%=sDemandName%>
                                </td>
                                <td class="coltext"><%=sDemandStatus%>
                                </td>
                                <td class="coltext"><%=sSubSysName%>
                                </td>
                                <td class="coltext"><%=sModuleName%>
                                </td>
                                <td class="coltext"><%=sProjectName%>
                                </td>
                                <td class="coltext"><%=sLevelId%>
                                </td>
                                <td class="coltext"><%=sPlanDevBeginTime%>
                                </td>
                                <td class="coltext"><%=sPlanDevTime%>
                                </td>
                                <td class="coltext"><%=sDevId%>
                                </td>
                                <td class="coltext"><%=sTesterId%>
                                </td>


                                <%-- 				<td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(PLAN_DEV_TIME==null) out.print("&nbsp;");else out.print(PLAN_DEV_TIME);%></td>
                                                    <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(REAL_DEV_TIME==null) out.print("&nbsp;");else out.print(REAL_DEV_TIME);%></td>
                                                    <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(PLAN_TEST_TIME==null) out.print("&nbsp;");else out.print(PLAN_TEST_TIME);%></td>
                                                     <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(DEV_NAME==null) out.print("&nbsp;");else out.print(DEV_NAME);%></td>
                                                     <td class="<%if(i%2!=0) out.print("coltext"); else out.print("coltext2");%>">&nbsp;<%if(TESTER_NAME==null) out.print("&nbsp;");else out.print(TESTER_NAME);%></td>
                                                    <td class="<%if(i%2!=0) out.print("coltext10"); else out.print("coltext20");%>">&nbsp;<%if(REMARK==null) out.print("&nbsp;");else out.print(REMARK);%></td> --%>
                            </tr>
                            <%
                                        j = j + 1;
                                    }
                                }
                            %>

                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</table>
<%
    String iCheckDate = request.getParameter("iCheckDate");
//    out.print("iCheckDate="+iCheckDate);
    if (iCheckDate != null) {
        if (iCheckDate.equals("1")) {
            importRequirment.updateDate();
            out.print("<script language=javascript>alert('数据已经同步！');</script>");
        }
    }
%>
<script language="javascript">
    //导出excel
    function toExport(url) {

        alert(demandCount);
        var iCount =<%=demandCount%>;
        if (iCount == 0) {
            alert("没有任何数据，请重新查询后再进行导出！");

        }
        else {
            window.open(url);

        }

        // QueryStartTime,QueryEndTime,QueryProduct,QueryReq,QueryGu,sNewRid,sNewGid
    }

    function importRequest() {

        var sTableName = "DEMAND_REQUEST";
        //var sCurrentURL=<%=currentURL%>;
        //alert(sCurrentURL);
        var refresh = showModalDialog('http://localhost:8080/QMS/import/ImportManager.ImportRequest.jsp?sTableName=' + sTableName, window, 'dialogWidth:500px;status:no;dialogHeight:150px');
        if (refresh == "Y") {
            self.location.reload();
        }
    }

    function trackRequest() {

        var url = /*href*/'DemandManager.TrackRequest.jsp?';
        /*add by huyf start */
        var demandID = '';
        var demandStatus = '';
        var demandRadio = document.getElementsByName("demandradio");
        for (var i = 0; i < demandRadio.length; i++) {
            if (demandRadio[i].checked) {
                var radioVal = demandRadio[i].value;
                demandID = radioVal.split('|')[0];
                demandStatus = radioVal.split('|')[1];
                break;
            }
        }
        if (demandID != '') {
            url = url + 'demandID=' + demandID + '&demandStatus=' + demandStatus;
        } else {
            alert("请选择需求！");
            return;
        }
        var refresh = showModalDialog(url, window, 'dialogWidth:750px;status:no;dialogHeight:300px');
        if (refresh == "Y") {
            self.location.reload();
        }
    }

    function setTableColor() {

        var state = "<%=sDemandStatus%>";
        var curentTime = getCurentTime();
        var alarmTime = getAlarmTime();

        //alert("当前时间："+ curentTime);
        //alert("告警时间 "+ alarmTime);

        //var count = <%=demandCount%>;
        var table = document.getElementById("steplist");
        var rows = table.getElementsByTagName("tr");
        for (var i = 1; i < rows.length; i++) {
            var planDevTime = rows[i].cells[10].innerText;
            var state = rows[i].cells[4].innerText;

            if (planDevTime != "null" && state != "确认完成") {
                if (planDevTime < curentTime) {
                    setTdColor(rows[i], "#FF0000");  //过期显示红色
                } else if (planDevTime <= alarmTime && planDevTime > curentTime) {
                    setTdColor(rows[i], "#FFFF00"); //提前告黄色
                }
            }
        }
    }
    function setTdColor(tableRow, bgColor) {
        var tds = tableRow.childNodes;
        for (var i = 0; i < tds.length; i++) {
            tds[i].style.backgroundColor = bgColor;
        }
    }

    function getCurentTime() {
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日

        //var hh = now.getHours();            //时
        //var mm = now.getMinutes();          //分

        var clock = year + "-";

        if (month < 10)
            clock += "0";

        clock += month + "-";

        if (day < 10)
            clock += "0";

        clock += day + " ";

        /*      if(hh < 10)
         clock += "0";

         clock += hh + ":";
         if (mm < 10) clock += '0';
         clock += mm;  */
        return(clock);
    }

    function getAlarmTime() {

        var now = new Date();
        var delayDay = <%=sDelayDay%>;
        now.setDate(now.getDate() + delayDay);

        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日

        var clock = year + "-";

        if (month < 10)
            clock += "0";

        clock += month + "-";

        if (day < 10)
            clock += "0";

        clock += day + " ";
        return(clock);
    }


    function getStrDate(strDate) {
        var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
                function (a) {
                    return parseInt(a, 10) - 1;
                }).match(/\d+/g) + ')');
        return date;
    }

    function StringToDate(DateStr) {

        var converted = Date.parse(DateStr);
        var myDate = new Date(converted);
        if (isNaN(myDate)) {
            //var delimCahar = DateStr.indexOf('/')!=-1?'/':'-';
            var arys = DateStr.split('-');
            myDate = new Date(arys[0], --arys[1], arys[2]);
        }
        return myDate;
    }

    function CheckDateTime(str) {
        var reg = /^(\d+)-(\d{ 1,2 })-(\d{ 1,2 }) (\d{ 1,2 }):(\d{ 1,2 }):(\d{ 1,2 })$/;
        var r = str.match(reg);
        if (r == null)return false;
        r[2] = r[2] - 1;
        var d = new Date(r[1], r[2], r[3], r[4], r[5], r[6]);
        if (d.getFullYear() != r[1])return false;
        if (d.getMonth() != r[2])return false;
        if (d.getDate() != r[3])return false;
        if (d.getHours() != r[4])return false;
        if (d.getMinutes() != r[5])return false;
        if (d.getSeconds() != r[6])return false;
        return true;
    }

</script>
<script src="../datatables/js/jquery.js"></script>
<script src="../datatables/js/jquery.dataTables.js"></script>
<script src="../datatables/js/dataTables.colVis.js"></script>
<script src="../datatables/js/dataTables.tableTools.js"></script>
<script>

    $(document).ready(function () {
        $('#steplist').DataTable({
            "dom": 'CT<"clear">lfrtip',
            columnDefs: [
                { visible: false, targets: 2 }
            ],
            colVis: {
                showAll: "全选",
                showNone: "全不选"
            },
            "tableTools": {
                "sSwfPath": "../datatables/swf/copy_csv_xls.swf",
                "aButtons": [
                    {
                        "sExtends": "xls",
                        "sButtonText": "导出",
                        "mColumns": "visible"
                    }
                ]
            }
        });
    });

</script>
</body>
</form>
</html>
