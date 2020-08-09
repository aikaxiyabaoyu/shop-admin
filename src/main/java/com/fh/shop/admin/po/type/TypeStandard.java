package com.fh.shop.admin.po.type;

import java.io.Serializable;

public class TypeStandard implements Serializable {

    private Long id;

    private Long typeId;

    private Long standardId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getTypeId() {
        return typeId;
    }

    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public Long getStandardId() {
        return standardId;
    }

    public void setStandardId(Long standardId) {
        this.standardId = standardId;
    }
}
