/**
 * Created by chenmm on 9/10/2014.
 */

$('#back').on('click', function () {
    window.location = "Query.Index.jsp";
})

$(document).ready(function () {
    if (hasTable) {
        $('#tableChart').dataTable({
            "ajax": "../chart/tableData?QUERY_ID=" + queryId,
            "columns": tableOption.columns,
            "dom": 'T<"clear">t',
            "tableTools": {
                "aButtons": [
                    {
                        "sExtends": "text",
                        "sButtonText": "Delete",
                        "fnClick": function (nButton, oConfig, oFlash) {dsa
                            alert("Delete TableChart");
                        }
                    }
                ]
            }
        });
    }
});