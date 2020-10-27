package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.HostPower;

/**
 *  服务类
 */
public interface IHostPowerService extends IService<HostPower> {

    /**
     * 设置主持人权限
     * @param hostids 主持人id
     * @param hostPower 权限数据
     */
    boolean hostPowerSet(Integer[] hostids, HostPower hostPower);

}
