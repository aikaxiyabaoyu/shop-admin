package com.fh.shop.admin.mapper.classify;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.classify.Classify;

import java.util.List;

public interface IClassifyMapper extends BaseMapper<Classify> {

    void addClassify(Classify classify);

    List<Classify> queryClassifyListByPid(Long id);

}
