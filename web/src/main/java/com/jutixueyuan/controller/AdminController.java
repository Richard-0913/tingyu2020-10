package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jutixueyuan.pojo.Admin;
import com.jutixueyuan.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 前端控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService adminService;

//    @RequestMapping("/adminManager")
//    public String admin(){
//        return "adminManager";
//    }

    @RequestMapping("/login")
    public String login(String aname, String apwd, Model model, HttpSession session) {

        QueryWrapper<Admin> qw = new QueryWrapper<>();
        qw.eq("aname", aname);
        qw.eq("apwd", apwd);

        Admin admin = adminService.getOne(qw);
//        System.out.println("xxxxxxxxxx");
        System.out.println("admin = " + admin);
        if (admin == null) {
            model.addAttribute("errorMsg","账号或密码错误,请重新登录");
            return "forward:/login.jsp";
        }
        System.out.println("登录成功");
        // 共享登录用户对象
        session.setAttribute("admin", admin);

        // 如果使用请求转发,虽然页面是index页面 但是网址却不是index 而且是/admin/login.jsp
        // 该网页的逻辑是进行登录校验 逻辑校验成功的话 就应该重定向到新的页面
        return "redirect:/index.do";
    }

//    @RequestMapping("/list")
//    @ResponseBody
//    public DataGridResult list(Admin admin, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows){
//
//        return adminService.selectAdminPageData(admin, page, rows);
//    }
}

