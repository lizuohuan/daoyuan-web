new Vue({
    el: '#app',
    data: function (){
        return {
            dataList: [],
            pageNo: 1, //页码
            pageSize: 10,// 每页显示多少条
            totalPage: 0, //总页码
            billMonth: null,// 账单月
            affirmTime: null,// 确认时间
            amount: null,// 确认时间
            businessId: null, //业务类型ID
        }
    },
    /**初始化方法**/
    mounted : function (){
        this.getData(1, localStorage.getItem("businessName"));
        localStorage.removeItem("businessName");
    },
    methods: {
        getData: function (pageNo, businessName) {
            var thas = this;
            config.ajaxRequestData(true, "hrBill/list", {
                pageNo : pageNo,
                pageSize : thas.pageSize,
                billMonth : $("#billMonth").val() == "" ? null : config.getTimeStamp($("#billMonth").val()),
                affirmTime : $("#affirmTime").val() == "" ? null : config.getTimeStamp($("#affirmTime").val()),
                amount : thas.amount,
                businessId : thas.businessId,
                businessName : businessName,
            }, true, function (result) {
                thas.dataList = result.data;
                thas.totalPage = result.recordsTotal;
            });
        },
        /**筛选**/
        screen: function () {
            this.pageNo = 1;
            this.getData(this.pageNo, null);
        },
        /**上一页**/
        upPage: function () {
            if (this.pageNo > 1) {
                this.pageNo --;
            }
            this.getData(this.pageNo, null, null, null, null, null);
        },
        /**下一页**/
        nextPage: function () {
            if (this.pageNo < this.totalPage) {
                this.pageNo ++;
            }
            this.getData(this.pageNo, null, null, null, null, null);
        }
    },
    filters: {
        formatDate : function (time) {
            return new Date(time).format("MM月");
        }
    }
})

laydate.render({
    elem: '#billMonth'
    ,type: 'month'
});

laydate.render({
    elem: '#affirmTime'
});