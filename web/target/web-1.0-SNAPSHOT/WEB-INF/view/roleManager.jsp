<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <%--设置页面基础路径，以后页面的所有跳转和样式js的引入全部基于这个基础路径--%>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <link rel="stylesheet" href="static/ztree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.all.js"></script>
    <script type="text/javascript" src="static/jquery.serializejson/jquery.serializejson.min.js"></script>
</head>
<body>

<table id="roleDataGrid" fit="true"></table>

<%-- 定义操作工作栏按钮 --%>
<div id="toolbar">
    <a id="add" href="javascript:void(0);" class="easyui-linkbutton"
       data-options="{iconCls:'icon-add',plain:true}">添加</a>
    <a id="update" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-edit',plain:true}">修改</a>
    <a id="delete" href="javascript:void(0);" class="easyui-linkbutton"
       data-options="{iconCls:'icon-remove',plain:true}">删除</a>
</div>

<%-- 新增修改角色窗口 window --%>
<div id="roleWindow" data-options="closed:true" class="easyui-window" style="width: 1000px;height: 500px">
    <div id="cc" class="easyui-layout" fit="true">
        <div data-options="region:'west',title:'角色基本信息',split:true" style="width:50%;padding: 50px">

            <form id="roleForm" class="easyui-form" method="post">
                <input name="rid" type="hidden">
                <div style="width: 100%">
                    <input required data-options="label:'角色名称'" style="width: 100%" class="easyui-textbox" name="rname">
                </div>
                <div style="margin-top: 20px;width: 100%">
                    <input required data-options="label:'角色描述'" style="width: 100%" class="easyui-textbox" name="rdesc">
                </div>

                <div style="margin-top: 20px;width: 100%">
                    <a onclick="saveOrUpdateRole();" href="javascript:void(0)" style="width: 100%"
                       class="easyui-linkbutton">提交</a>
                </div>
            </form>
        </div>

        <div data-options="region:'center',title:'当前系统菜单'" style="padding:5px;background:#eee;">
            <%-- zTree ul --%>
            <ul id="menuTree" class="ztree"></ul>
        </div>
    </div>
</div>


<%-- zTree的js初始化 --%>
<script type="text/javascript">
    /*zTree的初始化设置对象*/
    var setting = {
        /* 设置节点的复选框 */
        check: {
            enable: true
        },
        data: {
            /*支持简单数据（列表）*/
            simpleData: {
                enable: true,
                /*设置zTree节点id的数据名称*/
                idKey: "mid",
                /*设置zTree节点父id的数据名称*/
                pIdKey: "pid",
            },
            key: {
                /*设置zTree的节点数据名称*/
                name: "mname",
                url: "xUrl"
            }
        },
        /*异步请求*/
        async: {
            enable: true,
            url: "menu/list.do",
            /*预处理加载数据*/
            dataFilter: filter
        }
    };

    /*预处理函数*/
    function filter(treeId, parentNode, childNodes) {
        if (!childNodes) return null;
        for (var i = 0, l = childNodes.length; i < l; i++) {
            childNodes[i].open = true;
        }
        return childNodes;
    }

    /*初始化zTree*/
    $(function () {
        $(document).ready(function () {
            $.fn.zTree.init($("#menuTree"), setting);
        });
    })
</script>

<script>

    $(function () {
        /* 初始化分页表格 */
        $("#roleDataGrid").datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: true,
            singleSelect: true,
            striped: true,  // 是否显示斑马线效果。
            toolbar: "#toolbar",
            url: 'role/list.do',

            columns: [[
                {field: 'rid', checkbox: true},
                {field: 'rname', title: '角色名称', width: 150},
                {field: 'rdesc', title: '角色描述', width: 200},
            ]]
        });

        /* 新增按钮点击事件 */
        $("#add").click(function () {
            /* 重置zTree */
            var treeObj = $.fn.zTree.getZTreeObj("menuTree");
            treeObj.reAsyncChildNodes(null, "refresh");

            /* 重置表单 */
            $("#roleForm").form("reset");

            $("#roleWindow").window({
                closed: false,
                title: "新增角色"
            })
        })

        /* 修改按钮点击事件 */
        $("#update").click(function () {
            var row = $("#roleDataGrid").datagrid("getChecked")
            if (row.length == 0) {
                $.messager.alert("消息框", "至少选中一个进行修改", "info");
                return false;
            }

            var role = row[0];

            $("#roleForm").form("load", role);

            $("#roleWindow").window({
                closed: false,
                title:"修改 " + role.rname
            })

            /* 发送ajax异步请求根据角色id查询对应菜单的id, 并回显到zTree树节点 */
            $.get(
                "roleMenu/selectRoleMenuByRid.do",
                {
                    rid: role.rid
                },
                function (data) {
                    /**
                     * zTree回显思路
                     *  1.根数返回的数据找到对应的节点
                     *      根据节点的mid属性值获取对应的节点
                     *  2.勾选对应的节点
                     */
                    // 获取树对象
                    var treeObj = $.fn.zTree.getZTreeObj("menuTree");
                    // 循环数组获取每一个mid的值
                    $.each(data, function (index, mid) {
                        // 获取mid对应的树节点
                        var node = treeObj.getNodeByParam("mid", mid, null);
                        // 勾选节点
                        // 第二个boolean 为是否勾选 第二个boolean为是否父子联动 若为true 勾选子节点 必勾选父节点
                        treeObj.checkNode(node, true, false);
                    })

                }
            )
        })

        /* 删除按钮点击事件 */
        $("#delete").click(function () {

            var row = $("#roleDataGrid").datagrid("getChecked")
            if (row.length == 0) {
                $.messager.alert("消息框", "至少选中一个进行修改", "info");
                return false;
            }
            // 获取数据
            var role = row[0];

            // 提示
            $.messager.confirm("提示框","是否要删除该角色,删除后不能恢复!",function (r) {
                if (r){
                    $.post(
                        "role/deleteByRid.do",
                        {
                            rid: role.rid
                        },
                        function (data) {
                            // 1.刷新datagrid
                            $("#roleDataGrid").datagrid("reload");
                            // 2.弹出消息框
                            $.messager.alert("消息框", data.msg, "info");
                        }
                    )

                }
            })
        })
    });


    function saveOrUpdateRole() {

        // 获取此角色选中的菜单
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        var node = treeObj.getCheckedNodes(true);

        if (node.length == 0) {
            $.messager.alert("消息框", "最少分配一个菜单", "info");
            return false;
        }

        var mids = [];
        $.each(node, function (index, menu) {
            mids.push(menu.mid);
        })

        $("#roleForm").form("submit",
            {
                url: "role/saveOrUpdate.do",
                onSubmit: function (param) {
                    /* 除了表单的属性外,额外添加一个踩点id */
                    param.mids = mids.toString();
                    return $(this).form("validate");
                },
                success: function (data) {
                    var json = JSON.parse(data);

                    console.log("123");
                    // 重置表单
                    $("#roleForm").form("reset");
                    // 关闭窗口
                    $("#roleWindow").window("close");
                    // 刷新datagrid
                    $("#roleDataGrid").datagrid("reload");
                    // 弹出消息框
                    $.messager.alert("消息框",json.msg,"info")
                }
            }
        )
    }

</script>
</body>
</html>
