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

<table id="hostDataGrid" fit="true"></table>

<%--顶部搜索框--%>
<div id="header" style="padding:2px 5px;">
    <form id="hostSearchForm" action="host/list.do" method="post" class="easyui-form">
        <input class="easyui-textbox" name="hname" prompt="请输入姓名(可不填)" style="width: 110px">

        <select data-options="editable:false" class="easyui-combobox" name="status" panelHeight="auto"
                style="width: 100px">
            <option value="">状态</option>
            <option value="0">禁用</option>
            <option value="1">正常</option>
        </select>

        <select data-options="editable:false" class="easyui-combobox" name="strong" panelHeight="auto"
                style="width:100px">
            <option value="">权重</option>
            <option value="0">权重降序</option>
            <option value="1">权重升序</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="ordernumber" panelHeight="auto"
                style="width:120px">
            <option value="">订单排序</option>
            <option value="0">订单量降序</option>
            <option value="1">订单量升序</option>
        </select>

        <select data-options="editable:false" class="easyui-combobox" name="hprice" panelHeight="auto"
                style="width:120px">
            <option value="">价格顺序</option>
            <option value="0">价格降序</option>
            <option value="1">价格升序</option>
        </select>

        <select data-options="editable:false" class="easyui-combobox" name="hpstar" panelHeight="auto"
                style="width:100px">
            <option value="">星推荐</option>
            <option value="1">是</option>
            <option value="0">否</option>
        </select>

        <select data-options="editable:false" class="easyui-combobox" name="hpdiscount" panelHeight="auto"
                style="width:100px">
            <option value="">折扣</option>
            <option value="9">9折</option>
            <option value="8">8折</option>
            <option value="7">7折</option>
            <option value="6">6折</option>
        </select>

        <a href="javascript:void(0);" onclick="hostSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        <a href="javascript:void(0);" onclick="restSearch();" class="easyui-linkbutton" iconCls="icon-cancel">重置</a>
    </form>
</div>

<%--定义操作头部按钮--%>
<div id="toolbar">
    <%-- plain:true:设置为简洁效果 --%>
    <a class="easyui-linkbutton" onclick="openHostWindow();" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a class="easyui-linkbutton" onclick="settingPower();" data-options="iconCls:'icon-tip',plain:true">权限设置</a>
    <a class="easyui-linkbutton" onclick="changeHostStatus();" data-options="iconCls:'icon-lock',plain:true">启用/禁用账号</a>
</div>

<%-- 新增主持人窗口 --%>
<div id="addHostWindow" class="easyui-window" data-options="closed:true,modal:true"
     style="width: 400px; padding: 30px 30px">
    <form action="post" class="easyui-form" id="hostForm">
        <div style="width:100%">
            <input required data-options="label:'姓名'" style="width:100%" class="easyui-textbox" name="hname">
        </div>

        <div style="width:100%;margin-top: 30px">
            <input required data-options="label:'手机号'" style="width:100%" class="easyui-textbox" name="hphone">
        </div>

        <div style="width:100%;margin-top: 30px">
            <input required data-options="label:'密码'" style="width:100%" class="easyui-passwordbox" name="hpwd">
        </div>

        <div style="width:100%;margin-top: 30px">
            <a href="javascript:void(0)" onclick="insertHost();" style="width:100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>

<%-- 权限设置框 --%>
<div id="hostPowerWindow" data-options="modal:true,closed:true" class="easyui-window"
     style="height: 580px;width: 550px;padding: 30px 30px">
    <form id="hostPowerForm" method="post">

        <input id="hostids" type="hidden" name="hostids">

        <div style="width: 100%">
            <label style="margin-right: 20px">星推荐&nbsp;&nbsp;&nbsp;</label>
            <input class="easyui-radiobutton" data-options="labelWidth:40,labelPosition:'after'" name="hpstar" value="1"
                   label="是">
            <input class="easyui-radiobutton" data-options="labelWidth:40,labelPosition:'after'" name="hpstar" value="0"
                   label="否">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">星推荐有效期</label>
            <input name="hpstartBegindate" class="easyui-datebox" style="width: 30%">-
            <input name="hpstarEnddate" class="easyui-datebox" style="width: 30%">
        </div>

        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">自添订单</label>
            <input class="easyui-radiobutton" data-options="labelWidth:60,labelPosition:'after'" name="hpOrderPower"
                   value="1" label="允许">
            <input class="easyui-radiobutton" data-options="labelWidth:60,labelPosition:'after'" name="hpOrderPower"
                   value="0" label="不允许">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">星推荐有时间</label>
            <input data-options="showSeconds:true,min:'08:30:00',max:'18:00:00'" value="08:30:00" name="hpstarBegintime"
                   class="easyui-timespinner" style="width: 30%">-
            <input data-options="showSeconds:true,max:'18:00:00'" value="18:00:00" name="hpstarEndtime"
                   class="easyui-timespinner" style="width: 30%">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <input required data-options="label:'折扣'" style="width: 100%" class="easyui-textbox" name="hpdiscount">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">折扣时间</label>
            <input name="hpDisStarttime" class="easyui-datebox" style="width: 30%">-
            <input name="hpDisEndtime" class="easyui-datebox" style="width: 30%">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <input required data-options="label:'价格'" style="width: 100%" class="easyui-textbox" name="hpprice">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <input required data-options="label:'管理费'" style="width: 100%" class="easyui-textbox" name="hpcosts">
        </div>

        <div style="margin-top: 20px;width: 90%">
            <a onclick="hostPowerSet();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>


<script type="text/javascript">

    /* 主持人权限表单提交
    * 需要日期转换 请注意!*/
    function hostPowerSet() {
        $("#hostPowerForm").form(

            /* submit方法
            * url：请求的URL地址。
            * onSubmit: 提交之前的回调函数。
            * success: 提交成功后的回调函数。
            */
            "submit",
            {
                url: "hostPower/hostPowerSet.do",
                onSubmit: function () {
                    /* validate : 做表单字段验证，当所有字段都有效的时候返回true */
                    // return 为true的话 就提交数据 false就终止表单提交
                    return $(this).form("validate");
                },
                success: function (data) {
                    var json = JSON.parse(data);

                    if (json.code == 200) {
                        // 弹出消息框
                        $.messager.alert("消息框", json.msg, 'info')
                        // 重置表单
                        $("#hostPowerForm").form("reset");
                        // 关闭对话框
                        $("#hostPowerWindow").window("close");
                        // 刷新datagrid
                        $("#hostDataGrid").datagrid("reload");
                    }
                }
            }
        )
    }

    /* 设置权限按钮点击事件 */
    function settingPower() {

        var rows = $("#hostDataGrid").datagrid('getChecked');
        // 至少选中一行
        if (rows.length == 0) {
            $.messager.alert("消息框", "至少选中一行数据", 'warning');
            // 终止执行后面的代码
            return false;
        }

        // 将选中列的主持人的名称设置为window的title
        // console.log(rows);

        var hnames = []; // 封装主持人的名称显示 window的标题
        var hids = []; // 封装主持人的id 用于修改主持人提交给后台
        /** jq的for循环
         * rows 循环的数组
         * index 循环的索引
         * host 循环的值 每次循环就是一个主持人
         */
        $.each(rows, function (index, host) {
            hnames.push(host.hname);
            hids.push(host.hid);
        })

        // 将主持人的id设置给 id = hostids隐藏域 对应窗口的隐藏id ==> hostids
        $("#hostids").val(hids.toString());

        // 不能重复调用window();
        $("#hostPowerWindow").window({
            title: hnames.toString() + "设置权限",
            closed: false
        });
    }

    /* 重置搜索框条件 */
    function restSearch() {
        $("#hostSearchForm").form("reset");
    }

    /* 修改主持人权重
    *  onchange事件: 修改即触发的事件 (位于 初始化函数 的权重列设置)
    *  object : 当前行文本框(权重值的文本框)
    *  hid : 当前行的主持人id
    */
    function changeHostStrong(object, hid) {
        // 1.获取文本框的权重值
        var strong = $(object).val();

        // 使用ajax异步修改主持人状态
        $.post(
            "host/changeStrong.do",
            {
                hid: hid,
                strong: strong
            },
            function (data) {
                $.messager.alert("温馨提示", data.msg, "info");

                //刷新datagrid
                $("#hostDataGrid").datagrid("reload");
            }
        )
    }

    /* 修改主持人状态 */
    function changeHostStatus() {

        // 1.获取勾选中的框
        var row = $("#hostDataGrid").datagrid("getChecked");
        // 2.判断选中框的数量 进行判断
        if (row.length == 0) {
            $.messager.alert("消息框", "至少选中一行数据", 'warning');
            // 终止执行后面的代码
            return false;
        }

        if (row.length > 1) {
            $.messager.alert("消息框", "不能批量修改", 'warning');
            return false;
        }

        // 3.获取当前行的信息 使用ajax异步修改主持人状态
        var host = row[0];

        $.post(
            "host/changeStatus.do",
            {
                hid: host.hid,
                status: host.status
            },
            function (data) {
                $.messager.alert("温馨提示", data.msg, "info");

                //刷新datagrid
                $("#hostDataGrid").datagrid("reload");
            },
        )
    }


    /* 新增主持人函数 : 不能用同步 只能用异步 */
    function insertHost() {
        // submit()方法会把数据提交过去后端
        $("#hostForm").form
        ('submit',
            {
                url: "host/insert.do",
                onSubmit: function () {
                    var flag = $(this).form('validate');
                    return flag;
                },
                success: function (data) {
                    var json = JSON.parse(data);
                    console.log(json);
                    if (json.code == 200) {
                        // 弹出消息框
                        $.messager.alert("消息框", json.msg, 'info')
                        // 重置表单
                        $("#hostForm").form("reset");
                        // 关闭对话框
                        $("#addHostWindow").window("close");
                        // 刷新datagrid
                        $("#hostDataGrid").datagrid("reload");
                    }
                }
            }
        );
    }

    /*打开新增主持人的窗口*/
    function openHostWindow() {
        $("#addHostWindow").window('open');
    }

    /*初始化datagrid*/
    $(function () {
        $("#hostDataGrid").datagrid({
            pagination: true,
            /* 处理点击行时, 是否会勾选的问题 */
            checkOnSelect: false, // 如果为true，当用户点击行的时候该复选框就会被选中或取消选中。如果为false，当用户仅在点击该复选框的时候才会被选中或取消。
            /* 处理勾选时, 是否会选中行的问题 */
            selectOnCheck: false, // 如果为true，单击复选框将永远选择行。如果为false，选择行将不选中复选框。
            singleSelect: true, // 	如果为true，则只允许选择一行。是选中 也不是勾选
            striped: true,  // 是否显示斑马线效果。
            toolbar: "#toolbar", /* 顶部下方的工具栏 */
            header: "#header", /*设置顶40部的搜索框工具条*/
            url: 'host/list.do',

            columns: [[
                {field: 'hid', title: '选中', width: 100, checkbox: true},
                {
                    field: 'strong', title: '权重', width: 100, formatter: function (value, row, index) {
                        // console.log(value, row);
                        // 这里注意字符串与变量的拼接
                        return '<input onchange="changeHostStrong(this,' + row.hid + ');" style="width:100%" value="' + value + '">';
                    }
                },
                {field: 'hname', title: '主持人姓名', width: 100},
                {field: 'hphone', title: '主持人电话', width: 100},
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
                {field: 'hprice', title: '价格', width: 100},
                {field: 'hpdiscount', title: '折扣', width: 100},
                {
                    field: 'hpstar', title: '星推荐', width: 100, formatter: function (value, row, index) {
                        return value == 1 ? "是" : "否";
                    }
                },
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                        return value == 0 ? "<span style='color: red'>禁用</span>" : "<span style='color: green'>启用</span>";
                    }
                },

            ]]
        });
    });

    /* 表单的条件查询
    * 思路: 点击查询 就会提交参数 让datagrid发新的请求 带着表单参数重新进行查询
    *      所以该表单只是提交参数  将表单数据转成json数据 引入第三方json文件 jquery.serializejson.min.js
    *      表单序列化成json数据
    */
    function hostSearch() {
        // 使用 jquery.serializejson 序列化表单
        var formData = $("#hostSearchForm").serializeJSON();
        console.log(formData);

        // 执行datagrid的重新加载方法 带着条件参数重新查询
        // load : 加载和显示第一页的所有行。如果指定了'param'，它将取代'queryParams'属性。
        // 通常可以通过传递一些参数执行一次查询，通过调用这个方法从服务器加载新数据。
        $("#hostDataGrid").datagrid("load", formData);
    }

</script>

</body>
</html>
