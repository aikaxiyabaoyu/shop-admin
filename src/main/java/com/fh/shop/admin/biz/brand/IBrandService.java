package com.fh.shop.admin.biz.brand;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.param.PageBean;
import com.fh.shop.admin.po.brand.Brand;

import java.util.List;
import java.util.Map;

public interface IBrandService {

    DataTableResult queryBrandList(PageBean pageBean);

    void addBrand(Brand brand);

    void deleteBrand(Long brandId);

    Brand queryBrandById(Long brandId);

    void updateBrand(Brand brand);

    List<Brand> queryBrandListAll();
}
