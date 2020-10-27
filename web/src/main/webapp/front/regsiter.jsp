<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    // http://localhost:8080/tingyu/
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>"/>
    <!-- 注意这里要先引入bootstrap的css 再引入其他的css, 否则bootstrap会覆盖其他的css造成布局错乱 -->
    <link rel="stylesheet" href="static/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/about.css">
    <link rel="stylesheet" href="static/layer/theme/default/layer.css">

    <script type="text/javascript" src="static/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="static/layer/layer.js"></script>
    <script type="text/javascript" src="static/js/jquery.validate.js"></script>

    <title>Ting域主持人注册界面</title>
    <style type="text/css">
        /* 设置校验失败后提示字体的颜色 */
        label.error {
            color: red;
        }

        /*input.error {border: 1px solid red;}*/
    </style>
</head>
<body>

<!-- 顶部导航布局开始 -->
<div>
    <div class="nav_login">
        <div class="juzhong">
            <p>Ting域主持人欢迎您！ 客服：18812345678</p>
            <p class="p_login"><a href="#"> 登录 | 注册</a></p>
        </div>
    </div>
    <div class="nav_logo">
        <div class="juzhong">
            <img src="static/img/logo.jpg" alt="">
        </div>
    </div>

</div>

<div class="container" style="border: 1px solid orange;border-radius: 20px; margin-top: 20px; margin-bottom: 20px">

    <div class="row" style="font-size:25px; margin-top:20px">
        <div class="col-md-6" style="text-align: right">
            <a onclick="displayOrHidden('company')" href="javascript:void(0)">我是公司</a>&nbsp;&nbsp;&nbsp;&nbsp;|
        </div>
        <div class="col-md-6">
            <a onclick="displayOrHidden('marryPerson')" href="javascript:void(0)">我是新人</a>
        </div>
    </div>

    <div id="companyBox" style="margin: 0 auto; width: 500px; margin-top: 20px">
        <form id="companyForm" class="form-horizontal" method="post">
            <div class="form-group">
                <label for="cname" class="col-sm-3 control-label">公司名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="cname" id="cname" placeholder="请输入公司名称">
                </div>
            </div>
            <div class="form-group">
                <label for="ceo" class="col-sm-3 control-label">公司法人</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" name="ceo" id="ceo" placeholder="请输入公司法人姓名">
                </div>
            </div>
            <div class="form-group">
                <label for="cpwd" class="col-sm-3 control-label">密码</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" name="cpwd" id="cpwd" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label for="cphone" class="col-sm-3 control-label">手机</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="cphone" id="cphone" placeholder="请输入手机">
                </div>
            </div>
            <div class="form-group">
                <label for="cmail" class="col-sm-3 control-label">公司邮箱</label>
                <div class="col-sm-9">
                    <input type="email" class="form-control" name="cmail" id="cmail" placeholder="请输入邮箱">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <button type="submit" style="width:100px" class="btn btn-primary">注册</button>
                </div>
            </div>
        </form>
    </div>

    <div id="marryPersonBox" style="margin: 0 auto; width: 500px; margin-top: 20px;display: none">
        <form id="marryPersonForm" class="form-horizontal" method="post">
            <div class="form-group">
                <label for="pname" class="col-sm-3 control-label">新人名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="pname" id="pname" placeholder="请输入新人姓名">
                </div>
            </div>
            <div class="form-group">
                <label for="pmail" class="col-sm-3 control-label">邮箱</label>
                <div class="col-sm-9">
                    <input type="email" class="form-control" name="pmail" id="pmail" placeholder="请输入邮箱">
                </div>
            </div>
            <div class="form-group">
                <label for="ppwd" class="col-sm-3 control-label">密码</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" name="ppwd" id="ppwd" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label for="checkPwd" class="col-sm-3 control-label">确认密码</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" name="checkPwd" id="checkPwd" placeholder="请输入确认密码">
                </div>
            </div>
            <div class="form-group">
                <label for="marrydate" class="col-sm-3 control-label">婚礼日期</label>
                <div class="col-sm-9">
                    <input type="date" class="form-control" name="marrydate" id="marrydate">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-3 control-label">手机</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入手机">
                </div>
                <div class="col-sm-3">
                    <button type="button" id="sendSmsBtn" class="btn btn-success">获取验证码</button>
                </div>
            </div>
            <div class="form-group">
                <label for="verifyCode" class="col-sm-3 control-label">验证码</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" name="verifyCode" id="verifyCode" placeholder="请输入验证码">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <button type="submit" style="width: 100px" class="btn btn-primary">注册</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 底部栏 -->
<div class="search_box">
    <!-- 底部开始 -->
    <div class='footer'>
        <div class='footer_warp'>
            <div class='footer_left'>
                <p class='footer_left_top'>联系我们</p>
                <p class='footer_left_content'>公司地址：北京市长安街天安门1号 / 监督电话：18812345678</p>
                <p class='footer_left_bottom'>copyright2016-2019 版权归Ting域主持人所有 </p>
            </div>
            <div class='footer_right'>
                <div class='QR_left'>
                    <img src="static/img/QR_04.png" alt="">
                    <div class='QR_left_img'>
                        <img src="static/img/QR_03.png" alt="">
                    </div>
                    <p>官方服务号</p>
                </div>
                <div class='QR_left'>
                    <img src="static/img/QR_02.png" alt="">
                    <div class='QR_left_img'>
                        <img src="static/img/QR_01.png" alt="">
                    </div>
                    <p>官方服务号</p>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部结束 -->
    <!-- 固定定位导航布局开始 -->
    <div class="QR_right">
        <div class='QR_right_top'>
            <!-- <img src="img/QR_small.png" alt=""> -->
            <img src="static/img/QR_small.png" alt="">
            <div class='QR_box'>
                <div class='QR_box_content'>
                    <img src="static/img/QR_right.png" alt="">
                    <p class='QR_box_content_font'>关注官方二维码接受订单通知</p>
                </div>
                <div class='QR_box_triangle'>
                    <img src="static/img/sanjiao.png" alt="">
                </div>
            </div>
        </div>
        <a href="#">
            <div class='QR_right_bottom'>
                <img src="static/img/jiantou.png" alt="">
            </div>
        </a>
    </div>
</div>


<%-- 表单属性验证 --%>
<script type="text/javascript">

    /* 自定义校验规则 */
    // 匹配汉字
    jQuery.validator.addMethod("isChinese", function (value, element) {
        return this.optional(element) || /^[\u4e00-\u9fa5]+$/.test(value);
    }, "只能输入汉字");

    // 匹配密码，以字母开头，长度在6-12之间，只能包含字符、数字和下划线。
    jQuery.validator.addMethod("isPwd", function (value, element) {
        return this.optional(element) || /^[a-zA-Z]\w{5,11}$/.test(value);
    }, "以字母开头，长度在6-12之间，只能包含字符、数字和下划线。");

    // 手机号码验证
    jQuery.validator.addMethod("isMobile", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-35-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "手机号码格式不正确。");

    /*
   * 使用Jquery.vlaidate.js进行表单的校验
   *    如果表单使用校验插件自动禁用表单同步提交
   *    必须使用校验插件校验成功以后函数进行处理
   *    注意：校验规则是通过表单的name值进行校验，不是通过id选择器校验
   */
    $(function () {
        /* 注册新人的表单校验 */
        $("#marryPersonForm").validate({

                /* rules: 校验规则 */
                rules: {
                    pname: {
                        required: true,
                        minlength: 2,
                        /* 使用自定义规则 */
                        isChinese: true
                    },
                    pmail: {
                        required: true,
                        email: true,
                    },
                    ppwd: {
                        required: true,
                        isPwd: true
                    },
                    checkPwd: {
                        required: true,
                        equalTo: "#ppwd"
                    },
                    marrydate: "required",
                    phone: "required",
                    verifyCode: {
                        required: true,
                        /* 远程ajax异步校验 ==> 校验成功 后台返回true 校验失败 返回false  */
                        remote: {
                            url: "checkVerifyCode.do", // 后台处理程序
                            type: "post",  // 数据发送方式
                            dataType: "json",  // 接收数据格式
                            data: {            // 要传递的数据
                                verifyCode: function () {
                                    return $("#verifyCode").val();
                                }
                            }
                        }
                    }
                },

                /* message: 校验失败后的提示信息 */
                messages: {
                    pname: {
                        required: "新人姓名不能为空",
                        minlength: "名字最少两个汉字",
                        isChinese: "姓名只能是中文汉字"
                    },
                    pmail: {
                        required: "邮箱不能为空",
                        email: "请输入正确的邮箱格式",
                    },
                    ppwd: {
                        required: "密码不能为空",
                        isPwd: "密码以字母开头，长度在6-12之间，只能包含字符、数字和下划线。"
                    },
                    checkPwd: {
                        required: "确认密码不能为空",
                        equalTo: "确认密码与密码不相同"
                    },
                    marrydate: "婚礼日期不能为空",
                    phone: "手机号不能为空",
                    verifyCode: {
                        required: "验证码不能为空",
                        remote: "验证码错误或验证码使用时限已过"
                    }
                },

                /* submitHandler:所有校验通过后的回调函数 */
                submitHandler: function (form) {
                    console.log(form)
                    /**
                     * 普通DOM对象转换成Jquery对象  $(dom对象)
                     * Jquery对象转换成普通DOM对象  var dom = jq对象[0];
                     */
                    // 序列化表单 并不是序列化成JSON 不需要json格式的对象 只是普通的序列化
                    var formData = $(form).serialize(); // pname=小米&ppwd=abc123& 这种格式的序列化

                    $.ajax({
                        type: "post",
                        url: "married/insert.do",
                        data: formData,
                        success: function (data) {
                            if (data.code == 200){
                                layer.msg("恭喜您，注册Ting域主持人品台账号成功",function () {
                                    window.location.href = "front/login.jsp"
                                })
                            }
                        }
                    })

                }
            }
        )

        /* 注册公司的表单校验 */
        $("#companyForm").validate({
            rules: {
                cname: {
                    required: true,
                    minlength: 2,
                    /* 使用自定义规则 */
                    isChinese: true
                },
                ceo: {
                    required: true,
                    minlength: 2,
                    isChinese: true
                },
                cpwd: {
                    required: true,
                    isPwd: true
                },
                cphone: {
                    required: true,
                    isMobile: true
                },
                cmail: {
                    required: true,
                    email: true,
                }
            },

            messages: {
                cname: {
                    required: "公司名称不能为空",
                    minlength: "公司名称最少2个汉字",
                    isChinese: "名称只能是汉字"
                },
                ceo: {
                    required: "法人名称不能为空",
                    minlength: "法人名称最少2个汉字",
                    isChinese: "名称只能是汉字"
                },
                cpwd: {
                    required: "密码不能为空",
                    isPwd: "密码以字母开头，长度在6-12之间，只能包含字符、数字和下划线。"
                },
                cphone: {
                    required: "手机号不能为空",
                    isMobile: "请输入正确的手机号码"
                },
                cmail: {
                    required: "邮箱不能为空",
                    email: "请输入正确的邮箱格式",
                }
            },
            submitHandler: function (form) {
                console.log(form)
            }
        })
    })


</script>


<%-- 验证码点击事件 --%>
<script type="text/javascript">

    $(function () {
        /* 验证码按钮初始化 */
        $("#sendSmsBtn").click(function () {
            var phone = $("#phone").val()
            if (phone == "") {
                layer.msg("手机不能为空", {icon: 5})
                return false;
            }

            // 正则表达式校验
            var partten = /^1([38][0-9]|4[5-9]|5[0-3,5-9]|66|7[0-8]|9[89])[0-9]{8}$/;

            if (!partten.test(phone)) {
                layer.msg("请输入正确的手机号", {icon: 5})
                return false;
            }

            /* 如果是html文件 没有配置基础路径. 所以这里的路径要使用 / 并写成绝对路径形式 ==> "/tingyu/sendSms.do"*/
            $.post(
                "sendSms.do",
                {phone: phone},
                function (data) {
                    var json = JSON.parse(data);
                    console.log(json)
                    // 定时器 1分钟倒计时
                    var time = 60;
                    if (json.Code == "OK") {
                        layer.msg("发送验证码成功", {icon: 6});
                        timer(time);
                    } else {
                        layer.msg("发送验证码失败,请1分钟后再点击发送", {icon: 5});
                        timer(time);
                    }
                }
            )
        })
    })

    /* 定义计时器 */
    function timer(time) {
        var setinterval = setInterval(function () {

            $("#sendSmsBtn").text(time + "秒后重新发送");
            // 禁用按钮
            $("#sendSmsBtn").attr("disabled", true);
            // 定时器时间到后
            if (time == 0) {
                $("#sendSmsBtn").text("发送验证码");
                // 恢复按钮
                $("#sendSmsBtn").attr("disabled", false);
                // 清除定时器
                clearInterval(setinterval);
            }
            time--;
        }, 1000)
    }

    function displayOrHidden(obj) {
        if (obj == "company") {
            $("#companyBox").css("display", "block");
            $("#marryPersonBox").css("display", "none")

        } else if (obj == "marryPerson") {
            $("#companyBox").css("display", "none");
            $("#marryPersonBox").css("display", "block")
        }
    }
</script>

</body>
</html>
