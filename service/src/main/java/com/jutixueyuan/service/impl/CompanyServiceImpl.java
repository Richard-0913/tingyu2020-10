package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.CompanyMapper;
import com.jutixueyuan.pojo.Company;
import com.jutixueyuan.service.ICompanyService;
import org.springframework.stereotype.Service;

/**
 *  服务实现类
 */
@Service
public class CompanyServiceImpl extends ServiceImpl<CompanyMapper, Company> implements ICompanyService {

}
