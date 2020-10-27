package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.jutixueyuan.pojo.DataGridResult;
import com.jutixueyuan.pojo.Host;
import com.jutixueyuan.pojo.ResultData;
import com.jutixueyuan.service.IHostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;

/**
 * 前端控制器
 */
@Controller
@RequestMapping("/host")
public class HostController {

    @Autowired
    private IHostService iHostService;

    // 跳转到主持人管理界面
    @RequestMapping("/hostManager")
    public String hostManager() {
        return "hostManager";
    }

    /**
     * 这里参数为page和rows的原因是: 初始化分页查询时,前端会发送两个参数过来分别是page和rows
     * @param host 搜索栏的搜索条件
     * @param page 分页的当前页面
     * @param rows 每一页的数据量
     * @return 分页对象: 封装着分页的数据 供给前端所用
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(Host host, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows) {
        // System.out.println(host);
        return iHostService.selectHostPageData(host, page, rows);
    }

    // 新增主持人
    @RequestMapping("/insert")
    @ResponseBody
    public ResultData insert(Host host) {

        // 把当前时间作为注册时间
        host.setStarttime(LocalDateTime.now());
        // 设置状态
        host.setStatus("1");
        // 设置权重
        host.setStrong("0");

        // 添加主持人
        boolean save = iHostService.save(host);

        if (save) {
            return ResultData.ok("添加主持人成功!");
        } else {
            return ResultData.error("添加失败,请检查数据");
        }
    }

    /**
     * 修改主持人是否启用的状态
     * @param hid    主持人id
     * @param status 主持人状态
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    public ResultData changeStatus(Integer hid, Integer status) {

        UpdateWrapper<Host> updateWrapper = new UpdateWrapper<>();

        updateWrapper.eq("hid", hid);
        if (status == 0) {
            updateWrapper.set("status", 1);
        } else if (status == 1) {
            updateWrapper.set("status", 0);
        }

        // 修改主持人是否启用的状态
        boolean update = iHostService.update(updateWrapper);

        if (update) {
            return ResultData.ok("修改主持人状态成功!");
        } else {
            return ResultData.error("修改失败,请联系管理员");
        }
    }

    /**
     * 修改主持人的权重
     * @param hid    主持人id
     * @param strong 主持人的权重
     */
    @RequestMapping("/changeStrong")
    @ResponseBody
    public ResultData changeStrong(Integer hid, Integer strong) {

        UpdateWrapper<Host> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("hid", hid);

        updateWrapper.set("strong", strong);

        // 修改主持人的权重
        boolean update = iHostService.update(updateWrapper);

        if (update) {
            return ResultData.ok("修改主持人权重成功!");
        } else {
            return ResultData.error("修改失败,请联系管理员");
        }
    }
}




