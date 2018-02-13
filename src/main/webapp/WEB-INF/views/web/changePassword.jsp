<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/logo-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/changePassword.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css">
</head>
<body>
<%@include file="top.jsp" %>
<div id="app" class="app-content">
    <div class="change-password-icon"></div>
    <div class="change-password-title">修改密码</div>
    <div class="black">账号：134156454612</div>
    <div class="from-data">
        <div class="from-item">
            <label>原始密码：</label>
            <input type="password" id="oldPwd" placeholder="请输入原始密码">
        </div>
        <div class="from-item">
            <label>新密码：</label>
            <input type="password" id="newPwd" placeholder="密码由数字、字母xx位组成">
        </div>
        <div class="from-item">
            <label></label>
            <input type="password" id="rNewPwd" placeholder="再次输入相同密码">
        </div>
        <div class="from-item">
            <label></label>
            <button class="submitBtn" onclick="submitBtn()">确认修改</button>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/vue.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jQuery.md5.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/web/changePassword.js"></script>
<%@include file="bottom.jsp" %>

</body>
</html>