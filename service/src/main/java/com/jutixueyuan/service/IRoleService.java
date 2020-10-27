package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.Role;

/**
 *  服务类
 */
public interface IRoleService extends IService<Role> {
    /**
     * 新增或者修改角色和角色菜单表数据
     * @param role 角色信息
     * @param mids 菜单id
     */
    boolean saveOrUpdateRoleAndRoleMenu(Role role, Integer[] mids);

    // 删除指定id的角色信息
    boolean deleteByRid(Integer rid);
}
