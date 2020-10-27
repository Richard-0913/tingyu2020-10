package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.Menu;

import java.util.List;

/**
 *  服务类
 */
public interface IMenuService extends IService<Menu> {

    List<Menu> selectMenuByAdminId(Integer aid);
}
