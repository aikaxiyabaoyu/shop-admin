<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2019/12/14
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <jsp:include page="../common/nav.jsp"/>
    <%--条件查询与列表的div--%>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                        <div class="panel-heading">商品查询</div>
                        <div class="panel-body">
                        <form class="form-horizontal" method="post" id="productForm">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">商品名</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="productName" id="productName" placeholder="请输入商品名">
                                </div>
                                <label  class="col-sm-2 control-label">价格范围</label>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="minPrice" id="minPrice" placeholder="请输入最小价格">
                                        <span class="input-group-addon" id="basic-addon1">-</span>
                                        <input type="text" class="form-control" name="maxPrice" id="maxPrice" placeholder="请输入最大价格">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">品牌名称</label>
                                <div class="col-sm-4" id="brandSelectDiv">

                                </div>
                                <label class="col-sm-2 control-label">日期区间</label>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" name="minDate" class="form-control" id="minDate"/>
                                        <span class="input-group-addon">-</span>
                                        <input type="text" name="maxDate" class="form-control" id="maxDate"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="classifyDiv">
                                <label  class="col-sm-2 control-label">商品类型</label>
                                <input type="hidden" name="bigId" id="bigId">
                                <input type="hidden" name="middleId" id="middleId">
                                <input type="hidden" name="smallId" id="smallId">
                            </div>
                            <div class="form-group" style="text-align: center">
                                <button type="button" class="btn btn-primary" onclick="search();"><i class="glyphicon glyphicon-search"></i> 查询</button>
                                <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">商品列表</div>
                    <button style="margin: 10px 0px" type="button" class="btn btn-primary" onclick="addProduct()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button onclick="deleteBatch()" type="reset" class="btn btn-danger">
                        <span class="glyphicon glyphicon-trash"></span>&nbsp;批量删除
                    </button>
                    <button onclick="exportExcel()" type="reset" class="btn btn-info">
                        <span class="glyphicon glyphicon-download"></span>&nbsp;导出Excel
                    </button>
                    <button onclick="importExcel()" type="button" class="btn btn-success">
                        <span class="glyphicon glyphicon-upload"></span>&nbsp;导入Excel
                    </button>
                    <button onclick="exportWord()" type="button" class="btn btn-info">
                        <span class="glyphicon glyphicon-download"></span>&nbsp;导出Word
                    </button>
                    <button onclick="exportPdf()" type="button" class="btn btn-info">
                        <span class="glyphicon glyphicon-download"></span>&nbsp;导出pdf
                    </button>

                    <table id="productTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                        <tr>
                            <th></th>
                            <th>商品名称</th>
                            <th>商品价格</th>
                            <th>是否热卖</th>
                            <th>是否上架</th>
                            <th>分类名称</th>
                            <th>品牌名称</th>
                            <th>出厂日期</th>
                            <th>录入日期</th>
                            <th>修改日期</th>
                            <th>商品图片</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--新增商品的div--%>
    <div id="addProductDiv" style="display: none">
        <form class="form-horizontal">
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">商品名称</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="addProductName" placeholder="请输入商品名称"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">商品价格</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="addProductPrice" placeholder="请输入商品价格"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">品牌名称</label>
                    <div class="col-md-10" id="addBrandSelectDiv">
                    </div>
                </div>
            </div>
            <div class="form-group" id="addClassifyDiv">
                <label class="col-md-2 control-label">商品类型</label>

            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">出厂日期</label>
                    <div class="col-md-10">
                        <input class="form-control" type="text"  id="addCreateDate"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <input id="addFileName"/>
                <div class="row">
                    <label class="col-md-2 control-label">商品图片</label>
                    <div class="col-md-10">
                        <input class="form-control" type="file" multiple name="image" id="addImage"/>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <%--导入Excel的div--%>
    <div id="importExcelDiv" style="display: none">
        <form>
            <input type="file" class="form-control" name="file" id="file">
            <input type="text" name="fileName" id="fileName"/>
        </form>
    </div>

    <%--修改商品的div--%>
    <div id="updProductDiv" style="display:none">
        <form>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">商品名称</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="updProductName" placeholder="请输入商品名称"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">商品价格</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" id="updProductPrice" placeholder="请输入商品价格"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">商品类型</label>
                <div class="col-md-10" id="updClassifyDiv">
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">品牌名称</label>
                    <div class="col-md-10" id="updBrandSelectDiv">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">出厂日期</label>
                    <div class="col-md-10">
                        <input class="form-control" type="text" id="updCreateDate"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">商品图片</label>
                    <div class="col-md-10">
                        <input type="text" id="updOldFileName"/>
                        <input type="text" id="updNewFileName"/>
                        <input multiple name="image" class="form-control" type="file" id="updImage"/>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
<script>

    var v_ids = [];
    var v_status = 1;
    var product;
    var importExcelHTML;
    var addProductDivHTML;
    var updProductDivHTML;


    //页面加载事件
    $(function(){
        initClassifySelect(1);
        initAddClassifySelect(1);
        initProductTable();
        initBrandSelect("brandSelect","#brandSelectDiv");
        initBrandSelect("updBrandSelect","#updBrandSelectDiv");
        initTrOnclick();
        initCreateDate("#minDate");
        initCreateDate("#maxDate");
        importExcelHTML = $("#importExcelDiv").html();
        addProductDivHTML = $("#addProductDiv").html();
        updProductDivHTML = $("#updProductDiv").html();

    })

    function classifySelectChange(){
        if(v_status == 1){
            $("#updClassifyDiv").html("");
            initUpdClassifySelect(1);
            $("#updClassifyDiv").html("<button type=\"button\" class=\"btn btn-danger\" onclick=\"classifySelectChange();\"><i class=\"glyphicon glyphicon-trash\"></i> 取消编辑</button>");
            v_status = 2;
        }else{
            $("#updClassifyDiv").html("");
            $("#updClassifyDiv").html(product.classifyNames + '<button type="button" class="btn btn-success" onclick="classifySelectChange();"><i class="glyphicon glyphicon-pencil"></i> 编辑</button>');
            v_status = 1;
        }
    }

    function initClassifySelect(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/classify/queryClassifyListByPid.jhtml",
            "data":{"id":id},
            success:function (result){
                if(result.data != null && result.data.length > 0){
                    var v_classifyList = result.data;
                    var v_html = '<div class="col-md-3"><select name="classifySelect" onchange="initClassifySelect(this.value,this)" class="form-control"><option value="-1">===请选择===</option>';
                    for (var i = 0; i < v_classifyList.length; i++) {
                        var classify = v_classifyList[i];
                        v_html += '<option value="'+ classify.id +'">'+ classify.name +'</option>';
                    }
                    v_html += "</select></div>";

                    $("#classifyDiv").append(v_html);
                }
            }
        })
    }

    function initAddClassifySelect(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }

        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/classify/queryClassifyListByPid.jhtml",
            "data":{"id":id},
            success:function (result){
                if(result.data != null && result.data.length > 0){
                    var v_classifyList = result.data;
                    var v_html = '<div class="col-md-3"><select name="addClassifySelect" onchange="initAddClassifySelect(this.value,this)" class="form-control"><option value="-1">===请选择===</option>';
                    for (var i = 0; i < v_classifyList.length; i++) {
                        var classify = v_classifyList[i];
                        v_html += '<option value="'+ classify.id +'">'+ classify.name +'</option>';
                    }
                    v_html += "</select></div>";

                    $("#addClassifyDiv").append(v_html);
                }
            }
        })
    }

    function initUpdClassifySelect(id,obj){

        if(obj){
            $(obj).parent().nextAll().remove();
        }

        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/classify/queryClassifyListByPid.jhtml",
            "data":{"id":id},
            success:function (result){
                if(result.data != null && result.data.length > 0){
                    var v_classifyList = result.data;
                    var v_html = '<div class="col-md-3"><select name="updClassifySelect" onchange="initUpdClassifySelect(this.value,this)" class="form-control"><option value="-1">===请选择===</option>';
                    for (var i = 0; i < v_classifyList.length; i++) {
                        var classify = v_classifyList[i];
                        v_html += '<option value="'+ classify.id +'">'+ classify.name +'</option>';
                    }
                    v_html += "</select></div>";

                    $("#updClassifyDiv").append(v_html);
                }
            }
        })
    }

    //初始化文件上传插件
    function initFileInput(fileId,hiddenId){
        $(fileId).fileinput({
            language:"zh",
            previewFileType:"text",//设置需要预览的文件类型
            uploadClass:"btn btn-danger",
            allowedFileExtensions:["xlsx","xls"],
            maxFileSize:1024*20,
            maxFileCount:5,
            initialPreviewAsData:true,
            //设置上传文件的地址
            uploadUrl:"<%=request.getContextPath()%>/product/uploadFile.jhtml",
            uploadExtraData:function(){
                var a = {};
                a.abc = 1234;
                return a;
            }
        })

        //用于文件上传结果处理的回调函数，没上传一个文件就会调用一下这个函数
        $(fileId).on("fileuploaded",function(event,data,previewId,index){
            //获取服务器返回的数据
            var result = data.response;
            if(result.code == 200){
                $(hiddenId,importExcelDiaLog).val(result.data);
            }
        });
    }

    //初始化新增与修改的文件上传插件
    function initAddAndUpdFileInput(fileId,hiddenId,fileNameArr){
        $(fileId).fileinput({
            language:"zh",
            previewFileType:"text",//设置需要预览的文件类型
            uploadClass:"btn btn-danger",
            allowedFileTypes:["image","text"],
            allowedFileExtensions:["jpg","gif","txt","pdf"],
            maxFileSize:1024*20,
            maxFileCount:5,
            initialPreview:fileNameArr,
            initialPreviewAsData:true,
            //设置上传文件的地址
            uploadUrl:"<%=request.getContextPath()%>/product/upload.jhtml",
            uploadExtraData:function(){
                var a = {};
                a.abc = 1234;
                return a;
            }
        })

        //用于文件上传结果处理的回调函数，没上传一个文件就会调用一下这个函数
        $(fileId).on("fileuploaded",function(event,data,previewId,index){
            //获取服务器返回的数据
            var result = data.response;
            if(result.code == 200){
                $(hiddenId).val($(hiddenId).val()+result.data+",");
            }
        });
    }

    //初始化表单中的下拉框
    function initBrandSelect(selectId,selectDiv){
        $.ajax({
            url:"<%=request.getContextPath()%>/brand/queryBrandListAll.jhtml",
            type: "post",
            success:function(result){
                if(result.code == 200){
                    var v_brandList = result.data;
                    var v_selectHTML = "<select class='form-control' id='"+ selectId +"'><option value='-1'>===请选择===</option>";
                    for(var i = 0;i < v_brandList.length;i++){
                        var brand = v_brandList[i];

                        v_selectHTML += '<option value="'+ brand.brandId +'">'+ brand.brandName +'</option>';
                    }
                    v_selectHTML += "</select>";

                    $(selectDiv).html(v_selectHTML);
                }else{
                    alert("初始化下拉框失败");
                }
            }
        })
    }

    //新增商品
    var addProductDiaLog;
    function addProduct(){
        initBrandSelect("addBrandSelect","#addBrandSelectDiv");
        initCreateDate("#addCreateDate");
        initAddAndUpdFileInput("#addImage","#addFileName");
        addProductDiaLog = bootbox.confirm({
            title:"新增商品",
            size:"large",
            message:$("#addProductDiv form"),
            buttons:{
                confirm:{
                    label:"确认"
                },
                cancel:{
                    label:"取消",
                    className:"btn btn-danger"
                }
            },
            callback:function(result){
                if(result){
                    //获取新增商品表单中的数据
                    var v_param = {};

                    v_param.productName = $("#addProductName",addProductDiaLog).val();
                    v_param.productPrice = $("#addProductPrice",addProductDiaLog).val();
                    v_param.brandId = $("#addBrandSelect",addProductDiaLog).val();
                    v_param.createDate = $("#addCreateDate",addProductDiaLog).val();
                    v_param.fileName = $("#addFileName",addProductDiaLog).val();
                    v_param.bigId = $($("select[name=addClassifySelect]")[0]).val();
                    v_param.middleId = $($("select[name=addClassifySelect]")[1]).val();
                    v_param.smallId = $($("select[name=addClassifySelect]")[2]).val();

                    //发起新增用户的ajax请求
                    $.ajax({
                        url:"<%=request.getContextPath()%>/product/addProduct.jhtml",
                        type:"post",
                        data:v_param,
                        dataType:"json",
                        success:function(result){
                            if(result.code == 200){
                                search();
                            }
                        },
                        error:function(){
                            alert("添加失败!");
                        }
                    });
                }
                $("#addProductDiv").html(addProductDivHTML);
                initAddClassifySelect(1);
            }
        });
    }

    //导入Excel
    var importExcelDiaLog;
    function importExcel(){
        initFileInput("#file","#fileName");
        importExcelDiaLog = bootbox.confirm({
            size:"large",
            title:"导入Excel",
            message:$("#importExcelDiv form"),
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> 取消'
                },
                confirm: {
                    label: '<i class="fa fa-check"></i> 确定'
                }
            },
            callback:function (result) {
                if(result){
                    var v_excelPath = $("#fileName",importExcelDiaLog).val();
                    console.log(v_excelPath);
                    $.ajax({
                        "type":"post",
                        "url":"<%=request.getContextPath()%>/product/importExcel.jhtml",
                        "data":{"filePath":v_excelPath},
                        success:function (result) {
                            if(result.code){
                                alert("导入成功！");
                                search();
                            }
                        }
                    })
                }
            }
        });
        $("#importExcelDiv").html(importExcelHTML);
    }

    //批量删除
    function deleteBatch(){
        if(v_ids.length > 0){
            bootbox.confirm({
                size:"small",
                title: "批量删除商品",
                message: "您确定要删除吗？",
                buttons: {
                    cancel: {
                        label: '<i class="fa fa-times"></i> 取消'
                    },
                    confirm: {
                        label: '<i class="fa fa-check"></i> 确定'
                    }
                },
                callback: function (result) {
                    if(result){
                        $.ajax({
                            url:"<%=request.getContextPath()%>/product/deleteBatch.jhtml",
                            type:"post",
                            dataType:"json",
                            data:{
                                "ids":v_ids
                            },
                            success:function(result){
                                if(result.code == 200){
                                    alert("删除成功");
                                    productTable.ajax.reload();
                                }
                            }
                        })
                    }
                }
            });
        }else{
            bootbox.alert({
                size:"small",
                title:"提示",
                message:"请选择你要删除的商品！",
            });
        }

    }

    //给每一行动态绑定单击事件
    function initTrOnclick(){

        $("#productTable tbody").on("click","tr",function(){
            //通过jquery中的find方法找到复选复选框
            var v_checkbox = $(this).find("input[name='ids']:checkbox");
            //通过prop方法获取复选框状态
            var v_checked = v_checkbox.prop("checked");

            if(v_checked){
                $(this).css("background","");
                v_checkbox.prop("checked",false);
                for(var i = v_ids.length;i >= 0;i--){
                    if(v_checkbox.val() == v_ids[i]){
                        v_ids.splice(i,1);
                    }
                }
                console.log(v_ids);
            }else{
                $(this).css("background","blue");
                v_checkbox.prop("checked",true);
                v_ids.push(v_checkbox.val());
                console.log(v_ids);
            }
        })
    }

    //导出Excel
    function exportExcel(){
        var productForm = document.getElementById("productForm");
        //设置form表单的提交地址（利用js方式设置表单提交路径比直接写在form标签里灵活性更好）
        productForm.action = "/product/exportExcel.jhtml";
        //通过js代码的方式提交form表单（注意，form标签里的method属性值为post）
        productForm.submit();
    }

    //导出Word
    function exportWord() {
        var productForm = document.getElementById("productForm");
        //设置form表单的提交地址
        productForm.action = "/product/exportWord.jhtml";
        //通过js代码的方式提交form表单
        productForm.submit();
    }

    //导出pdf
    function exportPdf() {
        var productForm = document.getElementById("productForm");
        //设置form表单的提交地址（利用js方式设置表单提交路径必直接写在form标签里灵活性更好）
        productForm.action = "/product/exportPdf.jhtml";
        //通过js代码的方式提交form表单（注意，form标签里的method属性值为post）
        productForm.submit();
    }

    //初始化日期插件
    function initCreateDate(dateId) {
        $(dateId).datetimepicker({
            format:"YYYY-MM-DD",
            locale:"zh-CN",
            showClear:true
        });
    }

    //初始化dataTables表格
    var productTable;
    function initProductTable(){
        productTable = $("#productTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            "bStateSave":true,
            "drawCallback":function(){
                $("#productTable tbody tr").each(function () {
                    var v_checkbox = $(this).find("input[name='ids']:checkbox");
                    var v_checkboxVal = v_checkbox.val();
                    for (var i = v_ids.length; i >= 0; i--){
                        if(v_checkboxVal == v_ids[i]){
                            $(this).css("background","blue");
                            v_checkbox.prop("checked",true);
                        }
                    }
                })
            },

            ajax:{

                "url":"/product/queryProductList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"productId",
                    render:function (data) {
                        return '<input type="checkbox" value="'+ data +'" name="ids"/>';
                    }
                },
                {"data":"productName",
                },
                {"data":"productPrice"},
                {"data":"isHot",
                    render:function (data) {
                        return data==1?"热卖":"非热卖";
                    }
                },
                {"data":"isUp",
                    render:function (data) {
                        return data==1?"是":"否";
                    }
                },
                {"data":"classifyNames"},
                {"data":"brandName"},
                {"data":"createDate"},
                {"data":"enteringDate"},
                {"data":"updateDate"},
                {"data":"fileName",
                    render:function (data) {
                        if(data != null && data.length > 0){
                            var imageArr = data.split(",");
                            var image = "";
                            var v_style = "margin-left:5px";
                            for(var i = 0; i < imageArr.length; i++){
                                image += '<img style="'+ v_style +'" height="50px" src="<%=request.getContextPath()%>'+ imageArr[i] +'"/>';
                            }
                            return image;
                        }else{
                            return "";
                        }
                    }
                },
                {"data":"productId",
                    render:function (data,type,row) {
                        var v_isHot = row.isHot;
                        var v_content = "";
                        var v_style = "";
                        var v_class = "";
                        var v_isHotStatus;
                        if(v_isHot == 0){
                            v_content = "热卖";
                            v_isHotStatus = "1";
                            v_style = "glyphicon glyphicon-fire";
                            v_class = "btn btn-success";
                        }else{
                            v_content = "非热卖";
                            v_isHotStatus = "0";
                            v_style = "glyphicon glyphicon-tint";
                            v_class = "btn btn-default";
                        }
                        var aaa = data + "," + v_isHotStatus;
                        var v_isUp = row.isUp;
                        var v_isUpContent = "";
                        var v_isUpStyle = "";
                        var v_isUpClass = "";
                        var v_isUpStatus;
                        if(v_isUp == 0){
                            v_isUpContent = "上架";
                            v_isUpStatus = "1";
                            v_isUpStyle = "glyphicon glyphicon-arrow-up";
                            v_isUpClass = "btn btn-message";
                        }else{
                            v_isUpContent = "下架";
                            v_isUpStatus = "0";
                            v_isUpStyle = "glyphicon glyphicon-arrow-down";
                            v_isUpClass = "btn btn-danger";
                        }
                        var bbb = data + "," + v_isUpStatus;
                        return '<button type="button" class="btn btn-danger" onclick="deleteProduct('+ data +');"><i class="glyphicon glyphicon-trash"></i>删除</button>'
                                + '<button type="button" class="btn btn-primary" onclick="updateProduct('+ data +');"><i class="glyphicon glyphicon-edit"></i>修改</button>'
                                + '<button type="button" class="'+ v_isUpClass +'" onclick="updateIsUp('+ bbb +');"><i class="'+ v_isUpStyle +'"></i>'+ v_isUpContent +'</button>'
                                + '<button type="button" class="'+ v_class +'" onclick="updateIsHot('+ aaa +');"><i class="'+ v_style +'"></i>'+ v_content +'</button>';
                    },
                    "width":"20%",
                },
            ]
        })
    }

    //修改是否上架
    function updateIsUp(id,isUp) {
        event.stopPropagation();
        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/product/updateIsUp.jhtml?id=" + id + "&isUp=" + isUp,
            success:function (result) {
                if(result.code == 200){
                    productTable.draw(false);
                }
            }
        })
    }

    //修改是否热销
    function updateIsHot(id,isHot) {
        //阻止click事件冒泡到父级元素
        event.stopPropagation();
        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/product/updateIsHot.jhtml?id=" + id + "&isHot=" + isHot,
            success:function (result) {
                if(result.code == 200){
                    productTable.draw(false);
                }
            }
        })
    }

    //获取条件查询的数据并刷新表格
    function search(){
        var v_param = {};
        v_param.productName = $("#productName").val();
        v_param.minPrice = $("#minPrice").val();
        v_param.maxPrice = $("#maxPrice").val();
        v_param.brandId = $("#brandSelect").val();
        v_param.minDate = $("#minDate").val();
        v_param.maxDate = $("#maxDate").val();
        v_param.bigId = $($("select[name=classifySelect]")[0]).val();
        v_param.middleId = $($("select[name=classifySelect]")[1]).val();
        v_param.smallId = $($("select[name=classifySelect]")[2]).val();

        $("#bigId").val($($("select[name=classifySelect]")[0]).val());
        $("#middleId").val($($("select[name=classifySelect]")[1]).val());
        $("#smallId").val($($("select[name=classifySelect]")[2]).val());

        productTable.settings()[0].ajax.data = v_param;
        productTable.ajax.reload();
    }

    //跳转至新增页面
    function toAdd() {

        location.href="<%=request.getContextPath()%>/product/toAdd.jhtml";

    }

    //删除数据
    function deleteProduct(id){
        event.stopPropagation();
        bootbox.confirm({
            size:"small",
            title: "删除商品",
            message: "您确定要删除吗？",
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> 取消'
                },
                confirm: {
                    label: '<i class="fa fa-check"></i> 确定'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/product/deleteProduct.jhtml",
                        type:"post",
                        dataType:"json",
                        data:{
                            "productId":id
                        },
                        success:function(result){
                            if(result.code == 200){
                                alert("删除成功");
                                productTable.draw(false);
                            }
                        }
                    })
                }
            }
        });
    }

    //修改商品
    var updProductDiaLog;
    function updateProduct(id){
        //停止事件传播
        event.stopPropagation();
        $.ajax({
            url: "<%=request.getContextPath()%>/product/queryProductById.jhtml",
            type: "post",
            dataType:"json",
            async:false,
            data:{"productId":id},
            success:function(result){
                if(result.code == 200){
                    product = result.data;
                    $("#updProductName").val(product.productName);
                    $("#updProductPrice").val(product.productPrice);
                    $("#updCreateDate").val(product.createDate);
                    $("#updOldFileName").val(product.fileName);
                    $("#updBrandSelect").val(product.brandId);
                    var fileName = product.fileName;
                    if(fileName != null && fileName != ""){
                        var fileNameArr = fileName.split(",");
                    }

                    $("#updClassifyDiv").html(product.classifyNames + '<button type="button" class="btn btn-success" onclick="classifySelectChange();"><i class="glyphicon glyphicon-pencil"></i> 编辑</button>');

                    initAddAndUpdFileInput("#updImage","#updNewFileName",fileNameArr);
                    updProductDiaLog = bootbox.confirm({
                        title:"修改商品",
                        size:"large",
                        message:$("#updProductDiv form"),
                        buttons:{
                            confirm:{
                                label:"确认"
                            },
                            cancel:{
                                label:"取消",
                                className:"btn btn-danger"
                            }
                        },
                        callback:function(result){
                            if(result){
                                var v_param = {};
                                v_param.productName = $("#updProductName").val();
                                v_param.productPrice = $("#updProductPrice").val();
                                v_param.brandId = $("#updBrandSelect").val();
                                v_param.createDate = $("#updCreateDate").val();
                                v_param.fileName = $("#updOldFileName").val();
                                v_param.newFileName = $("#updNewFileName").val();
                                v_param.productId = id;
                                if(v_status == 1){
                                    v_param.bigId = product.bigId;
                                    v_param.middleId = product.middleId;
                                    v_param.smallId = product.smallId;
                                }else{
                                    v_param.bigId = $($("select[name=updClassifySelect]")[0]).val();
                                    v_param.middleId = $($("select[name=updClassifySelect]")[1]).val();
                                    v_param.smallId = $($("select[name=updClassifySelect]")[2]).val();
                                }



                                $.ajax({
                                    url:"<%=request.getContextPath()%>/product/updProduct.jhtml",
                                    type:"post",
                                    dataType:"json",
                                    data:v_param,
                                    async:false,
                                    success:function(result){
                                        if(result.code==200){
                                            alert("修改成功");
                                            productTable.draw(false);
                                        }
                                    }
                                })
                            }
                            $("#updProductDiv").html(updProductDivHTML);
                            initBrandSelect("updBrandSelect","#updBrandSelectDiv");
                            initCreateDate("#updCreateDate");
                        }
                    });
                }
            }
        })
    }
</script>
</html>
