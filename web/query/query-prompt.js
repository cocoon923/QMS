/**
 * Created by chenmm on 9/3/2014.
 */

function prompt() {

    function basic(message) {
        $.prompt(message);
    }

    function queryDelete(queryId, delRow) {
        $.prompt("�Ƿ�ɾ���ò�ѯ��", {
//            title: "�Ƿ�ɾ���ò�ѯ��",
            buttons: { "��": true, "��": false },
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