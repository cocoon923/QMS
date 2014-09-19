/**
 * Created by chenmm on 9/10/2014.
 */

$('#back').on('click', function () {
    window.location = "Query.Index.jsp";
})

$(document).ready(function () {
    var typeStr = types.join("|");
    if (typeStr.indexOf("table") >= 0) {
        $('#tableChart').dataTable({
            "ajax": "../chart/tableData?QUERY_ID=" + queryId,
            "columns": tableOption.columns,
            "dom": 'CT<"clear">ft',
            colVis: {
                showAll: "全选",
                showNone: "全不选"
            },
            "tableTools": {
                "sSwfPath": "../datatables/swf/copy_csv_xls.swf",
                "aButtons": [
                    {
                        "sExtends": "text",
                        "sButtonText": "Delete",
                        "fnClick": function (nButton, oConfig, oFlash) {
                            alert("Delete TableChart");
                        }
                    },
                    {
                        "sExtends": "xls",
                        "sButtonText": "导出",
                        "mColumns": "visible",
                        "bFooter": false
                    }
                ]
            }
        });
    }
    if (typeStr.indexOf("pie") >= 0) {
        $.ajax({
            url: "../chart/pieData?QUERY_ID=" + queryId,
            dataType: 'json',
            type: 'post',
            cache: false,
            success: function (data) {
                new Highcharts.Chart(data.records[0]);
            }
        });
    }
    if (typeStr.indexOf("bar") >= 0) {
        $.ajax({
            url: "../chart/barData?QUERY_ID=" + queryId,
            dataType: 'json',
            type: 'post',
            cache: false,
            success: function (data) {
                new Highcharts.Chart(data.records[0]);
            }
        });
    }
    if (typeStr.indexOf("line") >= 0) {
        $.ajax({
            url: "../chart/lineData?QUERY_ID=" + queryId,
            dataType: 'json',
            type: 'post',
            cache: false,
            success: function (data) {
                new Highcharts.Chart(data.records[0]);
            }
        });
    }
});