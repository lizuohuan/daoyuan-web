<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/common/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/top.css">
<div class="page-top">
    <a href="<%=request.getContextPath()%>/page/billList"><div class="page-logo"></div></a>
    <div class="page-right personal-data">
        <a id="userName" class="nav-menu" href="#">用户名</a>

        <div class="menu-div">
            <ul class="menu">
                <li><a href="<%=request.getContextPath()%>/page/personData">个人资料</a></li>
                <li><a href="<%=request.getContextPath()%>/page/myBill">我的账单</a></li>
                <li><a href="<%=request.getContextPath()%>/page/changePassword">修改密码</a></li>
                <li><a href="<%=request.getContextPath()%>/page/login">退出</a></li>
            </ul>
        </div>
    </div>
    <div class="page-right contact-us">
        <a class="nav-menu" href="<%=request.getContextPath()%>/page/contactUs">联系我们</a>
    </div>
    <div class="page-right search-bar">
        <input id="searchTop" class="search-input" type="text" placeholder="搜索社保、公积金、工资代发、其他">
        <i class="search-btn" onclick="search()">
            <span class="fa fa-search"></span>
        </i>
    </div>

</div>

<script>

    /**搜索**/
    function search() {
        localStorage.setItem('businessName', document.getElementById('searchTop').value);
        location.href = "<%=request.getContextPath()%>/page/myBill";
    }

</script>
