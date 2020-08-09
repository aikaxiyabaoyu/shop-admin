package com.fh.shop.admin.param.user;

import com.fh.shop.admin.param.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class UserSearchParam extends PageBean {

    private String userName;

    private String realName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

    private Long shengId;

    private Long shiId;

    private Long xianId;

    public Long getShengId() {
        return shengId;
    }

    public void setShengId(Long shengId) {
        this.shengId = shengId;
    }

    public Long getShiId() {
        return shiId;
    }

    public void setShiId(Long shiId) {
        this.shiId = shiId;
    }

    public Long getXianId() {
        return xianId;
    }

    public void setXianId(Long xianId) {
        this.xianId = xianId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getMinDate() {
        return minDate;
    }

    public void setMinDate(Date minDate) {
        this.minDate = minDate;
    }

    public Date getMaxDate() {
        return maxDate;
    }

    public void setMaxDate(Date maxDate) {
        this.maxDate = maxDate;
    }

    @Override
    public String toString() {
        return "UserSearchParam{" +
                "userName='" + userName + '\'' +
                ", realName='" + realName + '\'' +
                ", minDate=" + minDate +
                ", maxDate=" + maxDate +
                ", shengId=" + shengId +
                ", shiId=" + shiId +
                ", xianId=" + xianId +
                '}';
    }
}
