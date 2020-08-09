package com.fh.shop.admin.biz.brand;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.mapper.brand.IBrandMapper;
import com.fh.shop.admin.param.PageBean;
import com.fh.shop.admin.po.brand.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("brandService")
public class BrandServiceImpl implements IBrandService{

    @Autowired
    private IBrandMapper brandMapper;

    public DataTableResult queryBrandList(PageBean pageBean) {
        IPage<Brand> page = new Page<>(pageBean.getStart()/pageBean.getLength()+1,pageBean.getLength(),true);

        IPage<Brand> iPage = brandMapper.selectPage(page, null);

        return new DataTableResult(pageBean.getDraw(),iPage.getTotal(),iPage.getTotal(),iPage.getRecords());
    }

    @Override
    public void addBrand(Brand brand) {
        brand.setFileName(brand.getFileName().substring(0,brand.getFileName().length()-1));
        brandMapper.insert(brand);
    }

    @Override
    public void deleteBrand(Long brandId) {

        brandMapper.deleteById(brandId);
    }

    @Override
    public Brand queryBrandById(Long brandId) {

        return brandMapper.selectById(brandId);
    }

    @Override
    public void updateBrand(Brand brand) {
        if(brand.getFileName().equals(brand.getNewFileName())){
            brand.setFileName(brand.getFileName().substring(0,brand.getFileName().length()-1));
        }

        brandMapper.updateById(brand);
    }

    @Override
    public List<Brand> queryBrandListAll() {

        return brandMapper.selectList(null);

    }
}
