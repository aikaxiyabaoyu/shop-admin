package com.fh.shop.admin.controller.brand;

import com.fh.shop.admin.annocation.Log;
import com.fh.shop.admin.biz.brand.IBrandService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.PageBean;
import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.util.Upload;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/brand")
public class BrandController {

    @Resource(name = "brandService")
    private IBrandService brandService;

    @RequestMapping("/toList")
    public String toList(){

        return "/brand/list";
    }

    @RequestMapping("toAdd")
    public String toAdd(){

        return "/brand/add";
    }

    @RequestMapping("/queryBrandList")
    @ResponseBody
    public DataTableResult queryBrandList(PageBean pageBean){

        return brandService.queryBrandList(pageBean);
    }

    @RequestMapping("/queryBrandListAll")
    @ResponseBody
    public ServerResponse queryBrandListAll(){
        List<Brand> list = brandService.queryBrandListAll();

        return ServerResponse.success(list);
    }

    @RequestMapping("/addBrand")
    @ResponseBody
    @Log(info = "新增品牌")
    public ServerResponse addBrand(Brand brand){
        brandService.addBrand(brand);

        return ServerResponse.success();
    }

    @RequestMapping("/deleteBrand")
    @ResponseBody
    @Log(info = "删除品牌")
    public ServerResponse deleteBrand(Long brandId){
        brandService.deleteBrand(brandId);

        return ServerResponse.success();
    }

    @RequestMapping("/queryBrandById")
    @ResponseBody
    public ServerResponse queryBrandById(Long brandId){
        Brand brand = brandService.queryBrandById(brandId);

        return ServerResponse.success(brand);
    }

    @RequestMapping("/updateBrand")
    @ResponseBody
    @Log(info = "修改品牌")
    public ServerResponse updateBrand(Brand brand,HttpServletRequest request){
        if(!StringUtils.isEmpty(brand.getNewFileName())){
            //调用删除图片的工具类
            Upload.deleteImage(brand.getFileName(),request);

            brand.setFileName(brand.getNewFileName());
        }

        brandService.updateBrand(brand);

        return ServerResponse.success();
    }
}
