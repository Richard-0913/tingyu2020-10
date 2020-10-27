package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.pojo.Company;
import com.jutixueyuan.pojo.DataGridResult;
import com.jutixueyuan.pojo.ResultData;
import com.jutixueyuan.service.ICompanyService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * 前端控制器
 */
@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private ICompanyService companyService;

    // 跳转到婚庆公司管理界面
    @RequestMapping("/companyManager")
    public String companyManager() {
        return "companyManager";
    }

    @ResponseBody
    @RequestMapping("/list")
    public DataGridResult list(Company company, Integer page, Integer rows) {

        // 创建条件对象
        QueryWrapper<Company> companyQueryWrapper = new QueryWrapper<>();
        /*
         * 条件搜索可以在这里写, 不一定要在Service层(业务层)中写条件查询
         * 原因 : 一个业务有一个功能  就只是条件查询
         */

        if (StringUtils.isNotBlank(company.getCname())) {
            companyQueryWrapper.like("cname", company.getCname());
        }

        if (StringUtils.isNotBlank(company.getStatus())) {
            companyQueryWrapper.eq("status", company.getStatus());
        }

        if (Objects.nonNull(company.getOrdernumber())) {
            if (company.getOrdernumber() == 0) {
                companyQueryWrapper.orderByDesc("ordernumber");
            } else if (company.getOrdernumber() == 1) {
                companyQueryWrapper.orderByAsc("ordernumber");
            }
        }

        // 创建分页对象
        Page<Company> companyPage = new Page<>(page, rows);

        // 自带的分页查询
        Page<Company> result = companyService.page(companyPage, companyQueryWrapper);

        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setTotal(result.getTotal());
        dataGridResult.setRows(result.getRecords());

        return dataGridResult;
    }

    // 新增或修改公司
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ResultData saveOrUpdate(Company company) {

        // 设置注册日期, 新增才设置时间
        if (Objects.isNull(company.getCid())) {
            company.setStarttime(LocalDateTime.now());
            // 设置状态, 后台管理员录入公司信息默认已通过正常
            company.setStatus("1");
        }

        boolean flag = companyService.saveOrUpdate(company);
        if (flag) {
            return ResultData.ok("操作成功");
        } else {
            return ResultData.error("操作失败,请联系管理员");
        }

    }

    /**
     * 修改公司状态
     * @param cid 公司id
     * @param status 状态  0 未审核 1 正常 2 禁用
     */
    @ResponseBody
    @RequestMapping("/changeStatus")
    public ResultData changeStatus(Integer cid, String status) {

        UpdateWrapper<Company> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("cid", cid);
        if ("0".equals(status)){
            updateWrapper.set("status", "1");
        }else if ("1".equals(status)){
            updateWrapper.set("status", "2");
        }else if ("2".equals(status)){
            updateWrapper.set("status", "1");
        }

        boolean flag = companyService.update(updateWrapper);

        return flag ? ResultData.ok("操作成功") : ResultData.error("操作失败，请联系管理员");
    }

}

