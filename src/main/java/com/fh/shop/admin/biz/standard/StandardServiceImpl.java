package com.fh.shop.admin.biz.standard;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.standard.IStandardMapper;
import com.fh.shop.admin.mapper.standard.IStandardValueMapper;
import com.fh.shop.admin.param.PageBean;
import com.fh.shop.admin.po.standard.Standard;
import com.fh.shop.admin.po.standard.StandardValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("standardService")
public class StandardServiceImpl implements IStandardService{

    @Autowired
    private IStandardMapper standardMapper;
    
    @Autowired
    private IStandardValueMapper standardValueMapper;

    @Override
    public ServerResponse addStandard(String standardNameStr, String standardSortStr, String standardValueStr) {
        String[] standardNameArr = standardNameStr.split(",");
        String[] standardSortStrArr = standardSortStr.split(",");
        String[] standardValueAll = standardValueStr.split(";");
        List<Integer> standardSortList = new ArrayList<>();

        for (int i = 0; i < standardNameArr.length; i++) {
            standardSortList.add(Integer.valueOf(standardSortStrArr[i]));
            Standard standard = new Standard();
            standard.setName(standardNameArr[i]);
            standard.setSort(standardSortList.get(i));
            standardMapper.insert(standard);

            String[] standardValueStr1 = standardValueAll[i].split(",");
            for (int j = 0; j < standardValueStr1.length; j++) {
                String[] split = standardValueStr1[j].split("=");
                StandardValue standardValue = new StandardValue();
                standardValue.setName(split[0]);
                standardValue.setSort(Integer.valueOf(split[1]));
                standardValue.setStandardId(standard.getId());
                standardValueMapper.insert(standardValue);
            }
        }

        return ServerResponse.success();
    }

    @Override
    public DataTableResult queryStandardList(PageBean pageBean) {
        IPage<Standard> iPage = new Page<>(pageBean.getStart()/pageBean.getLength()+1,pageBean.getLength());

        standardMapper.selectPage(iPage,null);

        return new DataTableResult(pageBean.getDraw(),iPage.getTotal(),iPage.getTotal(),iPage.getRecords());
    }

    @Override
    public ServerResponse deleteStandard(Long id) {
        standardMapper.deleteById(id);

        QueryWrapper<StandardValue> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("standardId",id);
        standardValueMapper.delete(queryWrapper);

        return ServerResponse.success();
    }
}
