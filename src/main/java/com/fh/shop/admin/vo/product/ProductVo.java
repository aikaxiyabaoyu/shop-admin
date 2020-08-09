package com.fh.shop.admin.vo.product;

import java.io.Serializable;

public class ProductVo implements Serializable {

    private Long productId;

    private String productName;

    private String productPrice;

    private Long brandId;

    private String brandName;

    private String createDate;

    private String enteringDate;

    private String updateDate;

    private String fileName;

    private int isHot;

    private int isUp;

    private Long bigId;

    private Long middleId;

    private Long smallId;

    private String classifyNames;

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

    public String getClassifyNames() {
        return classifyNames;
    }

    public void setClassifyNames(String classifyNames) {
        this.classifyNames = classifyNames;
    }

    public int getIsUp() {
        return isUp;
    }

    public void setIsUp(int isUp) {
        this.isUp = isUp;
    }

    public int getIsHot() {
        return isHot;
    }

    public void setIsHot(int isHot) {
        this.isHot = isHot;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getEnteringDate() {
        return enteringDate;
    }

    public void setEnteringDate(String enteringDate) {
        this.enteringDate = enteringDate;
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    public Long getBrandId() {
        return brandId;
    }

    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }


}
