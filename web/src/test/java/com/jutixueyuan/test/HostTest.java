package com.jutixueyuan.test;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.mapper.HostMapper;
import com.jutixueyuan.pojo.Host;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:springdao.xml")
public class HostTest {

    @Autowired
    private HostMapper hostMapper;

    @Test
    public void selectPageDataTest() {

        QueryWrapper<Host> hostQueryWrapper = new QueryWrapper<>();
        hostQueryWrapper.like("hname","刘");

        Page<Host> page = new Page<>();
        page.setCurrent(1);
        page.setSize(5);

        IPage<Host> hostIPage = hostMapper.selectHostPageData(hostQueryWrapper, page);
        System.out.println(hostIPage.getTotal());
        System.out.println(hostIPage.getRecords());
    }

}
