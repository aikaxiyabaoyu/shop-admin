package com.fh.shop.admin.controller.standard;

import com.fh.shop.admin.biz.standard.IStandardService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.PageBean;
import com.mysql.fabric.Server;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;


@Controller
@RequestMapping("/standard")
public class StandardController {

    @Resource(name = "standardService")
    private IStandardService standardService;

    @RequestMapping("toList")
    public String toList(){

        return "standard/list";
    }

    @RequestMapping("/toAdd")
    public String toAdd(){

        return "standard/add";
    }

    @RequestMapping("/addStandard")
    @ResponseBody
    public ServerResponse addStandard(String standardNameStr,String standardSortStr,String standardValueStr){

        return standardService.addStandard(standardNameStr,standardSortStr,standardValueStr);
    }

    @RequestMapping("queryStandardList")
    @ResponseBody
    public DataTableResult queryStandardList(PageBean pageBean){

        return standardService.queryStandardList(pageBean);
    }

    @RequestMapping("/deleteStandard")
    @ResponseBody
    public ServerResponse deleteStandard(Long id){

        return standardService.deleteStandard(id);
    }
}
