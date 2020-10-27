package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.AdminMapper;
import com.jutixueyuan.pojo.Admin;
import com.jutixueyuan.service.IAdminService;
import org.springframework.stereotype.Service;

/**
 *  服务实现类
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements IAdminService {

//    @Autowired
//    private AdminMapper adminMapper;
//
//    @Override
//    public DataGridResult selectAdminPageData(Admin admin, int page, int size) {
//
//        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
//        Page<Admin> adminPage = new Page<>(page, size);
//
//        IPage<Admin> result = adminMapper.selectAdminPageData(queryWrapper, adminPage);
//        DataGridResult dataGridResult = new DataGridResult();
//        dataGridResult.setTotal(result.getTotal());
//        dataGridResult.setRows(result.getRecords());
//        return dataGridResult;
//    }
}
