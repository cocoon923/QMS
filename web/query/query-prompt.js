/**
 * Created by chenmm on 9/3/2014.
 */

function prompt() {

    function basic(message) {
        $.prompt(message);
    }

    function queryDelete(queryId, delRow) {
        $.prompt("是否删除该查询？", {
//            title: "是否删除该查询？",
            buttons: { "是": true, "否": false },
            submit: function (e, v, m, f) {
                if (v) {
                    $.ajax({
                        type: "get",
                        url: "delete/" + queryId,
                        success: function (data, status) {
                            delRow(data);
                        }
                    });
                }
            }
        });
    }

    return {"basic": basic, "queryDelete": queryDelete};
}