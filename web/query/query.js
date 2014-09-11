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
                        getSelectRow(node)[0].remove();
                    }
                });
            }
        }
    ];

    $('#queryTable').DataTable({
        "ajax": 'query',
        "autoWidth": false,
        "columns": [
            { "data": "QUERY_ID" },
            { "data": "QUERY_NAME"},
            { "data": "QUERY_SQL", "width": "50%" },
            { "data": "QUERY_VALID"}
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
        prompt().basic("请选择一行！");
        return false;
    } else {
        return true;
    }
}

function redirect2DetailPage(queryId) {
    window.location = "detail?QUERY_ID=" + queryId;
//    window.location = "Query.Detail.html?QUERY_ID=" + queryId;
}

function checkQuery(data) {
    var result = data.QUERY_VALID != 0;
    if (!result) {
        prompt().basic("查询SQL无效！");
    }
    return result;
}