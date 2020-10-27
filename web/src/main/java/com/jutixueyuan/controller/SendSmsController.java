package com.jutixueyuan.controller;

import com.jutixueyuan.util.AliyunSendSmsUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Objects;

/**
 * 发送短信验证码控制器
 */
@Controller
public class SendSmsController {

    @ResponseBody
    @RequestMapping("/sendSms")
    public Object sendSms(String phone, HttpSession session){

        // 1.生成随机码
        int randomCode = AliyunSendSmsUtils.getRandomCode();
        System.out.println(randomCode);
        // 2.将随机码存放到Session中 使后面可以进行验证码校验
        session.setAttribute("randomCode", randomCode);
        // 3.设置验证码的有效时间
        session.setMaxInactiveInterval(60);

        // 4.发送验证码
        String result = AliyunSendSmsUtils.sendSms(phone, randomCode);

        return result;
    }

    // 检查验证码
    @RequestMapping("/checkVerifyCode")
    @ResponseBody
    public boolean checkVerifyCode(String verifyCode, HttpSession session){

        Integer randomCode = (Integer) session.getAttribute("randomCode");
        // 有可能超过session的存放时间 导致验证码消失, 获取的对象为空 出现空指针异常
        if (Objects.nonNull(randomCode)){
            return verifyCode.equals(randomCode.toString());
        }else {
            return false;
        }
    }

}
