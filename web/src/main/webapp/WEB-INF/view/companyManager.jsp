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

<%-- 分页查询表格 --%>
<table id="companyDataGrid" fit="true"></table>

<%-- 顶部搜索框 --%>
<div id="header" style="padding:2px 5px;">
    <form id="companySearchForm" action="company/list.do" method="post" class="easyui-form">
        <input class="easyui-textbox" name="cname" prompt="请输入姓名(可不填)" style="width: 110px">

        <select data-options="editable:false" class="easyui-combobox" name="status" panelHeight="auto" style="width: 100px">
            <option value="">账号状态</option>
            <option value="0">未审核</option>
            <option value="1">正常</option>
            <option value="2">禁用</option>
        </select>

        <select data-options="editable:false" class="easyui-combobox" name="ordernumber" panelHeight="auto" style="width:100px">
            <option value="">订单排序</option>
            <option value="0">订单量降序</option>
            <option value="1">订单量升序</option>
        </select>

        <a href="javascript:void(0);" onclick="companySearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        <a href="javascript:void(0);" onclick="restSearch();" class="easyui-linkbutton" iconCls="icon-cancel">重置</a>
    </form>
</div>

<%-- 定义操作头部按钮 --%>
<div id="toolbar">
    <a id="add" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-add',plain:true}">添加</a>
    <a id="edit" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-edit',plain:true}">编辑</a>
    <a id="planner" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-tip',plain:true}">策划师列表</a>
    <a id="disable" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-clear',plain:true}">禁用启用账号</a>
    <a id="check" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-redo',plain:true}">账号审核</a>
</div>

<%-- 新增修改婚庆公司窗口 --%>
<div id="companyWindow" data-options="closed:true" class="easyui-window" style="width: 400px;padding: 30px 30px">
    <form id="companyForm" class="easyui-form" method="post">
        <input name="cid" type="hidden">
        <div style="width: 100%">
            <input required data-options="label:'公司名称'" style="width: 100%" class="easyui-textbox" name="cname">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'公司法人'" style="width: 100%" class="easyui-textbox" name="ceo">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input id="cpwd" required data-options="label:'密码',showEye:false" style="width: 100%" class="easyui-passwordbox" name="cpwd">
        </div>

        <%-- 设置密码确认校验 --%>
        <div style="margin-top: 20px;width: 100%">
            <input id="cpwd1" validType="equals['#cpwd']" required data-options="label:'确认密码',showEye:false"
                   style="width: 100%" class="easyui-passwordbox" name="cpwd1">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'邮箱',validType:'email'" style="width: 100%" class="easyui-textbox" name="cmail">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'手机'" style="width: 100%" class="easyui-textbox" name="cphone">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <a onclick="saveOrUpdateCompany();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>

<%-- 策划师列表窗口 --%>
<div id="plannerWindow" data-options="closed:true"  data-options="modal:true" class="easyui-window" style="width: 80%;height: 60%">

    <%-- 策划师表格 --%>
    <table id="plannerDatagrid" class="easyui-datagrid" data-options="pagination:true" style="width: 100%;height: 100%"></table>

</div>

<script type="text/javascript">

    /* 初始化companyDataGrid */
    $(function () {
        $("#companyDataGrid").datagrid({
            pagination: true,
            /* 处理点击行时, 是否会勾选的问题 */
            checkOnSelect: false, // 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。如果为false，当用户仅在点击该复选框的时候才会被选中或取消。
            /* 处理勾选时, 是否会选中行的问题 */
            selectOnCheck: true, // 如果为true，单击复选框将永远选择行。如果为false，选择行将不选中复选框。
            singleSelect: true, // 	如果为true，则只允许选择一行。是选中 不是勾选
            striped: true,  // 是否显示斑马线效果。
            toolbar: "#toolbar",
            header: "#header", /*设置顶部的搜索框工具条*/
            url: 'company/list.do',

            columns: [[
                {field: 'cid', checkbox: true},
                {field: 'cname', title: '公司名称', width: 100},
                {field: 'ceo', title: '公司法人', width: 100},
                {field: 'cphone', title: '公司法人电话', width: 100},
                {field: 'cmail', title: '公司邮箱', width: 100},
                /**
                 * formatter 将列进行格式化
                 * 函数返回一个字符串，渲染到datagrid的列上，可以渲染解析html内容
                 * value 当前对象/值
                 * row  当前行
                 * index  当前行的索引
                 */
                {
                    field: 'starttime', title: '注册日期', width: 100, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {field: 'ordernumber', title: '订单数量', width: 100},
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                        if (value == 0) {
                            return "<span style='color: red'>未审核</span>";
                        } else if (value == 1) {
                            return "<span style='color: green'>正常</span>";
                        } else if (value == 2) {
                            return "<span style='color: red'>禁用</span>";
                        }

                    }
                },
            ]]
        });
    });

    /* 重置搜索框条件 */
    function restSearch() {
        $("#companySearchForm").form("reset");
    }

    /* 搜索函数 */
    function companySearch() {
        // 将表单数据序列化
        var formData = $("#companySearchForm").serializeJSON();
        console.log(formData);

        // load : 加载和显示第一页的所有行。如果指定了'param'，它将取代'queryParams'属性。
        // 通常可以通过传递一些参数执行一次查询，通过调用这个方法从服务器加载新数据。
        $("#companyDataGrid").datagrid("load", formData);
    }

    /* 新增或者修改婚庆公司的表单提交 都是用同一个表单 */
    function saveOrUpdateCompany() {

        $("#companyForm").form(
            'submit',
            {
                /* url不要加/ 原因: 顶部的基础路径设置里 已经加了/ 所以不要再加/  */
                url: "company/saveOrUpdate.do",
                onSubmit: function () {
                    /* validate : 做表单字段验证，当所有字段都有效的时候返回true */
                    // return 为true的话 就提交数据 false就终止表单提交
                    return $(this).form("validate");
                },
                success: function (data) {
                    var json = JSON.parse(data);

                    //1.重置表单
                    $("#companyForm").form("reset");

                    //2.关闭窗口
                    $("#companyWindow").window("close");

                    //3.刷新datagrid
                    $("#companyDataGrid").datagrid("reload")

                    //4.弹出消息框
                    $.messager.alert("消息框", json.msg, "info");
                }
            }
        )
    }

    /* 初始化按钮 */
    $(function () {

        /* 添加婚庆公司按钮绑定函数 */
        $("#add").click(function () {
            /* 显示编辑公司窗口 */
            $("#companyWindow").window({
                closed: false,
                title: "新增婚庆公司"
            });
        });

        /* 修改婚庆公司按钮绑定函数 */
        $("#edit").click(function () {

            if(Checked().length == 0){
                $.messager.alert("消息框", "最少选中一个公司", 'warning');
                return false;
            }

            var company = Checked()[0];

            /* 显示编辑公司窗口 */
            $("#companyWindow").window({
                closed: false,
                title: "修改婚庆公司"
            });

            /* 设置一个确认密码属性 回显的时候让密码也回显 */
            company.cpwd1 = company.cpwd;

            /* 密码可以置空 */
            // company.cpwd1 = "";

            // 回显表单
            $("#companyForm").form("load", company);
        })

        /*自定义校验规则，密码和确认密码必须相同*/
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '两次密码不相同'
            }
        });

        /* 审核账号按钮绑定函数 */
        $("#check").click(function () {

            if(Checked().length == 0){
                $.messager.alert("消息框", "最少选中一个公司", 'warning');
                return false;
            }

            // 获取公司 校验公司的状态
            var company = Checked()[0];
            if (company.status != 0){
                $.messager.alert("消息框","此公司已通过审核, 不需要再次审核","warning");
                return false;
            }

            confirm("你确定要审核通过此公司吗?",company);
        });

        /* 禁用启用按钮绑定函数 */
        $("#disable").click(function () {

            if(Checked().length == 0){
                $.messager.alert("消息框", "最少选中一个公司", 'warning');
                return false;
            }

            // 获取公司 校验公司的状态
            var company = Checked()[0];
            if (company.status == 0){
                $.messager.alert("消息框","此公司未通过审核, 需要先审核","warning");
                return false;
            }

            confirm("你确定要禁用或启用此公司?",company);
        });
    })

    /* 获取选中的行 */
    function Checked() {
        return $("#companyDataGrid").datagrid('getChecked');
    }

    /* 改变公司的状态的确定方程 */
    function confirm(message, company) {

        $.messager.confirm('消息框', message, function(r){
            if (r){
                $.post(
                    "company/changeStatus.do",
                    {
                        cid:company.cid,
                        status:company.status
                    },
                    function (data) {
                        /* 不用将data解析成json对象 因为使用jq的post返回的就是json对象 */
                        // 1.刷新datagrid
                        $("#companyDataGrid").datagrid("reload");
                        // 2.弹出消息框
                        $.messager.alert("温馨提示",data.msg,"info");
                    }
                )
            }
        });
    }

    /* 策划师列表按钮绑定函数 */
    $(function () {

        $("#planner").click(function () {
            if(Checked().length == 0){
                $.messager.alert("消息框", "最少选中一个公司", 'warning');
                return false;
            }
            // 获取公司
            var company = Checked()[0];

            // 显示策划师窗口
            $("#plannerWindow").window({
                closed: false,
                title: company.cname + "策划师列表"
            })

            /* 加载策划师列表数据 */
            $("#plannerDatagrid").datagrid({
                pagination: true,
                checkOnSelect: false, // 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。如果为false，当用户仅在点击该复选框的时候才会被选中或取消。
                selectOnCheck: true, // 如果为true，单击复选框将永远选择行。如果为false，选择行将不选中复选框。
                singleSelect: true, // 	如果为true，则只允许选择一行。是选中 不是勾选
                striped: true,  // 是否显示斑马线效果。
                pageList:[2,10,20,30,40,50],
                url: 'planner/list.do?cid=' + company.cid,

                columns: [[
                    {field: 'nid'},
                    {field: 'nname', title: '策划师姓名', width: 100},
                    {field: 'nphone', title: '策划师电话', width: 100},
                    {
                        field: 'addtime', title: '添加事件', width: 100, formatter: function (value, row, index) {
                            return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                        }
                    },
                    {field: 'ordernumber', title: '订单数量', width: 100},
                    {
                        field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                            return value == 0 ? " <span style='color:red'>禁用</span>" : " <span style='color:green'>启用</span>";
                        }
                    },
                ]]
            });
        });

    })

</script>

</body>
</html>
