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
    <link rel="stylesheet" type="text/css" href="../datatables/css/dataTables.tableTools.css">
    <link rel="stylesheet" type="text/css" href="../bootstrap/bootstrapV2.css">
    <link rel="stylesheet" type="text/css" href="../impromptu/themes/base.css">
    <link rel="stylesheet" type="text/css" href="../impromptu/jquery-impromptu.css">

    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">

    <%@ page contentType="text/html; charset=gb2312" %>

    <title>��ѯͳ������</title>

    <link href="../css/rightstyle.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="queryTable" class="display" cellspacing="0" width="100%">
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

<div id="addmodal" class="modal hide fade" tabindex="-1" data-focus-on="input:first" data-backdrop="static">
    <div class="modal-header">
        <button type="button" id="close" class="close" aria-hidden="true">��</button>
        <h3>������ѯ��</h3>
    </div>
    <form id="addform">
        <div class="modal-body">
            <div class="control-group">
                <label class="control-label" for="queryName">��ѯ����</label>

                <div class="controls">
                    <input type="text" class="input-xlarge add" id="queryName" required/>

                    <p class="help-block"></p>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">��ѯSQL</label>

                <div class="controls">
                    <input type="textarea" class="input-xlarge add" id="querySql" required
                           data-validation-ajax-ajax="validate"/>

                    <p class="help-block"></p>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn" id="cancel">ȡ��</button>
            <button type="submit" class="btn btn-primary">��¼</button>
        </div>
    </form>
</div>

<script src="../datatables/js/jquery.js"></script>
<script src="../datatables/js/jquery.dataTables.js"></script>
<script src="../datatables/js/dataTables.tableTools.js"></script>
<script src="../impromptu/jquery-impromptu.js"></script>
<script src="../bootstrap/bootstrapV2.js"></script>
<script src="../bootstrap/js/jqBootstrapValidation.js"></script>
<script src="query-add.js"></script>
<script src="query-prompt.js"></script>
<script src="query.js"></script>
</body>
</html>
                
