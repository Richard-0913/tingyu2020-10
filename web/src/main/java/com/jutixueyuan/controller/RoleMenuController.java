package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jutixueyuan.pojo.RoleMenu;
import com.jutixueyuan.service.IRoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 *  前端控制器
 */
@Controller
@RequestMapping("/roleMenu")
public class RoleMenuController {

    @Autowired
    private IRoleMenuService roleMenuService;

    /**
     * 根据角色的id 查询出对应的菜单id
     * @param rid 角色id
     * @return 角色拥有的菜单的id的集合
     */
    @RequestMapping("/selectRoleMenuByRid")
    @ResponseBody
    public List<Integer> selectRoleMenuByRid(Integer rid){

        // 创建条件对象
        QueryWrapper<RoleMenu> roleMenuQueryWrapper = new QueryWrapper<>();
        // 设置角色id条件
        roleMenuQueryWrapper.eq("rid", rid);
        // 查询所有的角色菜单信息
        List<RoleMenu> list = roleMenuService.list(roleMenuQueryWrapper);

        List<Integer> mids = new ArrayList<>();
        for (RoleMenu roleMenu : list) {
            mids.add(roleMenu.getMid());
        }

        return mids;
    }
}

