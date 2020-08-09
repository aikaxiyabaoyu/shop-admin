package com.fh.shop.admin.biz.product;

import com.fh.shop.admin.biz.brand.IBrandService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.product.IProductMapper;
import com.fh.shop.admin.param.product.ProductSearchParam;
import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.util.RedisUtil;
import com.fh.shop.admin.vo.product.ProductVo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.io.FileInputStream;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.util.*;

@Service("productService")
public class ProductServiceImpl implements IProductService{

    @Autowired
    private IProductMapper productMapper;

    @Resource(name = "brandService")
    private IBrandService brandService;

    @Override
    public void addProduct(Product product) {
        //去redis中查询是否已经存入了热销商品 如果已经存入 则清空
        String hotListStr = RedisUtil.get("hotList");
        if(!StringUtils.isEmpty(hotListStr)){
            RedisUtil.del("hotList");
        }

        if(!StringUtils.isEmpty(product.getFileName())){
            product.setFileName(product.getFileName().substring(0,product.getFileName().length()-1));
        }

        product.setEnteringDate(new Date());

        productMapper.insert(product);
    }

    @Override
    public Map queryProductList(ProductSearchParam productSearchParam) {
        //查询总条数
        Long total = productMapper.queryCount(productSearchParam);

        //查询分页数据
        List<Product> productPoList = productMapper.queryList(productSearchParam);

        List<ProductVo> productVoList = new ArrayList<>();
        for (int i = 0; i < productPoList.size(); i++){
            Product productPo = productPoList.get(i);
            ProductVo productVo = new ProductVo();

            productVo.setProductId(productPo.getProductId());
            productVo.setProductName(productPo.getProductName());
            productVo.setProductPrice(productPo.getProductPrice().toString());
            productVo.setBrandName(productPo.getBrandName());
            productVo.setBrandId(productPo.getBrandId());
            productVo.setCreateDate(DateUtil.date2string(productPo.getCreateDate(),DateUtil.Y_M_D));
            productVo.setEnteringDate(DateUtil.date2string(productPo.getEnteringDate(),DateUtil.Y_M_D_H_M_S));
            productVo.setUpdateDate(DateUtil.date2string(productPo.getUpdateDate(),DateUtil.Y_M_D_H_M_S));
            productVo.setFileName(productPo.getFileName());
            productVo.setIsHot(productPo.getIsHot());
            productVo.setIsUp(productPo.getIsUp());
            productVo.setClassifyNames(productPo.getBigName() + "==>" + productPo.getMiddleName() + "==>" + productPo.getSmallName());

            productVoList.add(productVo);
        }

        Map result = new HashMap();
        result.put("data",productVoList);
        result.put("draw",productSearchParam.getDraw());
        result.put("recordsTotal",total);
        result.put("recordsFiltered",total);

        return result;
    }

    @Override
    public void deleteProduct(Long productId) {
        String hotListStr = RedisUtil.get("hotList");
        if(!StringUtils.isEmpty(hotListStr)){
            RedisUtil.del("hotList");
        }

        productMapper.deleteById(productId);
    }

    public ProductVo queryProductById(Long productId) {
        Product productPo = productMapper.queryProductById(productId);

        ProductVo productVo = new ProductVo();
        productVo.setProductId(productPo.getProductId());
        productVo.setProductName(productPo.getProductName());
        productVo.setProductPrice(productPo.getProductPrice().toString());
        productVo.setBrandName(productPo.getBrandName());
        productVo.setBrandId(productPo.getBrandId());
        productVo.setCreateDate(DateUtil.date2string(productPo.getCreateDate(),DateUtil.Y_M_D));
        productVo.setFileName(productPo.getFileName());
        productVo.setBigId(productPo.getBigId());
        productVo.setMiddleId(productPo.getMiddleId());
        productVo.setSmallId(productPo.getSmallId());
        productVo.setClassifyNames(productPo.getBigName() + "==>" + productPo.getMiddleName() + "==>" + productPo.getSmallName());

        return productVo;
    }

    @Override
    public void updProduct(Product product) {
        String hotListStr = RedisUtil.get("hotList");
        if(!StringUtils.isEmpty(hotListStr)){
            RedisUtil.del("hotList");
        }

        if(product.getFileName().equals(product.getNewFileName())){
            product.setFileName(product.getFileName().substring(0,product.getFileName().length()-1));
        }
        product.setUpdateDate(new Date());

        productMapper.updateById(product);
    }

    @Override
    public List<Product> queryProductListNoPage(ProductSearchParam productParam) {

        List<Product> productList = productMapper.queryProductListNoPage(productParam);

        for (int i = 0; i < productList.size(); i++) {
            Product product = productList.get(i);
            product.setClassifyNames(product.getBigName() + "==>" + product.getMiddleName() + "==>" + product.getSmallName());
        }

        return productList;
    }

    @Override
    public void deleteBatch(Long[] ids) {
        String hotListStr = RedisUtil.get("hotList");
        if(!StringUtils.isEmpty(hotListStr)){
            RedisUtil.del("hotList");
        }

        List<Long> idList = Arrays.asList(ids);
        productMapper.deleteBatchIds(idList);

    }

    @Override
    public ServerResponse updateIsHot(Long id, int isHot) {
        String hotListStr = RedisUtil.get("hotList");
        if(!StringUtils.isEmpty(hotListStr)){
            RedisUtil.del("hotList");
        }

        Product product = new Product();
        product.setProductId(id);
        product.setIsHot(isHot);
        productMapper.updateById(product);

        return ServerResponse.success();
    }

    @Override
    public ServerResponse updateIsUp(Long id, int isUp) {
        String hotListStr = RedisUtil.get("hotList");
        if(!StringUtils.isEmpty(hotListStr)){
            RedisUtil.del("hotList");
        }

        Product product = new Product();
        product.setProductId(id);
        product.setIsUp(isUp);
        productMapper.updateById(product);

        return ServerResponse.success();
    }

    //将数据转为HTML代码
    public StringWriter getStringWriter(List<Product> productList){
        Configuration configuration = new Configuration();
        configuration.setDefaultEncoding("utf-8");
        configuration.setClassForTemplateLoading(this.getClass(),"/template");

        StringWriter stringWriter = new StringWriter();
        try {
            Template template = configuration.getTemplate("productTemplate.html");
            Map result = new HashMap();
            result.put("productList",productList);
            template.process(result,stringWriter);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return stringWriter;
    }

    //导入Excel
    public ServerResponse importExcel(String filePath) {
        try {
            FileInputStream fileInputStream = new FileInputStream(filePath);

            XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileInputStream);

            XSSFSheet sheet = xssfWorkbook.getSheetAt(0);
            int lastRowNum = sheet.getLastRowNum();

            for (int i = 1; i <= lastRowNum; i++) {
                XSSFRow row = sheet.getRow(i);
                String productName = row.getCell(0).getStringCellValue();
                double productPrice = row.getCell(1).getNumericCellValue();
                Date createDate = row.getCell(2).getDateCellValue();
                String brandName = row.getCell(3).getStringCellValue();

                Product product = new Product();
                product.setProductName(productName);
                BigDecimal bigDecimal = new BigDecimal(productPrice);
                product.setProductPrice(bigDecimal);
                product.setCreateDate(createDate);
                product.setEnteringDate(new Date());
                List<Brand> brandList = brandService.queryBrandListAll();
                if(!StringUtils.isEmpty(brandName)){
                    Long brandId = getBrandName(brandName, brandList);

                    if(null == brandId){
                        //新增品牌
                        Brand brand = new Brand();
                        brand.setBrandName(brandName);
                        brandService.addBrand(brand);
                        brandId = brand.getBrandId();
                    }

                    product.setBrandId(brandId);
                }

                productMapper.insert(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ServerResponse.success();
    }

    //循环比较brandName 返回brandId
    private Long getBrandName(String brandName, List<Brand> brandList) {
        for (int j = 0; j < brandList.size(); j++) {
            if(brandName.equals(brandList.get(j).getBrandName())){
                return brandList.get(j).getBrandId();
            }
        }

        return null;
    }
}
