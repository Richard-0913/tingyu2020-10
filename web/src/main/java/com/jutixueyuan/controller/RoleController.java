package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.pojo.AdminRole;
import com.jutixueyuan.pojo.DataGridResult;
import com.jutixueyuan.pojo.ResultData;
import com.jutixueyuan.pojo.Role;
import com.jutixueyuan.service.IAdminRoleService;
import com.jutixueyuan.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 *  前端控制器
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;
    @Autowired
    private IAdminRoleService adminRoleService;

    @RequestMapping("/roleManager")
    public String roleManager(){
        return "roleManager";
    }

    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows){

        Page<Role> rolePage = new Page<>(page, rows);

        Page<Role> result = roleService.page(rolePage);

        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(result.getRecords());
        dataGridResult.setTotal(result.getTotal());
        return dataGridResult;
    }

    // 由于该操作要进行两个表之间的操作 , 如果在这层进行操作出现错误将无法回滚,
    // 配置文件里的事务配置只配置在Service层 没有在controller层中配置 在业务层自定义方法
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ResultData saveOrUpdate(Role role, Integer[] mids){
        boolean flag = roleService.saveOrUpdateRoleAndRoleMenu(role, mids);

        return flag ? ResultData.ok("操作成功") : ResultData.error("操作数据失败，请联系管理员");
    }

    // 由于有两张表要进行删除 ==> 不能在这里进行处理 要在(业务层)Service层进行处理
    @RequestMapping("/deleteByRid")
    @ResponseBody
    public ResultData deleteByRid(Integer rid){

        // 删除之前先判断当前角色是否管理员, 如果有则不能删除
        // 从管理员表中搜索该rid 有则是管理员 不能删除
        QueryWrapper<AdminRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("rid", rid);

        List<AdminRole> adminRoles = adminRoleService.list(queryWrapper);
        if (adminRoles.size() > 0){
            return ResultData.error("此角色下面还有管理员, 不能删除");
        }

        boolean flag = roleService.deleteByRid(rid);
        return flag ? ResultData.ok("删除成功") : ResultData.error("删除失败，请联系管理员");
    }

}

