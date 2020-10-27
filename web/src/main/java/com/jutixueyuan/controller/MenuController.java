package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jutixueyuan.pojo.Admin;
import com.jutixueyuan.pojo.Menu;
import com.jutixueyuan.pojo.ResultData;
import com.jutixueyuan.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 *  前端控制器
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private IMenuService menuService;

    @RequestMapping("/menuManager")
    public String menuManager(){
        return "menuManager";
    }

    // 通过当前登录用户查询对对应的菜单
    @ResponseBody
    @RequestMapping("/selectMenuByLoginAdmin")
    public List<Menu> list(HttpSession session){

        // 从Session获取登录用户信息
        Admin admin = (Admin) session.getAttribute("admin");
        // 要先登录 不登录没有admin 则没有aid 就会空指针异常
        List<Menu> menus = menuService.selectMenuByAdminId(admin.getAid());
        return menus;
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<Menu> list(){
//        System.out.println(menuService.list());
        return menuService.list();

    }

    // 修改或新增踩点
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ResultData saveOrUpdate(Menu menu){

        menu.setIsparent("1");
        menu.setStatus("0");
        boolean flag = menuService.saveOrUpdate(menu);

        return flag ? ResultData.ok("操作成功") : ResultData.error("操作数据失败,请联系管理员");
    }

    /**
     * 删除菜单
     * 删除思路
     * 1，先根据当前id去数据库查询是否还有子菜单
     *   1.1 有 提示用户不能删除
     *   1.2 没有： 可以删除
     * @param mid 菜单id
     */
    @RequestMapping("/delete")
    @ResponseBody
    public ResultData delete(Integer mid){

        // 1.根据当前id查询此菜单是否有子菜单
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("pid", mid);

        // 2.判断是否有子菜单
        List<Menu> childList = menuService.list(queryWrapper);
        if (childList.size() > 0){
            return ResultData.error("此菜单还有子菜单, 请先删除子菜单");
        }

        boolean flag = menuService.removeById(mid);
        return flag ? ResultData.ok("删除成功") :  ResultData.error("删除失败,请联系管理员");
    }
}

