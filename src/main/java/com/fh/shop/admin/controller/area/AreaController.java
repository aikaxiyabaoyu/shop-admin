package com.fh.shop.admin.controller.area;

import com.fh.shop.admin.annocation.Log;
import com.fh.shop.admin.biz.area.IAreaService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.area.Area;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/area")
public class AreaController {

    @Resource(name="areaService")
    private IAreaService areaService;

    @RequestMapping("/toList")
    public String toList(){

        return "/area/list";
    }

    @RequestMapping("/queryList")
    @ResponseBody
    public ServerResponse queryAreaListAll(){

        return areaService.queryAreaListAll();
    }

    @RequestMapping("/addArea")
    @ResponseBody
    @Log(info = "新增地区")
    public ServerResponse addArea(Area area){
        areaService.addArea(area);

        return ServerResponse.success(area);
    }

    @RequestMapping("/deleteArea")
    @ResponseBody
    @Log(info = "删除地区")
    public ServerResponse deleteArea(@RequestParam("ids[]") Long[] ids){
        areaService.deleteArea(ids);

        return ServerResponse.success();
    }

    @RequestMapping("/updateArea")
    @ResponseBody
    @Log(info = "修改地区")
    public ServerResponse updateArea(Area area){
        areaService.updateArea(area);

        return ServerResponse.success(area.getName());
    }

    @RequestMapping("/queryAreaListByPid")
    @ResponseBody
    public ServerResponse queryAreaListByPid(Long id){

        return areaService.queryAreaListByPid(id);
    }
}