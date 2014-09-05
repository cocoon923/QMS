/**
 * Created by chenmm on 9/2/2014.
 */
$(document).ready(function () {

    var node = "queryTable";

    var buttons = [
        {
            "sExtends": "text",
            "sButtonText": "Query",
            "fnClick": function (nButton, oConfig, oFlash) {
                var data = getSelectRowData("queryTable");
                if (checkData(data) && checkQuery(data[0])) {
                    redirect2DetailPage(data[0].QUERY_ID);
                }
            }
        },
        {
            "sExtends": "text",
            "sButtonText": "Add",
            "fnClick": function (nButton, oConfig, oFlash) {
                $('#addmodal').modal('show');
            }
        },
        {
            "sExtends": "text",
            "sButtonText": "Delete",
            "fnClick": function (nButton, oConfig, oFlash) {
                var data = getSelectRowData(node);
                checkData(data);
                prompt().queryDelete(data[0].QUERY_ID, function delRow(success) {
                    if (success) {
//                        console.log(getSelectRow(node)[0]);
                        getSelectRow(node)[0].remove();
                    }
                });
            }
        }
    ];

    var table = $('#queryTable').DataTable({
        "ajax": 'query',
        "columns": [
            { "data": "QUERY_ID" },
            { "data": "QUERY_NAME" },
            { "data": "QUERY_SQL" },
            { "data": "QUERY_VALID" }
        ],
        "dom": 'T<"clear">t',
        "tableTools": {
            "sRowSelect": "single",
            "aButtons": buttons
        }
    });
});


function getSelectRowData(node) {
    var oTT = TableTools.fnGetInstance(node);
    return oTT.fnGetSelectedData();
}

function getSelectRow(node) {
    var oTT = TableTools.fnGetInstance(node);
    return oTT.fnGetSelected();
}

function checkData(data) {
    if (data.length <= 0) {
        prompt().basic("��ѡ��һ�У�");
        return false;
    } else {
        return true;
    }
}

function redirect2DetailPage(queryId) {
    var url = "Query.Detail.jsp?QUERY_ID=" + queryId;
    window.location = url;
}

function checkQuery(data) {
    var result = data.QUERY_VALID != 0;
    if (!result) {
        prompt().basic("��ѯSQL��Ч��");
    }
    return result;
}

function addRow(table, query) {
    table.row.add(query).draw();
}