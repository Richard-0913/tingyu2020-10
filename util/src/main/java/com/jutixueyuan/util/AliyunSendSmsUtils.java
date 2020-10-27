package com.jutixueyuan.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

public class AliyunSendSmsUtils {

    // 生成随机码
    public static int getRandomCode() {
        return (int) (Math.random() * 899999 + 1) + 100000;
    }

    /**
     * 发送短信方法
     * @param phone 手机号
     * @param randomCode 随机码
     * @return 返回发送的结果信息
     */
    public static String sendSms(String phone, Integer randomCode){
        /* 配置发送短信基础核心 */
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI4G7cEBPSSAvUZZtUGkT5", "iyCpqygOqieTAQ5WVCtaZRG5Kuja4X");
        IAcsClient client = new DefaultAcsClient(profile);
        /* 短信请求对象 */
        CommonRequest request = new CommonRequest();
        /* 设置发送方式 */
        request.setSysMethod(MethodType.POST);
        /* 设置短信发送服务商域名 */
        request.setSysDomain("dysmsapi.aliyuncs.com");
        /* 短信发送api的版本 */
        request.setSysVersion("2017-05-25");
        /* 设置操作类型: SendSms 发送短信 */
        request.setSysAction("SendSms");
        /* 设置区域 */
        request.putQueryParameter("RegionId", "cn-hangzhou");
        /* 设置接收验证码手机号 */
        request.putQueryParameter("PhoneNumbers", phone);
        /* 设置短信签名 */
        request.putQueryParameter("SignName", "Ting域主持人");
        /* 设置短信模板的code */
        request.putQueryParameter("TemplateCode", "SMS_204760974");
        /* 设置发送随机码 */
        request.putQueryParameter("TemplateParam", "{\"code\":\"" + randomCode + "\"}");
        try {
            /* 发送请求并返回相应对象 */
            CommonResponse response = client.getCommonResponse(request);
            /* 获取对应的具体数据, json字符串 */
            System.out.println(response.getData());
            String data = response.getData();
            return data;
            // {"Message":"OK","RequestId":"971CA51E-C040-40AA-8F41-413360495133","BizId":"847424002905446937^0","Code":"OK"}
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return null;
    }

}
