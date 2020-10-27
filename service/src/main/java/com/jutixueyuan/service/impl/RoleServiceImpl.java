package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.RoleMapper;
import com.jutixueyuan.mapper.RoleMenuMapper;
import com.jutixueyuan.pojo.Role;
import com.jutixueyuan.pojo.RoleMenu;
import com.jutixueyuan.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *  服务实现类
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private RoleMenuMapper roleMenuMapper;

    @Override
    public boolean saveOrUpdateRoleAndRoleMenu(Role role, Integer[] mids) {

        // 1.新增角色
        boolean flag = this.saveOrUpdate(role);

        if (flag){
            // 因为不只是增加还有修改的功能 ==> 先删除, 通过rid删除中间表t_role_menu中的所有当前角色id对应的数据
            UpdateWrapper<RoleMenu> roleMenuUpdateWrapper = new UpdateWrapper<>();
            roleMenuUpdateWrapper.eq("rid", role.getRid());
            roleMenuMapper.delete(roleMenuUpdateWrapper);

            // 2.循环菜单id数组，分别向角色菜单表中插入数据 t_role_menu
            for (Integer mid : mids) {
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setRid(role.getRid());
                roleMenu.setMid(mid);
                // 循环插入数据
                int insert = roleMenuMapper.insert(roleMenu);
                if (insert == 0){
                    return  false;
                }
            }
        }else {
            return false;
        }

        return true;
    }

    @Override
    public boolean deleteByRid(Integer rid) {

        // 1.删除角色表中的数据
        int row = baseMapper.deleteById(rid);
        // 2.删除角色菜单中间表中对应的角色信息
        if (row == 1) {

            UpdateWrapper<RoleMenu> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("rid", rid);
            row = roleMenuMapper.delete(updateWrapper);

            return row >= 1 ? true : false;
        }else {
            return false;
        }
    }
}
