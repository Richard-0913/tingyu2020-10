package com.jutixueyuan.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jutixueyuan.pojo.Menu;

import java.util.List;

/**
 *  Mapper 接口
 */
public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 根据管理员的id查询出菜单信息
     * @param aid 管理员id
     * @return
     */
    List<Menu> selectMenuByAdminId(Integer aid);
}
