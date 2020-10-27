package com.jutixueyuan.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.jutixueyuan.pojo.Host;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 *  Mapper 接口
 */
public interface HostMapper extends BaseMapper<Host> {

    /**
     * 由于Mybatis-plus生成的代码自带分页查询和条件查询 两种一起查询的并没有 ==> 复杂的语句并不能在mapper处自己写
     * 自定义sql语句  ${ew.customSqlSegment} 固定语法 条件和分页对象都能组装进去 这是Mybatis-plus的自定义sql
     * 不能返回结果集
     * @param wrapper 条件对象
     * @param page 分页对象 装着当前页码 与 每页的数据数量(条数)
     * @return  返回的是自定义的结果集
     * 使用注解就要把对应xml的文件删除
     */
    @Select("select h.*,hp.hpdiscount,hp.hpstar from t_host h left join t_host_power hp on h.hid = hp.hostid ${ew.customSqlSegment}")
    IPage<Host> selectHostPageData(@Param(Constants.WRAPPER) Wrapper wrapper, IPage<Host> page);
}
