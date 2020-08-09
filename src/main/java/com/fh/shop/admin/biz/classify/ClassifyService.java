package com.fh.shop.admin.biz.classify;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.classify.IClassifyMapper;
import com.fh.shop.admin.po.classify.Classify;
import com.fh.shop.admin.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service("classifyService")
public class ClassifyService implements  IClassifyService{

    @Autowired
    private IClassifyMapper classifyMapper;

    @Override
    public ServerResponse queryClassifyListAll() {
        List<Classify> list = classifyMapper.selectList(null);

        return ServerResponse.success(list);
    }

    @Override
    public void addClassify(Classify classify) {
        String classifyListStr = RedisUtil.get("classifyList");
        if(StringUtils.isNotEmpty(classifyListStr)){
            RedisUtil.del("classifyList");
        }

        classifyMapper.addClassify(classify);

    }

    @Override
    public void deleteClassify(Long[] ids) {
        List<Long> idList = Arrays.asList(ids);
        classifyMapper.deleteBatchIds(idList);

    }

    @Override
    public void updateClassify(Classify classify) {
        String classifyListStr = RedisUtil.get("classifyList");
        if(StringUtils.isNotEmpty(classifyListStr)){
            RedisUtil.del("classifyList");
        }

        classifyMapper.updateById(classify);

    }

    @Override
    public ServerResponse queryClassifyListByPid(Long id) {
        List<Classify> list = classifyMapper.queryClassifyListByPid(id);

        return ServerResponse.success(list);
    }

}
