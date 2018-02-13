<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>联系我们</title>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/logo-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/contactUs.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css">
</head>
<body>
<%@include file="top.jsp" %>
<div id="app" class="app-content">
    <div class="contact-us-icon"></div>
    <div class="contact-us-title">联系我们</div>
    <div class="contact-us-hint">如果您有任何疑问，请通过以下方式联系我们，我们将真诚为您服务</div>
    <div class="contact-us-phone">
        <i class="phone-icon icon-1"></i>
        <span class="gray">客服电话：</span>
        <span class="black">028-6666 8888</span>
    </div>
    <div class="contact-us-phone">
        <i class="phone-icon icon-2"></i>
        <span class="gray">联系地址：</span>
        <span class="black">四川省成都市高新区天府二街138号蜀都中心二期1号楼3单元1702</span>
    </div>
    <div class="contact-us-phone">
        <i class="phone-icon icon-3"></i>
        <span class="gray">QQ：</span>
        <span class="black">1886666789</span>
    </div>
    <div class="contact-us-phone">
        <i class="phone-icon icon-4"></i>
        <span class="gray">投诉电话：</span>
        <span class="black">028-666 8889</span>
    </div>
    <div class="complaint">
        <div class="complaint-title">意见反馈</div>
        <textarea class="complaint-textarea" v-model="content" placeholder="请在这里写下您的意见/建议"></textarea>
    </div>
    <div class="submit-div">
        <button class="submitBtn" @click="submitBtn" >提交</button>
    </div>
</div>
<script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/vue.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/web/contactUs.js"></script>
<%@include file="bottom.jsp" %>

</body>
</html>