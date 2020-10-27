package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.pojo.DataGridResult;
import com.jutixueyuan.pojo.MarriedPerson;
import com.jutixueyuan.pojo.ResultData;
import com.jutixueyuan.service.IMarriedPersonService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 前端控制器
 */
@Controller
@RequestMapping("/married")
public class MarriedPersonController {

    @Autowired
    private IMarriedPersonService marriedPersonService;

    @RequestMapping("/marriedManager")
    public String marriedManager() {
        return "marriedManager";
    }

    @ResponseBody
    @RequestMapping("/list")
    public DataGridResult list(MarriedPerson marriedPerson, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows) {

        // 创建条件对象
        QueryWrapper<MarriedPerson> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotBlank(marriedPerson.getPname())) {
            queryWrapper.like("pname", marriedPerson.getPname());
        }
        if (StringUtils.isNotBlank(marriedPerson.getPhone())) {
            queryWrapper.like("phone", marriedPerson.getPhone());
        }

        // 创建分页对象
        Page<MarriedPerson> marriedPersonPage = new Page<>(page, rows);

        // 自带的分页查询
        Page<MarriedPerson> result = marriedPersonService.page(marriedPersonPage, queryWrapper);

        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setTotal(result.getTotal());
        dataGridResult.setRows(result.getRecords());

        return dataGridResult;
    }

    @ResponseBody
    @RequestMapping("/insert")
    public ResultData insert(MarriedPerson marriedPerson){

        // 设置默认状态为启用状态
        marriedPerson.setStatus("1");
        // 设置当前时间为注册时间
//        marriedPerson.setRegdate(LocalDateTime.now());
        boolean flag = marriedPersonService.save(marriedPerson);

        return flag ? ResultData.ok("注册成功"):ResultData.error("注册失败！");
    }

    @ResponseBody
    @RequestMapping("/update")
    public ResultData update(MarriedPerson marriedPerson){

        boolean flag = marriedPersonService.saveOrUpdate(marriedPerson);

        return flag ? ResultData.ok("修改成功"):ResultData.error("修改失败！");
    }

    @ResponseBody
    @RequestMapping("/changePersonStatus")
    public ResultData changePersonStatus(Integer pid, String status){

        UpdateWrapper<MarriedPerson> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("pid", pid);
        if ("1".equals(status)){
            updateWrapper.set("status", "2");
        } else if ("2".equals(status)) {
            updateWrapper.set("status", "1");
        }

        boolean flag = marriedPersonService.update(updateWrapper);
        return flag ? ResultData.ok("操作成功"):ResultData.error("操作失败！请联系管理员");

    }
}

