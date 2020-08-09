package com.fh.shop.admin.util;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ExcelUtil {

    public static XSSFWorkbook getWorkbook(List dataList,String title,String[] headerNames,String[] props) {
        //2.创建一个工作簿
        XSSFWorkbook workbook = new XSSFWorkbook();
        //3.在工作簿中创建一张工作表
        XSSFSheet sheet = workbook.createSheet(title);
        //4.在工作表中创建一个标题行
        buildTitle(workbook, sheet, title, headerNames.length-1);
        //5.创建表头
        buildHeader(workbook,sheet, headerNames);
        //6.创建单元格
        buildCell(dataList, workbook, sheet, props);
        return workbook;
    }

    //创建Excel标题
    private static void buildTitle(XSSFWorkbook workbook, XSSFSheet sheet,String title,Integer titleWidth) {
        //新建一个单元格样式
        XSSFCellStyle style = workbook.createCellStyle();
        //新建一个字体样式
        XSSFFont font = workbook.createFont();
        //字号
        font.setFontHeightInPoints((short) 18);
        //加粗
        font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        //将字体样式给总样式
        style.setFont(font);
        //左右居中
        style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        //设置背景颜色
        style.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        //创建行
        XSSFRow titleRow = sheet.createRow(0);
        //创建单元格
        XSSFCell titleCell = titleRow.createCell(0);
        //给单元格赋值
        titleCell.setCellValue(title);
        //给单元格加样式
        titleCell.setCellStyle(style);
        //合并列
        CellRangeAddress region=new CellRangeAddress(0, 0, 0, titleWidth);
        sheet.addMergedRegion(region);
    }

    //创建Excel数据行
    private static void buildCell(List dataList, XSSFWorkbook workbook, XSSFSheet sheet, String[] props) {
        try {

            //创建一个年月日 时分秒格式的单元格样式
            XSSFCellStyle dateTimeStyle = workbook.createCellStyle();
            XSSFDataFormat dateTimeFormat = workbook.createDataFormat();//注意是工作簿中的方法
            dateTimeStyle.setDataFormat(dateTimeFormat.getFormat("yyyy年MM月dd日 HH:mm:ss"));
            
            //5.遍历商品集合，循环创建数据行
            for(int i = 0 ; i < dataList.size() ; i ++ ){
                //用一个对象接收集合元素。更方便
                Object data = dataList.get(i);
                //获取对象的类
                Class<?> dataClass = data.getClass();

                //创建数据行
                XSSFRow dataRow = sheet.createRow(i + 2);

                //循环表头行
                for (int j = 0; j < props.length; j++){
                    //获取当前循环的数据属性
                    Field dataField = dataClass.getDeclaredField(props[j]);
                    //开启访问权限 可以使用get set
                    dataField.setAccessible(true);
                    //获取当前循环的数据类型
                    Class<?> dataType = dataField.getType();
                    if(dataType == java.lang.Long.class){
                        dataRow.createCell(j).setCellValue(dataField.get(data).toString());
                    }
                    if(dataType == java.lang.String.class){
                        dataRow.createCell(j).setCellValue(dataField.get(data).toString());
                    }
                    if(dataType == java.util.Date.class){
                        XSSFCell cell = dataRow.createCell(j);
                        cell.setCellValue((Date) dataField.get(data));
                        cell.setCellStyle(dateTimeStyle);
                    }
                    if(dataType == java.lang.Integer.class){
                        dataRow.createCell(j).setCellValue(dataField.get(data).toString());
                    }
                    if(dataType == java.math.BigDecimal.class){
                        dataRow.createCell(j).setCellValue(new BigDecimal(dataField.get(data).toString()).doubleValue());
                    }
                }
            }
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    //新建Excel表头
    private static void buildHeader(XSSFWorkbook workbook,XSSFSheet sheet,String[] headerNames) {
        //新建一个单元格样式
        XSSFCellStyle style = workbook.createCellStyle();
        //新建一个字体样式
        XSSFFont font = workbook.createFont();
        //加粗
        font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        //将字体样式给总样式
        style.setFont(font);
        //左右居中
        style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        //在工作表中创建一个表头行
        XSSFRow headerRow = sheet.createRow(1);
        //创建表头数据数组
        String[] headerNameArr = headerNames;
        //循环表头数据数组
        for(int i = 0; i < headerNameArr.length; i++){
            //创建单元格
            XSSFCell headerCell = headerRow.createCell(i);
            //给单元格赋值
            headerCell.setCellValue(headerNameArr[i]);
            //给单元格加样式
            headerCell.setCellStyle(style);
        }
    }
}
