package com.fh.shop.admin.controller.classify;

import com.fh.shop.admin.annocation.Log;
import com.fh.shop.admin.biz.classify.IClassifyService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.classify.Classify;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/classify")
public class ClassifyController {

    @Resource(name="classifyService")
    private IClassifyService classifyService;

    @RequestMapping("/toList")
    public String toList(){

        return "/classify/list";
    }

    @RequestMapping("/queryList")
    @ResponseBody
    public ServerResponse queryClassifyListAll(){

        return classifyService.queryClassifyListAll();
    }

    @RequestMapping("/addClassify")
    @ResponseBody
    @Log(info = "新增分类")
    public ServerResponse addClassify(Classify classify){
        classifyService.addClassify(classify);

        return ServerResponse.success(classify);
    }

    @RequestMapping("/deleteClassify")
    @ResponseBody
    @Log(info = "删除分类")
    public ServerResponse deleteClassify(@RequestParam("ids[]") Long[] ids){
        classifyService.deleteClassify(ids);

        return ServerResponse.success();
    }

    @RequestMapping("/updateClassify")
    @ResponseBody
    @Log(info = "修改分类")
    public ServerResponse updateClassify(Classify classify){
        classifyService.updateClassify(classify);

        return ServerResponse.success(classify.getName());
    }

    @RequestMapping("/queryClassifyListByPid")
    @ResponseBody
    public ServerResponse queryClassifyListByPid(Long id){

        return classifyService.queryClassifyListByPid(id);
    }
}
