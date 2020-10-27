package com.jutixueyuan.controller;

import com.jutixueyuan.pojo.HostPower;
import com.jutixueyuan.pojo.ResultData;
import com.jutixueyuan.service.IHostPowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;

/**
 *  前端控制器
 */
@Controller
@RequestMapping("/hostPower")
public class HostPowerController {

    @Autowired
    private IHostPowerService hostPowerService;

    /**
     * 设置主持人的权限
     * @param hostids  主持人的id 可能有多个id 所以必须使用数组
     * @param hostPower 主持人的权限数据
     */
    @RequestMapping("/hostPowerSet")
    @ResponseBody
    public ResultData hostPowerSet(Integer[] hostids, HostPower hostPower){

        System.out.println(Arrays.toString(hostids));
        System.out.println(hostPower);

        boolean flag = hostPowerService.hostPowerSet(hostids, hostPower);
        if (flag) {
            return ResultData.ok("设置权限成功");
        }

        return ResultData.error("设置权限失败,请联系管理员");
    }

}

