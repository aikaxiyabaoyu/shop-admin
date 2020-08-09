package com.fh.shop.admin.biz.classify;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.classify.Classify;

public interface IClassifyService {

    ServerResponse queryClassifyListAll();

    void addClassify(Classify classify);

    void deleteClassify(Long[] ids);

    void updateClassify(Classify classify);

    ServerResponse queryClassifyListByPid(Long id);
    
}
