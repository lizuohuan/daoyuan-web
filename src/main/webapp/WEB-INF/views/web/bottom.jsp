<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/bottom.css">
<div class="page-bottom">
    <div class="bottom-font">
        <p>Copyright&nbsp;&copy;&nbsp;2017成都魔豆科技有限公司&nbsp;版权所有</p>
        <p>川ICP备16041101号-1</p>
    </div>
</div>

<script>
    $("#userName").html(config.getUserInfo().companyName);
</script>