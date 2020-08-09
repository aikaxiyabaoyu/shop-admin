package com.fh.shop.admin.param.log;

import com.fh.shop.admin.param.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class LogSearchParam extends PageBean {

    private String userName;

    private String realName;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date minDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date maxDate;

    private String info;

    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
