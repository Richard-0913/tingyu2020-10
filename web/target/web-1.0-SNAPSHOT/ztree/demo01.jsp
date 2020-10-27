<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <%-- 设置页面基础路径，以后页面的所有跳转和样式js的引入全部基于这个基础路径 --%>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/ztree/css/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.core.js"></script>
</head>
<body>

<ul id="treeDemo" class="ztree"></ul>

<script type="text/javascript">
    /* zTree的设置对象,配置zTree的初始化信息 */
    var setting = {
        /* 数据初始化配置 */
        data: {
            /* 支持简单数据 */
            simpleData:{
                enable:true,
                idKey:"mid",
                pIdKey:"pid",
            },
            key:{
                name:"mname"
            }
        }
    };

    var zNodes = [
        {
            "mid": 1,
            "mname": "成员管理",
            "pid": 0,
            "isparent": "1",
            "status": "0",
            "url": null,
            "mdesc": "一级菜单"
        },
        {
            "mid": 5,
            "mname": "主持人管理",
            "pid": 1,
            "isparent": "1",
            "status": "0",
            "url": "host/hostManager.do",
            "mdesc": "二级菜单"
        },
        {
            "mid": 6,
            "mname": "婚庆公司管理",
            "pid": 1,
            "isparent": "0",
            "status": "0",
            "url": "company/companyManager.do",
            "mdesc": "二级菜单"
        },
        {
            "mid": 7,
            "mname": "新人管理",
            "pid": 1,
            "isparent": "0",
            "status": "0",
            "url": "married/marriedManager.do",
            "mdesc": "二级菜单"
        },
        {
            "mid": 2,
            "mname": "成员订单中心",
            "pid": 0,
            "isparent": "1",
            "status": "0",
            "url": null,
            "mdesc": "一级菜单"
        },
        {
            "mid": 8,
            "mname": "主持人订单中心",
            "pid": 2,
            "isparent": "0",
            "status": "0",
            "url": null,
            "mdesc": "二级菜单"
        },
        {
            "mid": 3,
            "mname": "内容管理",
            "pid": 0,
            "isparent": "1",
            "status": "0",
            "url": null,
            "mdesc": "一级菜单"
        },
        {
            "mid": 9,
            "mname": "banner管理",
            "pid": 3,
            "isparent": "0",
            "status": "0",
            "url": null,
            "mdesc": "二级菜单"
        },
        {
            "mid": 10,
            "mname": "首页推荐管理",
            "pid": 3,
            "isparent": "0",
            "status": "0",
            "url": null,
            "mdesc": "二级菜单"
        },
        {
            "mid": 11,
            "mname": "底部文案、二维码设置",
            "pid": 3,
            "isparent": "0",
            "status": "0",
            "url": null,
            "mdesc": "二级菜单"
        },
        {
            "mid": 12,
            "mname": "加入团队介绍文案",
            "pid": 3,
            "isparent": "0",
            "status": "0",
            "url": null,
            "mdesc": "二级菜单"
        }
    ];

    /* 初始化zTree */
    $(function () {
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    })
</script>

</body>
</html>
