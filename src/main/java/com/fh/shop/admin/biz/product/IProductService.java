package com.fh.shop.admin.biz.product;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.product.ProductSearchParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.vo.product.ProductVo;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.StringWriter;
import java.util.List;
import java.util.Map;

public interface IProductService {

    void addProduct(Product product);

    Map queryProductList(ProductSearchParam productSearchParam);

    void deleteProduct(Long productId);

    ProductVo queryProductById(Long productId);

    void updProduct(Product product);

    List<Product> queryProductListNoPage(ProductSearchParam productParam);

    void deleteBatch(Long[] ids);

    ServerResponse updateIsHot(Long id, int isHot);

    ServerResponse updateIsUp(Long id, int isUp);

    ServerResponse importExcel(String filePath);

    StringWriter getStringWriter(List<Product> productList);
}
