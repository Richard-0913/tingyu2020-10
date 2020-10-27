package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.MenuMapper;
import com.jutixueyuan.pojo.Menu;
import com.jutixueyuan.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  服务实现类
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Override // 查询左侧的菜单
    public List<Menu> selectMenuByAdminId(Integer aid) {
        return menuMapper.selectMenuByAdminId(aid);
    }
}
