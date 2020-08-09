package com.fh.shop.admin.biz.type;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.brand.IBrandMapper;
import com.fh.shop.admin.mapper.standard.IStandardMapper;
import com.fh.shop.admin.mapper.type.ITypeMapper;
import com.fh.shop.admin.mapper.type.IType_BrandMapper;
import com.fh.shop.admin.mapper.type.IType_StandardMapper;
import com.fh.shop.admin.param.PageBean;
import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.po.standard.Standard;
import com.fh.shop.admin.po.type.Type;
import com.fh.shop.admin.po.type.TypeBrand;
import com.fh.shop.admin.po.type.TypeStandard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("typeService")
public class TypeServiceImpl implements ITypeService{

    @Autowired
    private ITypeMapper typeMapper;

    @Autowired
    private IBrandMapper brandMapper;

    @Autowired
    private IStandardMapper standardMapper;

    @Autowired
    private IType_BrandMapper type_brandMapper;

    @Autowired
    private IType_StandardMapper type_standardMapper;


    @Override
    public ServerResponse initTables() {
        List<Brand> brandList = brandMapper.selectList(null);

        List<Standard> standardList = standardMapper.selectList(null);

        Map<String, Object> result = new HashMap<>();

        result.put("brandList",brandList);
        result.put("standardList",standardList);

        return ServerResponse.success(result);
    }

    @Override
    public ServerResponse addType(String typeName, String brandIds, String standardIds) {
        Type type = new Type();
        type.setTypeName(typeName);
        typeMapper.insert(type);
        String newBrandIds = brandIds.substring(1);
        String newStandardIds = standardIds.substring(1);
        String[] brandIdArr = newBrandIds.split(",");
        String[] standardIdArr = newStandardIds.split(",");
        for (int i = 0; i < brandIdArr.length; i++) {
            TypeBrand type_brand = new TypeBrand();
            type_brand.setTypeId(type.getTypeId());
            type_brand.setBrandId(Long.valueOf(brandIdArr[i]));
            type_brandMapper.insert(type_brand);
        }

        for (int i = 0; i < standardIdArr.length; i++) {
            TypeStandard type_standard = new TypeStandard();
            type_standard.setTypeId(type.getTypeId());
            type_standard.setStandardId(Long.valueOf(standardIdArr[i]));
            type_standardMapper.insert(type_standard);
        }


        return ServerResponse.success();
    }

    @Override
    public DataTableResult queryTypeList(PageBean pageBean) {
        IPage<Type> iPage = new Page<>(pageBean.getStart()/pageBean.getLength()-1,pageBean.getLength());

        typeMapper.selectPage(iPage,null);

        return new DataTableResult(pageBean.getDraw(),iPage.getTotal(),iPage.getTotal(),iPage.getRecords());
    }
}
