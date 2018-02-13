new Vue({
    el: '#app',
    data: function() {
        return { content: "" }
    },
    methods: {
        submitBtn: function () {
            var thas = this;
            if (null == thas.content || $.trim(thas.content) == "") {
                config.alert("温馨提示","请输入联系内容","确定",function() {});
                return;
            }
            config.ajaxRequestData(false,"suggest/submitSuggest",{content: thas.content},true,function(result) {
                config.alert("温馨提示","提交成功","确定",function() {
                    window.location.reload();
                });
            });
        }
    }
})
