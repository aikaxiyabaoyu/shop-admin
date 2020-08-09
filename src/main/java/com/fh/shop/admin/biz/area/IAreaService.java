package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.area.Area;

public interface IAreaService {

    ServerResponse queryAreaListAll();

    void addArea(Area area);

    void deleteArea(Long[] ids);

    void updateArea(Area area);

    ServerResponse queryAreaListByPid(Long id);
}