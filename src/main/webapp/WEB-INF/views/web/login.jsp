<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <meta charset="UTF-8">
    <meta name="Keywords" content="道远,四川省道远人力资源管理有限公司,人事">
    <meta name="Description" content="道远,四川省道远人力资源管理有限公司,人事">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/logo-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/login.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css">

</head>
<body>
<div id="app" class="login-div flipInX animated">
    <div class="login-title">欢迎登录</div>
    <p class="login-hint">四川省道远人力资源管理有限公司</p>
    <div class="error-info">账号或密码错误!</div>
    <div class="userNameDiv">
        <i></i>
        <input type="text" placeholder="请输入企业名" class="userName" v-model="account" @keyup.enter="loginCheck">
    </div>
    <div class="userPasswordDiv">
        <i></i>
        <input type="password" placeholder="请输入密码" class="userPassword" v-model="pwd" @keyup.enter="loginCheck">
    </div>
    <button class="loginBtn" @click="loginCheck">登录</button>
    <div class="forgetThePassword">
        <a href="#">忘记密码？</a>
    </div>
</div>
</body>

<script src="<%=request.getContextPath()%>/resources/js/vue.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jQuery.md5.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/web/login.js"></script>

</html>