<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/logo-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myBill.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css">
    <script src="<%=request.getContextPath()%>/resources/laydate/laydate.js"></script>

</head>
<body>
    <%@include file="top.jsp" %>
    <div id="app" class="app-content">
        <div class="content">
            <div class="title">我的账单</div>
            <div class="screen">
                <i></i>
                <span>筛选</span>
            </div>
            <div class="screenCondition">
                <div class="item">
                    <div class="from-label">业务类型：</div>
                    <label class="radio-label">
                        <input type="radio" name="type" value="3" class="fa my-radio" v-model="businessId">
                        社保
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="type" value="4" class="fa my-radio" v-model="businessId">
                        公积金
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="type" value="5" class="fa my-radio" v-model="businessId">
                        工资代发
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="type" value="" class="fa my-radio" v-model="businessId" checked>
                        不限
                    </label>
                </div>
                <div class="item">
                    <div class="from-label text-align-right">月份：</div>
                    <input type="text" id="billMonth" class="from-input" placeholder="请选择月份" readonly>
                    <div class="from-label text-align-right">确认时间：</div>
                    <input type="text" id="affirmTime" class="from-input" placeholder="请选择确认时间" readonly>
                    <div class="from-label text-align-right">账单金额：</div>
                    <input type="text" class="from-input" placeholder="请输入账单金额" v-model="amount">
                </div>
                <div class="item">
                    <button class="affirm-btn" @click="screen">确认筛选</button>
                </div>
            </div>
            <div class="table-list" v-cloak>
                <table class="bill-list">
                    <thead>
                    <tr>
                        <th width="80px">账单号</th>
                        <th width="350px">办理进度</th>
                        <th width="60px">时间</th>
                        <th width="80px">业务类型</th>
                        <th width="80px">账单金额</th>
                        <th width="80px">付款信息</th>
                        <th width="80px">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="data in dataList">
                        <td>{{data.billNumber == null ? "--" : data.billNumber}}</td>
                        <td>
                            <div v-if="data.cstbStatus == 0" class="plan" style="background: url(<%=request.getContextPath()%>/resources/img/plan-1.png);"></div>
                            <div v-if="data.cstbStatus == 1 && data.isConfirmFund != 1" class="plan" style="background: url(<%=request.getContextPath()%>/resources/img/plan-2.png);"></div>
                            <div v-if="data.cstbStatus == 1 && data.isConfirmFund == 1 && data.isMakeBill != 1" class="plan" style="background: url(<%=request.getContextPath()%>/resources/img/plan-3.png);"></div>
                            <div v-if="data.cstbStatus == 1 && data.isConfirmFund == 1 && data.isMakeBill == 1 && data.isSend != 1" class="plan" style="background: url(<%=request.getContextPath()%>/resources/img/plan-4.png);"></div>
                            <div v-if="data.cstbStatus == 1 && data.isConfirmFund == 1 && data.isMakeBill == 1 && data.isSend == 1" class="plan" style="background: url(<%=request.getContextPath()%>/resources/img/plan-5.png);"></div>
                        </td>
                        <td>{{data.billMonth | formatDate}}</td>
                        <td>{{data.businessStr}}</td>
                        <td>￥{{data.amount == null ? 0 : data.amount}}</td>
                        <td>
                            <p>银行卡号:{{data.bankAccount == null ? "--" : data.bankAccount}}</p>
                            <p>开户名:{{data.accountName == null ? "--" : data.accountName}}</p>
                            <p>开户行:{{data.bankName == null ? "--" : data.bankName}}</p>
                        </td>
                        <td>
                            <button class="list-small-btn">查看物流</button>
                            <%--<span class="notHave">无</span>--%>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr><td v-if="dataList.length == 0" colspan="999" class="not-data">暂无数据</td></tr>
                    </tfoot>
                </table>

                <div class="paging">
                    <span v-if="pageNo > 1" class="up" @click="upPage">上一页</span>
                    <span v-if="pageNo == 1" class="up paging-disabled">上一页</span>
                    <span v-if="pageNo < totalPage" class="next" @click="nextPage">下一页</span>
                    <span v-if="totalPage == 1 || pageNo == totalPage || totalPage == 0" class="next paging-disabled">下一页</span>
                </div>
            </div>
        </div>
    </div>
    <script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/vue.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/web/myBill.js"></script>
    <%@include file="bottom.jsp" %>

</body>
</html>
