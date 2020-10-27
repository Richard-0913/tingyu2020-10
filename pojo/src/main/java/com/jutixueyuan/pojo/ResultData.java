package com.jutixueyuan.pojo;

// ajax异步操作以后返回的数据对象
public class ResultData {

    private Integer code; //200 成功  500 错误

    private String msg;

    public static ResultData ok(String msg){
        ResultData resultData = new ResultData();
        resultData.code = 200;
        resultData.msg = msg;
        return resultData;
    }

    public static ResultData error(String msg){
        ResultData resultData = new ResultData();
        resultData.code = 500;
        resultData.msg = msg;
        return resultData;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
