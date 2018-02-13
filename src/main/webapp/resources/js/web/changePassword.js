new Vue({
    el: '#app',
    data: function() {
        return { visible: false }
    }
})

var submitBtn = function() {
    var oldPwd = $("#oldPwd").val();
    var newPwd = $("#newPwd").val();
    var rNewPwd = $("#rNewPwd").val();
    if (null == oldPwd || $.trim(oldPwd) == "") {
        config.toast("请输入原始密码");
        return;
    }
    if (null == newPwd || $.trim(newPwd) == "") {
        config.toast("请输入新密码");
        return;
    }
    if (null == rNewPwd || $.trim(rNewPwd) == "") {
        config.toast("请再次输入新密码");
        return;
    }
    if (newPwd != rNewPwd) {
        config.toast("两次密码输入不一致");
        return;
    }
    var ary = {
        oldPwd:$.md5(oldPwd),
        newPwd:$.md5(newPwd)
    }
    config.ajaxRequestData(false,"company/updatePwd",ary,true,function(result) {
        config.alert("温馨提示","修改成功","确定",function() {
            window.location.reload();
        });
    });
}