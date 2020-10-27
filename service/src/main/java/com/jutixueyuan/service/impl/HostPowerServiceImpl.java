package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.HostPowerMapper;
import com.jutixueyuan.pojo.HostPower;
import com.jutixueyuan.service.IHostPowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *  服务实现类
 */
@Service
public class HostPowerServiceImpl extends ServiceImpl<HostPowerMapper, HostPower> implements IHostPowerService {

    @Autowired
    private HostPowerMapper hostPowerMapper;

    @Override
    public boolean hostPowerSet(Integer[] hostids, HostPower hostPower) {

        for (Integer hostid : hostids) {
            // 1. 循环主持人id 将主持人的id设置到主持人权限表HostPower对象中
            hostPower.setHostid(hostid);
            // 2. 将主持人权限保存到数据库
            // 二选一 第一个baseMapper 不需要注入
//            int row = this.baseMapper.insert(hostPower);
            int row = hostPowerMapper.insert(hostPower);
            if (row != 1) {
                return false;
            }
        }
        return true;
    }
}
