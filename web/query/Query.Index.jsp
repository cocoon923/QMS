<%@include file="../allcheck.jsp" %>

<%@ page contentType="text/html; charset=gb2312" language="java" %>

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
    <link rel="stylesheet" type="text/css" href="../datatables/css/jquery.dataTables.css">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">

    <%@ page contentType="text/html; charset=gb2312" %>

    <title>��ѯͳ������</title>

    <link href="../css/rightstyle.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="query" class="display" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>��ѯID</th>
        <th>��ѯ����</th>
        <th>��ѯSQL</th>
        <th>�Ƿ���Ч</th>
    </tr>
    </thead>

    <tfoot>
    <tr>
        <th>��ѯID</th>
        <th>��ѯ����</th>
        <th>��ѯSQL</th>
        <th>�Ƿ���Ч</th>
    </tr>
    </tfoot>
</table>

<script src="../datatables/js/jquery.js"></script>
<script src="../datatables/js/jquery.dataTables.js"></script>

<script>

    $(document).ready(function () {
        $('#query').DataTable({
            "ajax": '../ajax/data/arrays.txt',
            "dom": 'lfrtip'
        });
    });

</script>
</body>
</html>
                
