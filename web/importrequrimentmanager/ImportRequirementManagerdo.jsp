<%@ page contentType="text/html; charset=gb2312" language="java" %>
<jsp:useBean id="importRequirment" scope="page" class="dbOperation.ImportRequriment"/>
<%
    request.setCharacterEncoding("gb2312");
%>
<html>
<head>

<title>�ص��������¼�봦��ҳ��</title>
<%
    String bImport = request.getParameter("bImport");
    out.print("bImport=" + bImport);
    if (bImport == null)
        bImport = "";

    String sOpId = (String) session.getValue("OpId");
    out.print("��½�û�=" + sOpId + "<br>");
    String sRMId = request.getParameter("requirement");  //��ȡ������ϱ��

    String ck1 = request.getParameter("ck1");  //��ȡ�Ƿ�ѡ��ƻ��ύʱ��
    boolean bck1 = false;
    if (ck1 == null)
        ck1 = "";
    if (ck1.equals("1")) {
        bck1 = true;
    }
    String dvetime = request.getParameter("dvetime");//��ȡ�����ύ����ʱ��
    String plandevtime = request.getParameter("PLAN_DEV_TIME");//��ȡ�����ύ����ʱ��;
    if (dvetime == null) dvetime = "";
    if (plandevtime == null) plandevtime = "";

    String ck2 = request.getParameter("ck2");//��ȡ�Ƿ�ѡ��ƻ�����ʱ��
    boolean bck2 = false;
    if (ck2 == null)
        ck2 = "";
    if (ck2.equals("1")) {
        bck2 = true;
    }
    String testtime = request.getParameter("testtime");//��ȡ��������ʱ��
    String plantesttime = request.getParameter("PLAN_TEST_TIME");//��ȡ��������ʱ��
    if (testtime == null) testtime = "";
    if (plantesttime == null) plantesttime = "";


    String ck3 = request.getParameter("ck3");//��ȡ�Ƿ�ѡ�񷢲�ʱ��
    boolean bck3 = false;
    if (ck3 == null)
        ck3 = "";
    if (ck3.equals("1")) {
        bck3 = true;
    }
    String releasetime = request.getParameter("releasetime");//��ȡ��������ʱ��
    String planreleasetime = request.getParameter("PLAN_RELEASE_TIME");//��ȡ��������ʱ��
    if (releasetime == null) releasetime = "";
    if (planreleasetime == null) planreleasetime = "";

    String getremark = request.getParameter("remark");//��ȡ��ע��Ϣ
    if (getremark == null) getremark = "";
    String remark = (String) session.getValue("remark");
    if (remark == null) remark = "";
    if (remark.equals("")) {
        session.setAttribute("remark", getremark);
    }


    out.print("ck1=" + ck1 + ";ck2=" + ck2 + ";ck3=" + ck3 + ";plandevtime=" + plandevtime + ";plantesttime=" + plantesttime + ";planreleasetime=" + planreleasetime + ";releasetime=" + releasetime + ";devtime=" + dvetime + ";testime=" + testtime + ";getremark=" + getremark);

    String email = request.getParameter("email");//��ȡ�ı�������
    if (email == null) email = "";
    String[] listArray = (String[]) request.getParameterValues("list2");  //��ȡ������
    out.print("<br>��ȡ������ϱ��=" + sRMId + "<br>");
    out.print("<br>��ȡ�Ƿ�ѡ��ƻ��ύʱ��=" + ck1 + "<br>");
    out.print("<br>��ȡ�����ύ����ʱ��=" + dvetime + "<br>");
    out.print("<br>��ȡ�Ƿ�ѡ��ƻ�����ʱ��=" + ck2 + "<br>");
    out.print("<br>��ȡ��������ʱ��=" + testtime + "<br>");
    out.print("<br>��ȡ�ı�������=" + email + "<br>");
    //    if(listArray.length>0)
    //    {
    //      for(int i=0;i<listArray.length;i++)
    //        out.print(listArray[i]);
    //    }
    String sFinalEmail = "";
    sFinalEmail = email;
    //��������
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
    // out.print("<br>�����ı�������="+sFinalEmail+"<br>");
    if (sRMId != null && sRMId != "")
        sRMId = sRMId.toUpperCase();
    if (sRMId == null)
        sRMId = "";

    if (bImport.equals("true"))   //���ظ���ʱ����Ҫ����Ĵ���
    {
        String sAddCount = (String) session.getValue("sAddCount");
        session.removeAttribute("sAddCount");
        session.setAttribute("sAddCount", String.valueOf((Integer.parseInt(sAddCount) + 1)));
        if (!sRMId.equals("")) {
            String arrRmid1[] = sRMId.split(",");
            sRMId = "";
            for (int k = 1; k < arrRmid1.length; k++)  //���´���sRMId����ȡ��Ҫ�ظ������������߹���������������
            {
                if (k == 1) {
                    sRMId = arrRmid1[k];
                } else {
                    sRMId = sRMId + "," + arrRmid1[k];
                }
            }

            //���ظ���������ϲ��뵽����
            int iRMId = arrRmid1[0].indexOf("R");
            if (iRMId >= 0)
                iRMId = 1;
            else
                iRMId = 2;
            String sSubRMId = arrRmid1[0].substring(1);
            sFinalEmail = (String) session.getValue("sFinalAllEmail");
            out.print("<br>�����ı�������=" + sFinalEmail + "<br>");
            out.print("----1----" + "ck1=" + ck1 + ";ck2=" + ck2 + ";ck3=" + ck3 + ";plandevtime=" + plandevtime + ";plantesttime=" + plantesttime + ";planreleasetime=" + planreleasetime + ";releasetime=" + releasetime + ";devtime=" + dvetime + ";testime=" + testtime + ";remark=" + remark);
            importRequirment.insertImportRequirementInfo(sSubRMId, iRMId, sOpId, bck2, testtime, bck1, dvetime, sFinalEmail, plandevtime, plantesttime, planreleasetime, remark, bck3, releasetime);
        }
    } else if (bImport.equals("false")) {
        String sAddCount = (String) session.getValue("sAddCount");
        session.removeAttribute("sAddCount");
        session.setAttribute("sAddCount", String.valueOf((Integer.parseInt(sAddCount) + 1)));
    } else {

    }
    //  out.print("������߹��ϱ�ţ�"+sRMId+"<br>");
    String arrRmid[] = sRMId.split(",");  //����������ת��Ϊ�ַ�����ֵ
    out.print("<br>�ַ���ת��Ϊ��ֵ<br>");
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
            out.print(sSubRMId + iRMId + "�����ݿ�=" + bCheck);
            if (bCheck == false) //�����ڣ�ֱ�Ӳ������ݿ�
            {
                String sAddCount = (String) session.getValue("sAddCount");
                session.removeAttribute("sAddCount");
                session.setAttribute("sAddCount", String.valueOf((Integer.parseInt(sAddCount) + 1)));
                //�����ݲ��뵽�ص�������ϱ���
                //,boolean sInsertTest,String sTestDate,boolean sInsertDev,String sDevDate,String sEmail
                sFinalEmail = (String) session.getValue("sFinalAllEmail");
                out.print("<br>�����ı�������=" + sFinalEmail + "<br>");
                out.print("---2---" + "ck1=" + ck1 + ";ck2=" + ck2 + ";ck3=" + ck3 + ";plandevtime=" + plandevtime + ";plantesttime=" + plantesttime + ";planreleasetime=" + planreleasetime + ";releasetime=" + releasetime + ";devtime=" + dvetime + ";testime=" + testtime + ";getremark=" + getremark);
                importRequirment.insertImportRequirementInfo(sSubRMId, iRMId, sOpId, bck2, testtime, bck1, dvetime, sFinalEmail, plandevtime, plantesttime, planreleasetime, getremark, bck3, releasetime);
            } else     //������ڣ�������ʾ����
            {
                sRMId = "";
                String sRMid1 = "";  //��Ҫ�ظ�����������֮����������
                String sRMid2 = "";  //����Ҫ������������֮����������
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
                out.print("\n�µ�������=" + sRMId);
%>
<script language=JavaScript>
    var str = new Array();
    <% for(int z=0;z<listArray.length;z++){%>
    str[<%=z%>] = "<%=listArray[z]%>";
    <%}%>

    b = confirm('<%=arrRmid[i]%>�Ѿ������ݿ����,ȷ��Ҫ����?');
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
