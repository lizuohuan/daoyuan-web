new Vue({
    el: '#app',
    data: {
        account: null,
        pwd: null,
    },
    methods: {
        /**登录验证**/
        loginCheck : function () {
            var _node = this;
            if (_node.account == null || _node.account == "") {
                $(".error-info").addClass("error-info-show").html("请输入企业名");
                return false;
            }
            if (_node.pwd == null || _node.pwd == "") {
                $(".error-info").addClass("error-info-show").html("请输入密码");
                return false;
            }
            config.ajaxRequestData(true, "company/login", {
                account : _node.account,
                pwd : $.md5(_node.pwd)
            }, false, function (result) {
                if (result.code == 200) {
                    localStorage.setItem("userInfo", JSON.stringify(result.data));
                    location.href = config.ip + "page/billList";
                }
                else {
                    $(".error-info").addClass("error-info-show").html(result.msg);
                }
            });
        }
    }
})