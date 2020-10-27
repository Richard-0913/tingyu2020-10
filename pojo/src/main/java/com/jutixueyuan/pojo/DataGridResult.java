package com.jutixueyuan.pojo;

import java.util.List;

// EasyUI DataGrid 显示数据对象 即结果集对象 传过去前端页面使用
// 前端页面需要的参数为total 与 rows 分页返回的数据格式的对象封装
public class DataGridResult {

    private Long total;

    private List<?> rows;

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<?> rows) {
        this.rows = rows;
    }
}
