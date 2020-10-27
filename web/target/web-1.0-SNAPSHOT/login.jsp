<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tingyu登录页面</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <%-- 设置页面基础路径，以后页面的所有跳转和样式js的引入全部基于这个基础路径 --%>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>

<form id="adminForm" method="post" action="admin/login.do">
    <div style="width: 402px; margin: auto; height: 100%; margin-top: 50px">
        <div class="easyui-panel" title="Ting域主持人系统后台登录界面" style="width: 400px; padding: 30px 50px">
            <span style="color: red">${errorMsg}</span>
            <div style="width: 100%">
                <input class="easyui-textbox" style="height:40px; width:100%" name="aname" required
                       data-options="missingMessage:'账号不能为空',label:'账号:',labelWidth:40,prompt:'请输入登录账号'">
            </div>

            <div style="margin-top: 30px; width: 100%">
                <input class="easyui-passwordbox" style="height:40px;width:100%" name="apwd" required
                       data-options="missingMessage:'密码不能为空',label:'密码:',labelWidth:40,prompt:'请输入登录密码'">
            </div>

            <div style="margin-top: 30px; width: 100%">
                <a onclick="loginFun()" href="javascript:void(0)" style="height:40px; width:100%"
                   class="easyui-linkbutton">登录</a>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">

    function loginFun() {
        // 校验表单
        // validate: 进行表单字段验证，当全部字段都有效时返回true
        var isValid = $("#adminForm").form('validate');
        if (isValid) {
            // submit()方法会把数据提交过去后端
            $("#adminForm").submit();
        }
    }

</script>

</body>
</html>
