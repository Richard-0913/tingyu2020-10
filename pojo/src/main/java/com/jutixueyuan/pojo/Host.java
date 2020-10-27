package com.jutixueyuan.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;

import java.io.Serializable;
import java.time.LocalDateTime;

@TableName("t_host")
public class Host extends Model<Host> {

    private static final long serialVersionUID=1L;

    @TableId(value = "hid", type = IdType.AUTO)
    private Integer hid;

    private String hname;

    private String hpwd;

    private String hphone;

    private LocalDateTime starttime;

    private String status;

    private String strong;

    private Integer ordernumber;

    private Integer hprice;

    // 联合查询中主持人的折扣信息
    private Integer hpdiscount;

    // 联合查询中主持人是否星推荐
    private Integer hpstar;

    public Integer getHpdiscount() {
        return hpdiscount;
    }

    public void setHpdiscount(Integer hpdiscount) {
        this.hpdiscount = hpdiscount;
    }

    public Integer getHpstar() {
        return hpstar;
    }

    public void setHpstar(Integer hpstar) {
        this.hpstar = hpstar;
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getHname() {
        return hname;
    }

    public void setHname(String hname) {
        this.hname = hname;
    }

    public String getHpwd() {
        return hpwd;
    }

    public void setHpwd(String hpwd) {
        this.hpwd = hpwd;
    }

    public String getHphone() {
        return hphone;
    }

    public void setHphone(String hphone) {
        this.hphone = hphone;
    }

    public LocalDateTime getStarttime() {
        return starttime;
    }

    public void setStarttime(LocalDateTime starttime) {
        this.starttime = starttime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStrong() {
        return strong;
    }

    public void setStrong(String strong) {
        this.strong = strong;
    }

    public Integer getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(Integer ordernumber) {
        this.ordernumber = ordernumber;
    }

    public Integer getHprice() {
        return hprice;
    }

    public void setHprice(Integer hprice) {
        this.hprice = hprice;
    }

    @Override
    protected Serializable pkVal() {
        return this.hid;
    }

    @Override
    public String toString() {
        return "Host{" +
                "hid=" + hid +
                ", hname='" + hname + '\'' +
                ", hpwd='" + hpwd + '\'' +
                ", hphone='" + hphone + '\'' +
                ", starttime=" + starttime +
                ", status='" + status + '\'' +
                ", strong='" + strong + '\'' +
                ", ordernumber=" + ordernumber +
                ", hprice=" + hprice +
                ", hpdiscount=" + hpdiscount +
                ", hpstar=" + hpstar +
                '}';
    }
}
