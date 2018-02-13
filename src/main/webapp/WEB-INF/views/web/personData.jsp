<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人资料</title>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/logo-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/personData.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css">
</head>
<body>
<%@include file="top.jsp" %>
<div id="web" class="app-content" v-cloak>
    <div class="personData-icon"></div>
    <div class="personData-title">个人资料</div>
    <div class="from-data">
        <div class="from-item">
            <label>公司全称：</label>
            <input type="text" id="companyName" v-model="company.companyName" placeholder="请输入公司全称">
        </div>
        <div class="from-item">
            <label>行业：</label>
            <select id="tradeId" v-model="selected" class="from-input">
                <option v-for="trade in trades" :value="trade.id">{{trade.tradeName}}</option>
            </select>
        </div>
        <span v-for="contacts in company.contactsList">
            <div class="from-item">
                <label>联系人名称</label>
                <input class="contactsName" type="text" id="contactsName" v-model="contacts.contactsName" placeholder="请输入联系人名称">
            </div>
        <div class="from-item">
            <label>联系电话</label>
            <input class="phone" type="text" id="phone" v-model="contacts.phone" placeholder="请输入联系电话">
        </div>
        <input class="contactsId" id="contactsId" v-model="contacts.id" style="display: none;">
        </span>
        <div class="from-item">
            <label></label>
            <button class="submitBtn" onclick="submitBtn()">确认修改</button>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/vue.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/web/personData.js"></script>
<%@include file="bottom.jsp" %>
</body>
</html>