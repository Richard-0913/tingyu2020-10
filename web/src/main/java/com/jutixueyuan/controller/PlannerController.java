package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.pojo.DataGridResult;
import com.jutixueyuan.pojo.Planner;
import com.jutixueyuan.service.IPlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *  前端控制器
 */
@Controller
@RequestMapping("/planner")
public class PlannerController {

    @Autowired
    private IPlannerService plannerService;

    /**
     * 根据婚庆公司的id查询出对应的 策划师
     * @param cid 公司的id
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(Integer cid, Integer rows, Integer page){

        // 创建条件对象
        QueryWrapper<Planner> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("cid", cid);
        // 创建分页对象
        Page<Planner> plannerPage = new Page<>(page, rows);

        // 执行分页查询
        Page<Planner> result = plannerService.page(plannerPage, queryWrapper);

        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(result.getRecords());
        dataGridResult.setTotal(result.getTotal());

        return dataGridResult;
    }

}

