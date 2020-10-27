package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.DataGridResult;
import com.jutixueyuan.pojo.Host;

/**
 *  服务类
 */
public interface IHostService extends IService<Host> {

    DataGridResult selectHostPageData(Host host, int page, int size);

}
