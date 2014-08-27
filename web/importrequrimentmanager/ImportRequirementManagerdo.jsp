<%@ page contentType="text/html; charset=gb2312" language="java" %>
<jsp:useBean id="importRequirment" scope="page" class="dbOperation.ImportRequriment"/>
<%
    request.setCharacterEncoding("gb2312");
%>
<html>
<head>

<title>重点需求故障录入处理页面</title>
<%
    String bImport = request.getParameter("bImport");
    out.print("bImport=" + bImport);
    if (bImport == null)
        bImport = "";

    String sOpId = (String) session.getValue("OpId");
    out.print("登陆用户=" + sOpId + "<br>");
    String sRMId = request.getParameter("requirement");  //获取需求故障编号

    String ck1 = request.getParameter("ck1");  //获取是否选择计划提交时间
    boolean bck1 = false;
    if (ck1 == null)
        ck1 = "";
    if (ck1.equals("1")) {
        bck1 = true;
    }
    String dvetime = request.getParameter("dvetime");//获取开发提交提醒时间
    String plandevtime = request.getParameter("PLAN_DEV_TIME");//获取开发提交提醒时间;
    if (dvetime == null) dvetime = "";
    if (plandevtime == null) plandevtime = "";

    String ck2 = request.getParameter("ck2");//获取是否选择计划测试时间
    boolean bck2 = false;
    if (ck2 == null)
        ck2 = "";
    if (ck2.equals("1")) {
        bck2 = true;
    }
    String testtime = request.getParameter("testtime");//获取测试提醒时间
    String plantesttime = request.getParameter("PLAN_TEST_TIME");//获取测试提醒时间
    if (testtime == null) testtime = "";
    if (plantesttime == null) plantesttime = "";


    String ck3 = request.getParameter("ck3");//获取是否选择发布时间
    boolean bck3 = false;
    if (ck3 == null)
        ck3 = "";
    if (ck3.equals("1")) {
        bck3 = true;
    }
    String releasetime = request.getParameter("releasetime");//获取发布提醒时间
    String planreleasetime = request.getParameter("PLAN_RELEASE_TIME");//获取发布提醒时间
    if (releasetime == null) releasetime = "";
    if (planreleasetime == null) planreleasetime = "";

    String getremark = request.getParameter("remark");//获取备注信息
    if (getremark == null) getremark = "";
    String remark = (String) session.getValue("remark");
    if (remark == null) remark = "";
    if (remark.equals("")) {
        session.setAttribute("remark", getremark);
    }


    out.print("ck1=" + ck1 + ";ck2=" + ck2 + ";ck3=" + ck3 + ";plandevtime=" + plandevtime + ";plantesttime=" + plantesttime + ";planreleasetime=" + planreleasetime + ";releasetime=" + releasetime + ";devtime=" + dvetime + ";testime=" + testtime + ";getremark=" + getremark);

    String email = request.getParameter("email");//获取文本抄送人
    if (email == null) email = "";
    String[] listArray = (String[]) request.getParameterValues("list2");  //获取抄送人
    out.print("<br>获取需求故障编号=" + sRMId + "<br>");
    out.print("<br>获取是否选择计划提交时间=" + ck1 + "<br>");
    out.print("<br>获取开发提交提醒时间=" + dvetime + "<br>");
    out.print("<br>获取是否选择计划测试时间=" + ck2 + "<br>");
    out.print("<br>获取测试提醒时间=" + testtime + "<br>");
    out.print("<br>获取文本抄送人=" + email + "<br>");
    //    if(listArray.length>0)
    //    {
    //      for(int i=0;i<listArray.length;i++)
    //        out.print(listArray[i]);
    //    }
    String sFinalEmail = "";
    sFinalEmail = email;
    //处理抄送人
    //  if(listArray.length==1)
    //    {
    //      sFinalEmail=email;
    //     }
    ///     else
    //    {
    for (int i = 0; i < listArray.length; i++) {
        if (sFinalEmail != null && !sFinalEmail.equals("")) {
            sFinalEmail = sFinalEmail + ";" + listArray[i];
        } else {
            sFinalEmail = listArray[i];
        }
    }
    //  }
    // out.print("<br>最终文本抄送人="+sFinalEmail+"<br>");
    if (sRMId != null && sRMId != "")
        sRMId = sRMId.toUpperCase();
    if (sRMId == null)
        sRMId = "";

    if (bImport.equals("true"))   //当重复的时候都需要插入的处理
    {
        String sAddCount = (String) session.getValue("sAddCount");
        session.removeAttribute("sAddCount");
        session.setAttribute("sAddCount", String.valueOf((Integer.parseInt(sAddCount) + 1)));
        if (!sRMId.equals("")) {
            String arrRmid1[] = sRMId.split(",");
            sRMId = "";
            for (int k = 1; k < arrRmid1.length; k++)  //重新处理sRMId，获取需要重复插入的需求或者故障以外的需求故障
            {
                if (k == 1) {
                    sRMId = arrRmid1[k];
                } else {
                    sRMId = sRMId + "," + arrRmid1[k];
                }
            }

            //将重复的需求故障插入到库中
            int iRMId = arrRmid1[0].indexOf("R");
            if (iRMId >= 0)
                iRMId = 1;
            else
                iRMId = 2;
            String sSubRMId = arrRmid1[0].substring(1);
            sFinalEmail = (String) session.getValue("sFinalAllEmail");
            out.print("<br>最终文本抄送人=" + sFinalEmail + "<br>");
            out.print("----1----" + "ck1=" + ck1 + ";ck2=" + ck2 + ";ck3=" + ck3 + ";plandevtime=" + plandevtime + ";plantesttime=" + plantesttime + ";planreleasetime=" + planreleasetime + ";releasetime=" + releasetime + ";devtime=" + dvetime + ";testime=" + testtime + ";remark=" + remark);
            importRequirment.insertImportRequirementInfo(sSubRMId, iRMId, sOpId, bck2, testtime, bck1, dvetime, sFinalEmail, plandevtime, plantesttime, planreleasetime, remark, bck3, releasetime);
        }
    } else if (bImport.equals("false")) {
        String sAddCount = (String) session.getValue("sAddCount");
        session.removeAttribute("sAddCount");
        session.setAttribute("sAddCount", String.valueOf((Integer.parseInt(sAddCount) + 1)));
    } else {

    }
    //  out.print("需求或者故障编号："+sRMId+"<br>");
    String arrRmid[] = sRMId.split(",");  //拆分需求故障转化为字符串数值
    out.print("<br>字符串转化为数值<br>");
    for (int i = 0; i < arrRmid.length; i++)
        out.print(arrRmid[i] + "<br>");


    if (!sRMId.equals("")) {
        out.print("arrRmid.length=" + arrRmid.length + "\n");
        for (int i = 0; i < arrRmid.length; i++) {
            if (i == 0) {
                session.setAttribute("sAddCount", "0");
                session.setAttribute("sFinalAllEmail", sFinalEmail);
                session.setAttribute("sCheckCount", String.valueOf(arrRmid.length));

            }
            int iRMId = arrRmid[i].indexOf("R");
            if (iRMId >= 0)
                iRMId = 1;
            else
                iRMId = 2;
            String sSubRMId = arrRmid[i].substring(1);
            boolean bCheck = false;
            bCheck = importRequirment.checkImportRequirementInfo(sSubRMId, iRMId);
            out.print(sSubRMId + iRMId + "在数据库=" + bCheck);
            if (bCheck == false) //不存在，直接插入数据库
            {
                String sAddCount = (String) session.getValue("sAddCount");
                session.removeAttribute("sAddCount");
                session.setAttribute("sAddCount", String.valueOf((Integer.parseInt(sAddCount) + 1)));
                //将数据插入到重点需求故障表中
                //,boolean sInsertTest,String sTestDate,boolean sInsertDev,String sDevDate,String sEmail
                sFinalEmail = (String) session.getValue("sFinalAllEmail");
                out.print("<br>最终文本抄送人=" + sFinalEmail + "<br>");
                out.print("---2---" + "ck1=" + ck1 + ";ck2=" + ck2 + ";ck3=" + ck3 + ";plandevtime=" + plandevtime + ";plantesttime=" + plantesttime + ";planreleasetime=" + planreleasetime + ";releasetime=" + releasetime + ";devtime=" + dvetime + ";testime=" + testtime + ";getremark=" + getremark);
                importRequirment.insertImportRequirementInfo(sSubRMId, iRMId, sOpId, bck2, testtime, bck1, dvetime, sFinalEmail, plandevtime, plantesttime, planreleasetime, getremark, bck3, releasetime);
            } else     //如果存在，弹出提示窗口
            {
                sRMId = "";
                String sRMid1 = "";  //需要重复插入的需求跟之后的需求故障
                String sRMid2 = "";  //不需要插入的需求故障之后的需求故障
                for (int j = i; j < arrRmid.length; j++) {
                    if (j == i) {
                        sRMid1 = arrRmid[j];
                    } else {
                        sRMid1 = sRMid1 + "," + arrRmid[j];
                        if (j == (i + 1)) {
                            sRMid2 = arrRmid[j];
                        } else {
                            sRMid2 = sRMid2 + "," + arrRmid[j];
                        }
                    }
                }
                out.print("\n新的需求编号=" + sRMId);
%>
<script language=JavaScript>
    var str = new Array();
    <% for(int z=0;z<listArray.length;z++){%>
    str[<%=z%>] = "<%=listArray[z]%>";
    <%}%>

    b = confirm('<%=arrRmid[i]%>已经在数据库存在,确认要插入?');
    if (b == true) {
        window.location = "ImportRequirementManagerdo.jsp?bImport=" + b + "&requirement=<%=sRMid1%>&ck1=<%=ck1%>&dvetime=<%=dvetime%>&ck2=<%=ck2%>&testtime=<%=testtime%>&email=<%=email%>&ck3=<%=ck3%>&releasetime=<%=releasetime%>&PLAN_RELEASE_TIME=<%=planreleasetime%>&PLAN_TEST_TIME=<%=plantesttime%>&PLAN_DEV_TIME=<%=plandevtime%>&list2=" + str;
    }
    else {
        window.location = "ImportRequirementManagerdo.jsp?bImport=" + b + "&requirement=<%=sRMid2%>&ck1=<%=ck1%>&dvetime=<%=dvetime%>&ck2=<%=ck2%>&testtime=<%=testtime%>&email=<%=email%>&ck3=<%=ck3%>&releasetime=<%=releasetime%>&PLAN_RELEASE_TIME=<%=planreleasetime%>&PLAN_TEST_TIME=<%=plantesttime%>&PLAN_DEV_TIME=<%=plandevtime%>&list2=" + str;
    }
</script>
<%
            }
        }
    }
%>
</head>
<%
    String sAddCount = (String) session.getValue("sAddCount");
    String sCheckCount = (String) session.getValue("sCheckCount");
    if (sAddCount.equals(sCheckCount)) {
        session.removeValue("remark");
        response.sendRedirect("ImportRequirementManager.jsp");
    }

%>
<body>
</body>
</html>
