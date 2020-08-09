package com.fh.shop.admin.controller.product;

import com.fh.shop.admin.annocation.Log;
import com.fh.shop.admin.biz.product.IProductService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.product.ProductSearchParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.util.ExcelUtil;
import com.fh.shop.admin.util.FileUtil;
import com.fh.shop.admin.util.OSSUtil;
import com.fh.shop.admin.util.Upload;
import com.fh.shop.admin.vo.product.ProductVo;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.StringWriter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Resource(name="productService")
    private IProductService productService;

    @RequestMapping("/toList")
    public String toList(){

        return "/product/list";
    }

    @RequestMapping("/addProduct")
    @ResponseBody
    @Log(info = "新增商品")
    public ServerResponse addProduct(Product product){
        try {
            productService.addProduct(product);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ServerResponse.success();
    }

    @RequestMapping("/queryProductList")
    @ResponseBody
    public Map queryProductList(ProductSearchParam productSearchParam){

        return productService.queryProductList(productSearchParam);
    }

    @RequestMapping("/deleteProduct")
    @ResponseBody
    @Log(info = "删除商品")
    public ServerResponse deleteProduct(Long productId){
        ProductVo productVo = productService.queryProductById(productId);

        if(!StringUtils.isEmpty(productVo.getFileName())){
            //调用删除图片的工具类
            OSSUtil.deleteFile(productVo.getFileName());
        }

        productService.deleteProduct(productId);

        return ServerResponse.success();
    }

    @RequestMapping("/queryProductById")
    @ResponseBody
    public ServerResponse queryProductById(Long productId){
        ProductVo productVo = productService.queryProductById(productId);

        return ServerResponse.success(productVo);
    }

    @RequestMapping("/updProduct")
    @ResponseBody
    @Log(info = "修改商品")
    public ServerResponse updProduct(Product product,HttpServletRequest request){
        if(!StringUtils.isEmpty(product.getNewFileName())){
            //调用删除图片的工具类
            if(!StringUtils.isEmpty(product.getFileName())){
                OSSUtil.deleteFile(product.getFileName());
            }
            product.setFileName(product.getNewFileName());
        }

        productService.updProduct(product);

        return ServerResponse.success();
    }

    @RequestMapping("/upload")
    @ResponseBody
    public ServerResponse upload(MultipartFile image, HttpServletRequest request){
        String url = null;
        try {
            String originalFilename = image.getOriginalFilename();

            url = OSSUtil.uploadFile(image.getInputStream(), originalFilename);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return ServerResponse.success(url);
    }

    @RequestMapping("/uploadFile")
    @ResponseBody
    public ServerResponse uploadFile(MultipartFile file, HttpServletRequest request){

        String fileName = Upload.uploadFile(file, request);

        return ServerResponse.success(fileName);
    }

    //导出Excel
    @RequestMapping("exportExcel")
    public void exportExcel(ProductSearchParam productParam, HttpServletResponse response){
        //1.根据查询条件查询出符合条件的商品信息（注意是所有符合条件的数据，且不需要分页，因此不能直接调用条件查询的方法）
        List<Product> productList = productService.queryProductListNoPage(productParam);

        //2.运用java反射原理 将数据转为Excel数据
        String[] headerNames = {"商品名称","商品价格","生产日期","品牌名称","商品类型"};
        String[] props = {"productName","productPrice","createDate","brandName","classifyNames"};
        XSSFWorkbook workbook = ExcelUtil.getWorkbook(productList, "商品列表", headerNames, props);

        //3.调用工具类中下载excel文件方法
        //如下是以下载的方式，返回给客户端，而不是保存的形式，如 workbook.write(new FileOutputStream("d:/商品列表.xlsx"));
        FileUtil.excelDownload(workbook,response);
    }

    @RequestMapping("deleteBatch")
    @ResponseBody
    @Log(info = "批量删除商品")
    public ServerResponse deleteBatch(@RequestParam(name = "ids[]") Long[] ids){
        productService.deleteBatch(ids);

        return ServerResponse.success();
    }

    //导出pdf
    @RequestMapping("exportPdf")
    public void exportPdf(ProductSearchParam productSearchParam,HttpServletRequest request,HttpServletResponse response){
        List<Product> productList = productService.queryProductListNoPage(productSearchParam);

        StringWriter stringWriter = productService.getStringWriter(productList);

        FileUtil.pdfDownloadFile(response,stringWriter.toString());
    }

    @RequestMapping("updateIsHot")
    @ResponseBody
    @Log(info = "修改商品是否热销")
    public ServerResponse updateIsHot(Long id,int isHot){

        return productService.updateIsHot(id,isHot);
    }

    @RequestMapping("updateIsUp")
    @ResponseBody
    @Log(info = "修改商品是否上架")
    public ServerResponse updateIsUp(Long id,int isUp){

        return productService.updateIsUp(id,isUp);
    }

    @RequestMapping("/importExcel")
    @ResponseBody
    @Log(info = "导入商品Excel")
    public ServerResponse importExcel(String filePath,HttpServletRequest request){
        filePath = request.getServletContext().getRealPath(filePath);

        return productService.importExcel(filePath);
    }

    @RequestMapping("/exportWord")
    @ResponseBody
    public void exportWord(ProductSearchParam productSearchParam,HttpServletRequest request,HttpServletResponse response){
        List<Product> productList = productService.queryProductListNoPage(productSearchParam);

    }
}
