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

<table id="marriedManagerDataGrid" fit="true"></table>

<%-- 顶部搜索表单 --%>
<div id="marriedPersonHeader" style="padding:2px 5px;">
    <form id="marriedPersonSearchForm">
        <input  name="pname" class="easyui-textbox" prompt="新人姓名" style="width:110px">
        <input  name="phone" class="easyui-textbox" prompt="新人手机" style="width:110px">
        <a href="javascript:void(0);"  onclick="marriedPersonSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
    </form>
</div>

<%-- 工具栏按钮 --%>
<div id="toolbar">
    <a id="edit" href="javascript:void(0);" class="easyui-linkbutton" data-options="{iconCls:'icon-edit',plain:true}">编辑</a>
    <a class="easyui-linkbutton" onclick="changePersonStatus();" data-options="iconCls:'icon-lock',plain:true">启用/禁用账号</a>
</div>

<%-- 修改新人窗口 --%>
<div id="marryPersonWindow" data-options="closed:true,modal:true" class="easyui-window" style="width: 400px;padding: 30px 30px">
    <form id="marryPersonForm" class="easyui-form" method="post">
        <input name="pid" type="hidden">
        <div style="width: 100%">
            <input required data-options="label:'新人姓名'" style="width: 100%" class="easyui-textbox" name="pname">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'电话'" style="width: 100%" class="easyui-textbox" name="phone">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'邮箱',validType:'email'" style="width: 100%" class="easyui-textbox" name="pmail">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <label style="margin-right: 20px">结婚日期</label>
            <input name="marrydate" class="easyui-datebox" style="width: 70%">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <label style="margin-right: 20px">注册日期</label>
            <input name="regdate" class="easyui-datetimebox" style="width: 70%">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <a onclick="update();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>

<script type="text/javascript">

    /* 禁用或启用状态 */
    function changePersonStatus() {

        var checked = $("#marriedManagerDataGrid").datagrid("getChecked");
        if (checked.length == 0){
            $.messager.alert("消息框", "最少选中一个公司", 'info');
            return false;
        }

        var person = checked[0];
        $.messager.confirm('消息框',"你确定要启用或禁用此新人吗?",function (r) {
            if (r){
                $.post(
                    "married/changePersonStatus.do",
                    {
                        pid: person.pid,
                        status: person.status
                    },
                    function (data) {
                        $("#marriedManagerDataGrid").datagrid("reload");
                        $.messager.alert("消息框",data.msg,"info");
                    }
                )
            }
        })
    }

    function update(){
        $("#marryPersonForm").form("submit",{

            url: "married/update.do",
            onSubmit:function () {
                return $(this).form("validate");
            },
            success:function (data) {
                var json = JSON.parse(data);
                //1.重置表单
                $("#marryPersonForm").form("reset");

                //2.关闭窗口
                $("#marryPersonWindow").window("close");

                //3.刷新datagrid
                $("#marriedManagerDataGrid").datagrid("reload")

                //4.弹出消息框
                $.messager.alert("消息框", json.msg, "info");
            }
        })
    }

    $(function () {
        $("#edit").click(function () {

            var checked = $("#marriedManagerDataGrid").datagrid("getChecked");
            if (checked.length == 0){
                $.messager.alert("消息框", "最少选中一个公司", 'info');
                return false;
            }
            var marryPerson = checked[0];
            console.log(marryPerson)
            // 将时间格式化
            var marryValue = marryPerson.marrydate;
            marryPerson.marrydate = marryValue.year + "-" + marryValue.monthValue + "-" + marryValue.dayOfMonth;

            var regValue = marryPerson.regdate;
            marryPerson.regdate = regValue.year + "-" + regValue.monthValue + "-" + regValue.dayOfMonth +" "+
                regValue.hour + ":" + regValue.minute + ":" + regValue.second;
            // console.log(marryPerson)

            /* 显示编辑公司窗口 */
            $("#marryPersonWindow").window({
                closed: false,
                title: "修改新人"
            });

            $("#marryPersonForm").form("load",marryPerson);
        });

    })

    /* 新人搜索按钮函数 */
    function marriedPersonSearch(){
        // 序列化表单
        var json = $("#marriedPersonSearchForm").serializeJSON();
        // 重新加载datagrid
        $("#marriedManagerDataGrid").datagrid('reload', json);
    }

    /* marriedManagerDataGrid */
    $(function () {
        $("#marriedManagerDataGrid").datagrid({
            pagination: true,
            checkOnSelect: false,
            selectOnCheck: true,
            singleSelect: true,
            striped: true,  // 是否显示斑马线效果。
            header: "#marriedPersonHeader", /*设置顶部的搜索框工具条*/
            toolbar: "#toolbar",
            url: 'married/list.do',

            columns: [[
                {field: 'pid', checkbox: true},
                {field: 'pname', title: '新人名称', width: 100},
                {field: 'phone', title: '新人电话', width: 100},
                {field: 'pmail', title: '新人邮箱', width: 100},
                {
                    field: 'marrydate', title: '结婚日期', width: 100, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {
                    field: 'regdate', title: '注册日期', width: 200, formatter: function (value, row, index) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth +" "+
                            value.hour + ":" + value.minute + ":" + value.second;
                    }
                },
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                        return value == 1 ? "<span style='color: green'>正常</span>" : "<span style='color: red'>禁用</span>";
                    }
                },
            ]]
        });
    });

</script>

</body>
</html>
