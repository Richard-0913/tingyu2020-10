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
    <link rel="stylesheet" type="text/css" href="static/ztree/css/metroStyle/metroStyle.css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.core.js"></script>
</head>
<body>

<ul id="treeDemo" class="ztree"></ul>

<script>
    /* zTree的设置对象,配置zTree的初始化信息 */
    var setting = {
        /* 数据初始化配置 */
        data: {
            /* 支持简单数据 */
            simpleData: {
                enable: true,
                idKey: "mid",
                pIdKey: "pid",
            },
            key: {
                name: "mname"
            }
        },
        /* 异步加载数据 */
        async: {
            enable: true,
            url: "menu/list.do",
            /* 预处理加载的数据 加载时就打开树的分支,不用手动打开 */
            dataFilter: ajaxDataFilter
        }
    };

    /* 预处理数据调用的函数, 在此喊出内部预处理数据 */
    function ajaxDataFilter(treeId, parentNode, responseData) {
        if (responseData) {
            for(var i =0; i < responseData.length; i++) {
                responseData[i].open = true;
            }
        }
        return responseData;
    };

    /* 初始化zTree */
    $(function () {
        $.fn.zTree.init($("#treeDemo"), setting);
    })
</script>
</body>
</html>
