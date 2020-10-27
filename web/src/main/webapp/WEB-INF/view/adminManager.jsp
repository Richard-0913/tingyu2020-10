<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
    <script type="text/javascript" src="static/jquery.serializejson/jquery.serializejson.min.js"></script>
</head>
<body>

<table id="adminDataGrid" fit="true"></table>

<script type="text/javascript">

    /* marriedManagerDataGrid */
    $(function () {
        $("#adminDataGrid").datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: true,
            singleSelect: true,
            striped: true,  // 是否显示斑马线效果。
            url: 'admin/list.do',

            columns: [[
                {field: 'aid', checkbox: true},
                {field: 'aname', title: '姓名', width: 100},
                {field: 'aphone', title: '手机号', width: 100},
                {
                    field: 'starttime', title: '开通时间', width: 200, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth +" "+
                            value.hour + ":" + value.minute + ":" + value.second;
                    }
                },
                // {field: 'rname', title: '权限', width: 100},
            ]]
        });
    });

</script>

</body>
</html>
