package com.fh.shop.admin.param.product;

import com.fh.shop.admin.param.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

public class ProductSearchParam extends PageBean {

    private String productName;

    private BigDecimal minPrice;

    private BigDecimal maxPrice;

    private Long brandId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

    private Long bigId;

    private Long middleId;

    private Long smallId;

    public Long getBigId() {
        return bigId;
    }

    public void setBigId(Long bigId) {
        this.bigId = bigId;
    }

    public Long getMiddleId() {
        return middleId;
    }

    public void setMiddleId(Long middleId) {
        this.middleId = middleId;
    }

    public Long getSmallId() {
        return smallId;
    }

    public void setSmallId(Long smallId) {
        this.smallId = smallId;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }

    public BigDecimal getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(BigDecimal maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Long getBrandId() {
        return brandId;
    }

    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }
}
