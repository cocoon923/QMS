/**
 * Created by chenmm on 9/2/2014.
 */
$(document).ready(function () {
    $('#queryTable').DataTable({
        "ajax": 'query',
        "columns": [
            { "data": "QUERY_ID" },
            { "data": "QUERY_NAME" },
            { "data": "QUERY_SQL" },
            { "data": "QUERY_VALID" }
        ],
        "dom": 'T<"clear">t',
        tableTools: {
            "sRowSelect": "single",
            "aButtons": [
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

                    }
                },
                {
                    "sExtends": "text",
                    "sButtonText": "Delete",
                    "fnClick": function (nButton, oConfig, oFlash) {
                        var data = getSelectRowData("queryTable");
                        checkData(data);
                    }
                }
            ]
        }
    });
});


function getSelectRowData(node) {
    var oTT = TableTools.fnGetInstance(node);
    return oTT.fnGetSelectedData();
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
    var url = "Query.Detail.jsp?QUERY_ID=" + queryId;
    window.location = url;
}

function checkQuery(data) {
    var result = data.QUERY_VALID != 0;
    if (!result) {
        prompt().basic("查询SQL无效！");
    }
    return result;
}