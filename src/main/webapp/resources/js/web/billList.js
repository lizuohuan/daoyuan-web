new Vue({
    el: '#app',
    data: function (){
        return {
            dataList: [],
            pageNo: 1, //页码
            pageSize: 10,// 每页显示多少条
            totalPage: 0, //总页码
        }
    },
    /**初始化方法**/
    mounted : function (){
        this.getData(1, null, null, null, null, null);
    },
    methods: {
        getData: function (pageNo, billMonth, affirmTime, amount, businessId, businessName) {
            var thas = this;
            config.ajaxRequestData(true, "hrBill/list", {
                pageNo : pageNo,
                pageSize : thas.pageSize,
                billMonth : billMonth,
                affirmTime : affirmTime,
                amount : amount,
                businessId : businessId,
                businessName : businessName,
            }, true, function (result) {
                thas.dataList = result.data;
                thas.totalPage = result.recordsTotal;
            });
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