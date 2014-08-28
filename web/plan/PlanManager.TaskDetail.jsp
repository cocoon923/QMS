<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager"/>

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


    <%
        //��ȡ�ƻ�id
        String sPlanId = request.getParameter("planid");
        String sStartTime = "";
        String sEndTime = "";
        String sPlanName = "";
        String sDemand_id = "";
        String sDemand_id_temp = "";
        Vector vPlanTaskInfo = new Vector();
        Vector vPlanTaskInfoAgain = new Vector();
        if (sPlanId == null || sPlanId.equals("")) {
            out.print("<script language='javascript'>alert('�ƻ���Ų���Ϊ��!');</script>");
        } else {
            //ȡ�ƻ�������Ϣ
            Vector vPlanInfo = new Vector();
            vPlanInfo = PlanManager.queryplaninfo(sPlanId, "", "", "", "", "", "", "", "", "");
            if (vPlanInfo.size() > 0) {
                HashMap PlanInfohash = (HashMap) vPlanInfo.get(0);
                sStartTime = (String) PlanInfohash.get("START_TIME");
                sStartTime = sStartTime.substring(0, 10);
                sEndTime = (String) PlanInfohash.get("END_TIME");
                sEndTime = sEndTime.substring(0, 10);
                sPlanName = (String) PlanInfohash.get("PLAN_NAME");
            }
            //ȡ�ƻ���������Ϣ

            vPlanTaskInfo = PlanManager.queryplantaskinfo(sPlanId, "", "", "", "", "", "", "", "", "", "", "");

            //��ȡ�˼ƻ����ظ��ļƻ�����ƴ�ɴ�
            vPlanTaskInfoAgain = PlanManager.queryplantaskinfoagain(sPlanId);
            if (vPlanTaskInfoAgain.size() > 0) {
                for (int ia = 0; ia < vPlanTaskInfoAgain.size(); ia++) {
                    HashMap vPlanTaskInfoAgainHash = (HashMap) vPlanTaskInfoAgain.get(ia);
                    sDemand_id_temp = (String) vPlanTaskInfoAgainHash.get("DEMAND_ID");
                    sDemand_id = sDemand_id + "," + sDemand_id_temp;
                }
            }
        }

        int iCount = 0;
        Vector vDemandInfo = new Vector();
        vDemandInfo = PlanManager.trackdemandinfo(sPlanId);
        iCount = vDemandInfo.size();

    %>

    <title>Querytaskdetail</title>

    <link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
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

        function dialogcommit(form1) {
            form1.submit();
            window.close();
            window.returnValue = "Y";
        }

        function cancle() {
            window.close();
        }


        function openNewWindow(type, sid) {
            if (type == "1") //����
            {
                window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=" + sid);
            }
            else if (type == "2")     //����
            {
                window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id=" + sid);
            }
            else if (type == "3")  //�з����ܵ�����
            {
                window.open("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id=" + sid);
            }
            else {
                alert("idֵ����ȷ�����飡");
            }
        }

    </script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr class="title">
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr class="title">
                <td>�ƻ������б�:</td>
                <td width="24">
                    <div align="right"><br></div>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr class="contentbg">
    <td class="pagetitle1" style="height: 25px; ">�ƻ�����"<%=sPlanName %>", �ƻ���ʼʱ�䣺<%=sStartTime %> ---
        �ƻ�����ʱ�䣺<%=sEndTime %>
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
    <!--                 <td width="5%" class="pagecontenttitle">���</td>
                    <td width="24%" class="pagecontenttitle">����<br></td>
                    <td width="8%" class="pagecontenttitle">��������</td>
                    <td width="8%" class="pagecontenttitle">��Ʒ<br></td>
                    <td width="7%" class="pagecontenttitle">״̬<br></td>
                    <td width="10%" class="pagecontenttitle">������Ա<br></td>
                    <td width="10%" class="pagecontenttitle">������<br></td>
                    <td width="10%" class="pagecontenttitle">������Ա<br></td>
                    <td width="8%" class="pagecontenttitle">�ύ����ʱ��<br></td> -->

    <td width="5%" class="pagecontenttitle">���</td>
    <td width="5%" class="pagecontenttitle">��ʶ</td>
    <td width="5%" class="pagecontenttitle">������</td>
    <td width="10%" class="pagecontenttitle">������</td>
    <td width="24%" class="pagecontenttitle">����<br></td>
    <td width="8%" class="pagecontenttitle">��������</td>
    <td width="8%" class="pagecontenttitle">ģ��<br></td>
    <td width="7%" class="pagecontenttitle">״̬<br></td>
    <td width="10%" class="pagecontenttitle">������Ա<br></td>
    <td width="10%" class="pagecontenttitle">������Ա<br></td>
    <td width="8%" class="pagecontenttitle">�ύ����ʱ��<br></td>

</tr>
</thead>
<tbody>
<%
    String sDEMAND_ID;
    String sDEMAND_TITLE;
    String sPROJ_NAME;
    String sPRODUCT_NAME;
    String sSTA_NAME;
    String sREP_TIME;
    String sTESTER_NAME;
    String sTESTER_ID;
    String sGROUP_NAME;
    String sGROUP_ID;
    String sDEV_NAME;
    String sDEV_ID;
    String sTESTER_NAME_new;

    String sMODULE_NAME;
    String sTASK_TITLE;
    String sTITLE_DESC;
    String sDEMAND_SRC_ID;
    String sTASK_STATUS;
    String sCOMMIT_TIME;
    String sTASK_ID;


    int abc = vDemandInfo.size();
    int j = 1;
    if (vDemandInfo.size() > 0) {
        for (int i = vDemandInfo.size() - 1; i >= 0; i--) {
            sDEMAND_ID = "";
            sDEMAND_TITLE = "";
            sPRODUCT_NAME = "";
            sSTA_NAME = "";
            sREP_TIME = "";
            sTESTER_ID = "";
            sGROUP_NAME = "";
            sGROUP_ID = "";
            sDEV_ID = "";
            sTESTER_NAME_new = "";


            sTESTER_NAME = "";
            sDEV_NAME = "";
            sPROJ_NAME = "";
            sMODULE_NAME = "";
            sTASK_TITLE = "";
            sTITLE_DESC = "";
            sDEMAND_SRC_ID = "";
            sTASK_STATUS = "";
            sCOMMIT_TIME = "";
            sTASK_ID = "";


            HashMap hash = (HashMap) vDemandInfo.get(i);
            sDEMAND_ID = (String) hash.get("DEMAND_ID");
            sTASK_ID = (String) hash.get("TASK_ID");

            sTASK_TITLE = (String) hash.get("TITLE");
            sPROJ_NAME = (String) hash.get("PROJ_NAME");
            sMODULE_NAME = (String) hash.get("MODULE_NAME");
            sTASK_STATUS = (String) hash.get("TASK_STATUS");
            sTESTER_NAME = (String) hash.get("TESTER_NAME");
            sDEV_NAME = (String) hash.get("DEV_NAME");
            sCOMMIT_TIME = (String) hash.get("COMMIT_TIME");
            sDEMAND_SRC_ID = (String) hash.get("DEMAND_SRC_ID");
            if (sDEMAND_SRC_ID == null) sDEMAND_SRC_ID = "";

            //sTESTER_NAME= (String) hash.get("CASE_SEQ");
            //sGROUP_NAME = (String) hash.get("OP_NAME");
            //sDEV_NAME = (String) hash.get("GROUP_NAME");
%>
<%
    if (sDemand_id.indexOf(sDEMAND_ID) > 0) {
%>
<tr>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">
        (<%=j%>)
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">����
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEMAND_ID"
        style="color:#ff0000;"><a href="
				             <%
/* 				             	if(stype.equals("1")) //����
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("2"))//����
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("3")) //����
				             	{
				             		out.print("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	} */
				             %>" target="_blank"><%=sDEMAND_ID%>
    </a></td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEMAND_SRC_ID"
        style="color:#ff0000;">&nbsp;<%=sDEMAND_SRC_ID%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TASK_TITLE"
        style="color:#ff0000;">&nbsp;<%=sTASK_TITLE%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="PROJ_NAME"
        style="color:#ff0000;">&nbsp;<%=sPROJ_NAME%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="MODULE_NAME"
        style="color:#ff0000;">&nbsp;<%=sMODULE_NAME%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TASK_STATUS"
        style="color:#ff0000;">&nbsp;<%=sTASK_STATUS%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TESTER_NAME"
        style="color:#ff0000;">&nbsp;<%=sTESTER_NAME%>
    </td>
    <!--
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="GROUP_NAME" style="color:#ff0000;">&nbsp;<%if(sGROUP_NAME==null) out.print("");else out.print(sGROUP_NAME);%></td>
				              -->
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEV_NAME"
        style="color:#ff0000;">&nbsp;<%=sDEV_NAME%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="COMMIT_TIME"
        style="color:#ff0000;">&nbsp;<%=sCOMMIT_TIME%>
    </td>
</tr>
<%
} else {
%>

<tr>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">(<%=j%>)</td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">����</td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEMAND_ID"><a href="
				             <%
				             /* 	if(stype.equals("1")) //����
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("2"))//����
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("3")) //����
				             	{
				             		out.print("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	} */
				             %>" target="_blank"><%=sTASK_ID%>
    </a></td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEMAND_SRC_ID">
        &nbsp;<%=sDEMAND_SRC_ID%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TASK_TITLE">
        &nbsp;<%=sTASK_TITLE%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="PROJ_NAME">
        &nbsp;<%=sPROJ_NAME%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="MODULE_NAME">
        &nbsp;<%=sMODULE_NAME%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TASK_STATUS">
        &nbsp;<%=sTASK_STATUS%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TESTER_NAME">
        &nbsp;<%=sTESTER_NAME%>
    </td>
    <!--
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="GROUP_NAME" style="color:#ff0000;">&nbsp;<%if(sGROUP_NAME==null) out.print("");else out.print(sGROUP_NAME);%></td>
				              -->
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEV_NAME">
        &nbsp;<%=sDEV_NAME%>
    </td>
    <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="COMMIT_TIME">
        &nbsp;<%=sCOMMIT_TIME%>
    </td>

</tr>

<%
            }
            j = j + 1;
        }
    }
%>
</tbody>
<tfoot>
<tr>
    <td width="5%" class="pagecontenttitle">���</td>
    <td width="5%" class="pagecontenttitle">��ʶ</td>
    <td width="5%" class="pagecontenttitle">������</td>
    <td width="10%" class="pagecontenttitle">������</td>
    <td width="24%" class="pagecontenttitle">����<br></td>
    <td width="8%" class="pagecontenttitle">��������</td>
    <td width="8%" class="pagecontenttitle">ģ��<br></td>
    <td width="7%" class="pagecontenttitle">״̬<br></td>
    <td width="10%" class="pagecontenttitle">������Ա<br></td>
    <td width="10%" class="pagecontenttitle">������Ա<br></td>
    <td width="8%" class="pagecontenttitle">�ύ����ʱ��<br></td>
</tr>
</tfoot>
</table>
</td>
</tr>
<tr>
    <td>
        <div align="center">
            <table width="146" border="0" cellspacing="5" cellpadding="5">
                <td width="101" height="30">
                    <table width="80" border="0" cellspacing="1" cellpadding="1">
                        <tr>
                            <td class="buttonstyle" onMouseOver="changecolor(this)" onMouseOut="restorcolor(this)"
                                onclick="cancle()">�ر�
                            </td>
                        </tr>
                    </table>
            </table>
        </div>
    </td>
</tr>
</table>
</td>
</tr>
</table>
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
                showAll: "ȫѡ",
                showNone: "ȫ��ѡ"
            },
            "tableTools": {
                "sSwfPath": "../datatables/swf/copy_csv_xls.swf",
                "aButtons": [
                    {
                        "sExtends": "xls",
                        "sButtonText": "����",
                        "mColumns": "visible"
                    }
                ]
            }
        });
    });

</script>
</body>
</html>
