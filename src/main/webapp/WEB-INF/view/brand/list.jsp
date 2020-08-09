<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2019/12/15
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <jsp:include page="../common/nav.jsp"/>
    <%--展示列表的div--%>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">品牌列表</div>
                    <button style="margin: 10px 0px" type="button" class="btn btn-primary" onclick="showAddBrandDiv()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <table id="brandTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                        <tr>
                            <th>品牌id</th>
                            <th>品牌名称</th>
                            <th>品牌图片</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--添加品牌的div--%>
    <div id="addBrandDiv" style="display: none">
        <form class="form-horizontal">
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">品牌名称</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="addBrandName" placeholder="请输入商品名称"/>
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-2 control-label">品牌图片</label>
                    <div class="col-md-8">
                        <input type="text" id="add_fileName">
                        <input type="file" multiple id="add_image" name="image"/>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <%--修改品牌的div--%>
    <div id="updateBrandDiv" style="display: none">
        <form class="form-horizontal">
            <div class="form-group">
                <div class="row">
                    <label class="col-md-2 control-label">品牌名称</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="updateBrandName" placeholder="请输入商品名称"/>
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-2 control-label">品牌图片</label>
                    <div class="col-md-8">
                        <input type="text" id="upd_oldFileName">
                        <input type="text" id="upd_newFileName">
                        <input type="file" multiple id="upd_image" name="image"/>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
<script>

    var updateBrandDivHTML;
    var addBrandDivHTML;

    //页面加载事件
    $(function(){
        updateBrandDivHTML = $("#updateBrandDiv").html();
        addBrandDivHTML = $("#addBrandDiv").html();
        initBrandTable();

    });

    //重新加载表格
    function search(){
        brandTable.ajax.reload();
    }

    //修改品牌
    var updateBrandDialog;
    function showUpdateBrandDiv(id){
        $.ajax({
            type:"post",
            url:"<%=request.getContextPath()%>/brand/queryBrandById.jhtml",
            data:{"brandId":id},
            dataType:"json",
            success:function (result) {
                if(result.code == 200){
                    var fileName = result.data.fileName;
                    if(fileName != null && fileName != ""){
                        var fileNameArr = fileName.split(",");
                    }
                    initFileInput("#upd_image","#upd_newFileName",fileNameArr);
                    $("#updateBrandName").val(result.data.brandName);
                    $("#upd_oldFileName").val(result.data.fileName);

                    updateBrandDialog = bootbox.confirm({
                        title:"修改品牌",
                        size:"large",
                        message:$("#updateBrandDiv form"),
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
                                //获取修改品牌表单中的数据
                                var v_param = {};
                                v_param.brandId = id;
                                v_param.brandName = $("#updateBrandName",updateBrandDialog).val();
                                v_param.fileName = $("#upd_oldFileName",updateBrandDialog).val();
                                v_param.newFileName = $("#upd_newFileName",updateBrandDialog).val();

                                //发起修改品牌的ajax请求
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/brand/updateBrand.jhtml",
                                    type:"post",
                                    data:v_param,
                                    dataType:"json",
                                    success:function(result){
                                        if(result.code == 200){
                                            alert("修改成功");
                                            search();
                                        }
                                    },
                                    error:function(){
                                        alert("修改失败!");
                                    }
                                });
                            }
                            $("#updateBrandDiv").html(updateBrandDivHTML);
                        }
                    });
                }
            }
        });
    }

    //删除品牌
    function deleteBrand(id){
        bootbox.confirm({
            size:"small",
            title: "删除品牌",
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
                        url:"<%=request.getContextPath()%>/brand/deleteBrand.jhtml",
                        type:"post",
                        dataType:"json",
                        data:{
                            "brandId":id
                        },
                        success:function(result){
                            if(result.code == 200){
                                alert("删除成功");
                                search();
                            }
                        }
                    })
                }
            }
        });
    }

    //初始化文件上传插件
    function initFileInput(fileId,hiddenId,imageArr){
        $(fileId).fileinput({
            language:"zh",
            previewFileType:"text",//设置需要预览的文件类型
            uploadClass:"btn btn-danger",
            allowedFileTypes:["image","text"],
            allowedFileExtensions:["jpg","gif","txt","pdf"],
            maxFileSize:1024*20,
            maxFileCount:5,
            initialPreview:imageArr,
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

    //新增品牌
    var addBrandDialog;
    function showAddBrandDiv(){
        initFileInput("#add_image","#add_fileName");

        addBrandDialog = bootbox.confirm({
            title:"新增品牌",
            size:"large",
            message:$("#addBrandDiv form"),
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
                    //获取新增品牌表单中的数据
                    var v_param = {};
                    v_param.brandName = $("#addBrandName",addBrandDialog).val();
                    v_param.fileName = $("#add_fileName",addBrandDialog).val();

                    //发起新增品牌的ajax请求
                    $.ajax({
                        url:"<%=request.getContextPath()%>/brand/addBrand.jhtml",
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
                $("#addBrandDiv").html(addBrandDivHTML);
            }
        });
    }

    //初始化dataTables表格
    var brandTable;
    function initBrandTable(){
        brandTable = $("#brandTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            ajax:{
                "url":"/brand/queryBrandList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"brandId"},
                {"data":"brandName"},
                {"data":"fileName",
                    render:function (data) {
                        if(data != null && data.length > 0){
                            var imageArr = data.split(",");
                            var image = "";
                            for(var i = 0; i < imageArr.length; i++){
                                image += '<img height="50px" src="<%=request.getContextPath()%>'+ imageArr[i] +'"/>';
                            }
                            return image;
                        }else{
                            return "";
                        }
                    }
                },
                {"data":"brandId",
                    render:function (data) {
                        return '<button type="button" class="btn btn-danger" onclick="deleteBrand('+ data +');"><i class="glyphicon glyphicon-trash"></i> 删除</button>'
                            + '<button type="button" class="btn btn-primary" onclick="showUpdateBrandDiv('+ data +');"><i class="glyphicon glyphicon-trash"></i> 修改</button>';
                    }
                },
            ]
        })
    }
</script>
</html>
