var web = new Vue({
    el:"#web",
    data: {
        company: [],
        trades:[],
        selected:""
    },
    methods: {
        getCompanyInfo : function () {
            var _self = this;
            config.ajaxRequestData(false, "company/infoAndContactsList", {}, true, function (result) {
                _self.company = result.data;
                _self.selected = _self.company.tradeId;
            });
        },
        getTrades : function () {
            var _self = this;
            config.ajaxRequestData(false, "trade/queryAllTrade", {}, true, function (result) {
                _self.trades = result.data;

            });
        }
    }
});
web.getCompanyInfo();
web.getTrades();

var submitBtn = function () {
    var contactsName = [];
    var phone = [];
    var contactsId = [];
    $(".contactsName").each(function() {
        contactsName.push($(this).val());
    });
    var flag = true;
    $(".phone").each(function() {
        if (!config.isMobile.test($(this).val())) {
            flag = false;
        }
        phone.push($(this).val());
    });
    if (!flag) {
        config.toast("联系电话格式错误");
        return;
    }
    $(".contactsId").each(function() {
        contactsId.push($(this).val());
    });

    var contactJsonArr = [];
    for (var i = 0 ; i < contactsName.length ; i ++) {
        var contactJsonArrItem = {
            contactsName:contactsName[i],
            phone:phone[i],
            id:contactsId[i]
        }
        contactJsonArr.push(contactJsonArrItem);
    }
    console.log(contactJsonArr);
    var ary = {
        contactJsonArr:JSON.stringify(contactJsonArr),
        companyName:$("#companyName").val(),
        tradeId:$("#tradeId").val()
    }
    config.ajaxRequestData(false, "company/updateAndContacts", ary, true, function (result) {
        config.alert("温馨提示","修改成功","确定",function() {
            window.location.reload();
        });
    });
}