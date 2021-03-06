/**
 * Created by chenmm on 9/5/2014.
 */

$(function () {
    $('#close,#cancel').click(function () {
        $('#addmodal').modal('hide');
    });
});

$(function () {
    $("input.add,select.add,textarea.add").not("[type=submit]").jqBootstrapValidation({
        submitSuccess: function ($form, event) {
            event.preventDefault();
            doQueryAdd();
        }
    });

    function doQueryAdd() {
        var queryName = $("#queryName").val();
        var querySql = $("#querySql").val();
        $.ajax({
            url: 'add',
            dataType: 'json',
            type: 'post',
            cache: false,
            data: {
                QUERY_NAME: queryName,
                QUERY_SQL: querySql,
                QUERY_VALID: 1
            },
            success: function (data) {
                if (data) {
                    location.href = 'Query.Index.jsp';
                } else {
                    alert('查询新建失败');
                }
            }
        });
    }
});