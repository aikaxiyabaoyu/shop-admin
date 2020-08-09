package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.area.IAreaMapper;
import com.fh.shop.admin.po.area.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service("areaService")
public class AreaServiceImpl implements IAreaService{

    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public ServerResponse queryAreaListAll() {
        List<Area> list = areaMapper.selectList(null);

        return ServerResponse.success(list);
    }

    @Override
    public void addArea(Area area) {

        areaMapper.addArea(area);

    }

    @Override
    public void deleteArea(Long[] ids) {
        List<Long> idList = Arrays.asList(ids);
        areaMapper.deleteBatchIds(idList);

    }

    @Override
    public void updateArea(Area area) {

        areaMapper.updateById(area);

    }

    @Override
    public ServerResponse queryAreaListByPid(Long id) {
        List<Area> list = areaMapper.queryAreaListByPid(id);

        return ServerResponse.success(list);
    }
}
