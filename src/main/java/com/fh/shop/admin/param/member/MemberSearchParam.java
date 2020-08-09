package com.fh.shop.admin.param.member;

import com.fh.shop.admin.param.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class MemberSearchParam extends PageBean implements Serializable {

    private String name;

    private String realName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
        return "MemberSearchParam{" +
                "name='" + name + '\'' +
                ", realName='" + realName + '\'' +
                ", minDate=" + minDate +
                ", maxDate=" + maxDate +
                '}';
    }
}
