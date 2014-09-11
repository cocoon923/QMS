<%@include file="allcheck.jsp" %>
<%@ page contentType="text/html; charset=gb2312" language="java" %>

<html>

<head>
    <meta name="GENERATOR" content="Microsoft FrontPage 6.0">
    <meta name="ProgId" content="FrontPage.Editor.Document">
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
    <title></title>
    <link href="css/style.css" rel=stylesheet type=text/css>
    <link href="css/leftstyle.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="10">
<table width="160" cellspacing="0" cellpadding="0" border="0" align="center">
    <tr>
        <td width="180" align="center">
            <table cellspacing="0" cellpadding="0" width="180" align="center">
                <tr>
                    <td class="menu_title" id="menuTitle1" onmouseover="this.className='menu_title2';"
                        onclick="showsubmenu(1)" onmouseout="this.className='menu_title';" style="cursor:hand"
                        height="25" colspan="3" bgcolor="#D6D3CE"><span>&nbsp;<b>功能平台</b> </span></td>
                </tr>
                <tr>
                    <td id="submenu1" style="display: marker">
                        <div class="sec_menu" style="width: 180px">
                            <table cellspacing="0" cellpadding="0" width="180" align="center">
                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="demand/DemandManager.NewDemand.jsp"
                                                                         target="main">需求单录入</a></td>
                                </tr>
                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="demand/DemandManager.DemandInfo.jsp"
                                                                         target="main">需求单管理</a></td>
                                </tr>
                                <tr>
                                    <td width="1" rowspan="7" bgcolor="#E1E1E1"><img src="images/001.gif" width="1"
                                                                                     height="1"></td>
                                    <td height="22" width="176">&nbsp;<a href="casemanager.jsp" target="main">用例管理</a>
                                    </td>
                                    <td width="1" rowspan="7" bgcolor="#E1E1E1"><img src="images/001.gif" width="1"
                                                                                     height="1"></td>
                                </tr>
                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="CaseManager.CaseRecord.jsp"
                                                                         target="main">用例补录</a></td>
                                </tr>
                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="CaseManager.Query.jsp"
                                                                         target="main">查询用例</a></td>
                                </tr>
                                <tr>


                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="plan/PlanManager.NewPlan.jsp"
                                                                         target="main">新建计划</a></td>
                                </tr>

                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="plan/PlanManager.ManagerPlan.jsp?"
                                                                         target="main">计划管理</a></td>
                                </tr>


                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a
                                            href="importrequrimentmanager/ImportRequirementManager.jsp" target="main">重点需求录入</a>
                                    </td>
                                </tr>
                                <!--
                                 <tr>
                                 <td height="22" colspan="3">&nbsp;<a href="importrequrimentmanager/QueryImportRequirement.jsp" target="main">重点需求查询</a></td>
                                </tr>

                                <tr>
                                 <td height="22" colspan="3">&nbsp;<a href="approval/Approval.Requisitions.jsp" target="main">提交申请单</a></td>
                                </tr>

                                <tr>
                                 <td height="22" colspan="3">&nbsp;<a href="approval/Approval.MyApprvalManager.jsp" target="main">我的审批</a></td>
                                </tr> -->


                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="stat/Stat.Index.jsp?"
                                                                         target="main">查询统计</a></td>
                                </tr>
                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="query/Query.Index.jsp"
                                                                         target="main">查询统计2</a></td>
                                </tr>
                                <tr>
                                    <td height="22" colspan="3">&nbsp;<a href="import/ImportManager.bacthImport.jsp?"
                                                                         target="main">导入管理</a></td>
                                </tr>

                                <tr>
                                    <td height="1" bgcolor="#C0C0C0"></td>
                                </tr>
                            </table>
                        </div>
                        <!--
                        <div style="width: 180px">
                        <table cellspacing="0" cellpadding="0" width="150" align="center">
                         <tr>
                          <td height="20"><div align="center"><img src="images/06.gif" onmouseover="this.className='menu_title2';" onClick="showsubmenu(1);showsubmenu(2)" onmouseout="this.className='menu_title';" width="9" height="9"></div></td>
                         </tr>
                        </table>
                        </div>
                         -->
                    </td>
                </tr>
            </table>
        </td>
    </tr>


    <tr>
        <td height="10">
            <div align="center"></div>
        </td>
    </tr>
</table>
</body>
</html>

<script>


    function aa(Dir) {
        tt.doScroll(Dir);
        Timer = setTimeout('aa("' + Dir + '")', 100)
    }
    function StopScroll() {
        if (Timer != null)clearTimeout(Timer)
    }


    function initIt() {
        divColl = document.all.tags("DIV");
        for (i = 0; i < divColl.length; i++) {
            whichEl = divColl(i);
            if (whichEl.className == "child")whichEl.style.display = "none";
        }
    }
    function expands(el) {
        whichEl1 = eval(el + "Child");
        if (whichEl1.style.display == "none") {
            initIt();
            whichEl1.style.display = "block";
        } else {
            whichEl1.style.display = "none";
        }
    }

    function showsubmenu(sid) {
        whichEl = eval("submenu" + sid);
        if (whichEl.style.display == "none") {
            eval("submenu" + sid + ".style.display=\"\";");
        }
        else {
            eval("submenu" + sid + ".style.display=\"none\";");
        }
    }


</script>