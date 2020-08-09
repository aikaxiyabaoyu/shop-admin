package com.fh.shop.admin.controller.type;

import com.fh.shop.admin.biz.type.ITypeService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.PageBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/type")
public class TypeController {

    @Resource(name = "typeService")
    private ITypeService typeService;

    @RequestMapping("/toAdd")
    public String toAdd(){

        return "type/add";
    }

    @RequestMapping("/toList")
    public String toList(){

        return "type/list";
    }

    @RequestMapping("/initTables")
    @ResponseBody
    public ServerResponse initTables(){

        return typeService.initTables();
    }

    @RequestMapping("/addType")
    @ResponseBody
    public ServerResponse addType(String typeName,String brandIds,String standardIds){

        return typeService.addType(typeName,brandIds,standardIds);
    }

    @RequestMapping("/queryTypeList")
    @ResponseBody
    public DataTableResult queryTypeList(PageBean pageBean){

        return typeService.queryTypeList(pageBean);
    }
}
