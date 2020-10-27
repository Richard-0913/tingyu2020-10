<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
        //   http://localhost:8080/tingyu/
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
<body class="easyui-layout">

<div data-options="region:'west'" title="操作" style="width:200px;text-align: center;padding-top: 50px;">
    <div onclick="addMenu();" href="javascript:void(0)" style="width: 160px;margin-bottom: 20px;" class="easyui-linkbutton" iconCls="icon-add" iconAlign="right">
        新增菜单
    </div>
    <div onclick="editMenu();" href="javascript:void(0)" style="width: 160px;margin-bottom: 20px;" class="easyui-linkbutton" iconCls="icon-edit" iconAlign="right">
        编辑菜单
    </div>
    <div onclick="delMenu();" href="javascript:void(0)" style="width: 160px;margin-bottom: 20px;" class="easyui-linkbutton" iconCls="icon-remove" iconAlign="right">
        删除菜单
    </div>
    <div onclick="reflashMenu();" href="javascript:void(0)" style="width: 160px;margin-bottom: 20px;" class="easyui-linkbutton" iconCls="icon-reload" iconAlign="right">
        刷新菜单
    </div>
</div>

<div data-options="region:'center'"title="当前系统菜单">
    <ul id="menuTree" class="ztree"></ul>
</div>

<%-- 菜单操作窗口 --%>
<div id="menuWindow" data-options="closed:true,modal:true" class="easyui-window" style="width: 400px;padding: 30px 30px">
    <form id="menuForm" method="post" >
        <%--修改菜单id--%>
        <input  name="mid" type="hidden">

        <div style="width: 100%; margin-top: 30px;">
            <input id="parentMenu" name="pid" class="easyui-combobox" style="width:100%;" value="0" data-options="valueField:'mid',textField:'mname',label:'父菜单'" >
        </div>
        <div style="width: 100%;margin-top: 30px;">
            <input required data-options="label:'菜单名称'" style="width: 100%" class="easyui-textbox" name="mname">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input  data-options="label:'菜单地址'" style="width: 100%" class="easyui-textbox" name="url">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'菜单描述'" style="width: 100%" class="easyui-textbox" name="mdesc">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <a onclick="saveOrUpdateMenu();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton" >提交</a>
        </div>
    </form>
</div>

<script type="text/javascript">

    /* 删除按钮事件 */
    function delMenu() {
        //获取树对象
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");

        //获取选中的节点
        var nodes = treeObj.getSelectedNodes();
        /* 没有选中给出提示 */
        if(nodes.length == 0){
            $.messager.alert("消息框","请选择一个需要删除的菜单",'warning');
            return false;
        }

        $.messager.confirm('消息框', "你确定要删除此菜单?", function(r){
            if (r){
                var menu = nodes[0];
                $.post(
                    "menu/delete.do",
                    {
                        mid: menu.mid
                    },
                    function (data) {
                        /* 重新加载zTree */
                        reflashMenu();
                        $.messager.alert("消息框",data.msg,'info');
                    }
                )
            }
        })
    }

    /* 新增和修改菜单函数 */
    function saveOrUpdateMenu() {
        // console.log($("#parentMenu").val())
        $("#menuForm").form("submit",{
            url:"menu/saveOrUpdate.do",
            onSubmit: function(){
                var isValid = $(this).form('validate');
                return isValid;
            },
            success: function(data){
                var json = JSON.parse(data);
                //1.重置表单
                $("#menuForm").form("reset");
                //2.关闭窗口
                $("#menuWindow").window("close");
                //3.刷新ztree
                reflashMenu();
                //4.弹出消息框
                $.messager.alert("消息框",json.msg,"info");
            }
        });
    };

    /* 下拉框加载 */
    $(function () {
        $("#parentMenu").combobox({
            url:"menu/list.do",
            /*预处理数据*/
            loadFilter:function (data) {
                var parentData = {mid:0, mname:"顶级菜单"};
                //向返回数据最前面添加一个顶级菜单
                data.unshift(parentData);
                return data;
            }
        })
    })

    /* 修改按钮事件 */
    function editMenu() {
        /*重置表单*/
        $("#menuForm").form("reset");
        //获取树对象
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");

        //获取选中的节点
        var nodes = treeObj.getSelectedNodes();

        if (nodes.length == 0){
            $.messager.alert("消息框","至少选择一个节点","info");
            return false;
        }

        /* 获取选中节点对应菜单数据 */
        var menu = nodes[0];
        /* 表单回显数据 */
        $("#menuForm").form("load", menu);

        $("#menuWindow").window({
            closed: false,
            title: "修改菜单"
        })
    }

    /* 新增按钮事件 */
    function addMenu() {

        $("#parentMenu").combobox("reload")

        /*重置表单*/
        $("#menuForm").form("reset");

        $("#menuWindow").window({
            closed:false,
            title:"新增菜单"
        })
    }

    /* 刷新按钮事件 */
    function reflashMenu() {
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        treeObj.reAsyncChildNodes(null, "refresh");
    }

    /*zTree的初始化设置对象*/
    var setting = {
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
            url:"menu/list.do",
            /*预处理加载数据*/
            dataFilter: filter
        }
    };

    /*预处理函数*/
    function filter(treeId, parentNode, childNodes) {
        if (!childNodes) return null;
        for (var i=0, l = childNodes.length; i < l; i ++) {
            childNodes[i].open = true;
            // childNodes[i].icon = "static/ztree/css/zTreeStyle/img/diy/5.png";
        }
        return childNodes;
    }

    /*初始化zTree*/
    $(function () {
        $(document).ready(function(){
            $.fn.zTree.init($("#menuTree"), setting);
        });
    })
</script>
</body>
</html>
