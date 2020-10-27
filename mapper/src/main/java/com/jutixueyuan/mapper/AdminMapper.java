package com.jutixueyuan.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jutixueyuan.pojo.Admin;

/**
 *  Mapper 接口
 */
public interface AdminMapper extends BaseMapper<Admin> {


//    @Select("select a.*, r.rname from t_admin_role ar " +
//            "left join t_admin a on ar.aid = a.aid " +
//            "left join t_role r  on ar.rid = r.rid ${ew.customSqlSegment}")
//    IPage<Admin> selectAdminPageData(@Param(Constants.WRAPPER) Wrapper wrapper, IPage<Admin> page);
}
