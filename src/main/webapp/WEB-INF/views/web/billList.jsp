<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/logo-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/billList.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css">


</head>
<body>
    <%@include file="top.jsp" %>
    <div id="app" class="app-content">
        <div class="content">
            <div class="table-list" v-cloak>
                <table class="bill-list">
                    <thead>
                        <tr>
                            <th>账单号</th>
                            <th width="300px">办理进度</th>
                            <th width="60px">时间</th>
                            <th>业务类型</th>
                            <th>账单金额</th>
                            <th>付款信息</th>
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
            <div class="company-info flipInY animated">
                <div class="company-logo"></div>
                <div class="company-name">魔豆互动科技有限公司</div>
                <div class="company-hint">互联网、APP外包</div>
                <div class="company-person">联系人：嘻哈哈</div>
                <div class="company-phone">联系电话：13556465464</div>
                <div class="company-introduce">
                    阿斯蒂发打手犯规代发阿斯蒂芬个打手犯规是大法官电饭锅第三个是大法官大发生过首付个打手犯规
                    阿斯蒂发打手犯规代发阿斯蒂芬个打手犯规是大法官电饭锅第三个是大法官大发生过首付个打手犯规
                    阿斯蒂发打手犯规代发阿斯蒂芬个打手犯规是大法官电饭锅第三个是大法官大发生过首付个打手犯规
                    阿斯蒂发打手犯规代发阿斯蒂芬个打手犯规是大法官电饭锅第三个是大法官大发生过首付个打手犯规
                </div>
            </div>
        </div>
    </div>

    <script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/vue.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/web/billList.js"></script>
    <%@include file="bottom.jsp" %>

</body>
</html>
