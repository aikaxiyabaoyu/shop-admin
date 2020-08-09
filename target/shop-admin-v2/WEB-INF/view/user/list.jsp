<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2019/12/22
  Time: 16:20
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
                    <div class="panel-heading">用户查询</div>
                    <div class="panel-body">
                        <form class="form-horizontal" method="post" id="userForm">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">用户名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="userName" id="userName" placeholder="请输入用户名称">
                                </div>
                                <label class="col-sm-2 control-label">真实姓名</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="realName" id="realName" placeholder="请输入真实姓名">
                                </div>
                            </div>
                            <div class="form-group" id="areaDiv">
                                <label class="col-sm-2 control-label">用户地区</label>
                                <input type="hidden" name="shengId" id="shengId"/>
                                <input type="hidden" name="shiId" id="shiId"/>
                                <input type="hidden" name="xianId" id="xianId"/>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">生日区间</label>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" name="minDate" class="form-control" id="minDate"/>
                                        <span class="input-group-addon">-</span>
                                        <input type="text" name="maxDate" class="form-control" id="maxDate"/>
                                    </div>
                                </div>
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-4">
                                    <button type="button" class="btn btn-primary" onclick="search();"><i class="glyphicon glyphicon-search"></i> 查询</button>
                                    <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">用户列表</div>
                    <button style="margin: 10px 0px" type="button" class="btn btn-primary" onclick="showAddUserDiv()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button onclick="deleteBatch()" type="reset" class="btn btn-danger">
                        <span class="glyphicon glyphicon-trash"></span>&nbsp;批量删除
                    </button>
                    <button onclick="exportExcel()" type="reset" class="btn btn-info">
                        <span class="glyphicon glyphicon-download"></span>&nbsp;导出Excel
                    </button>
                    <button onclick="exportPdf()" type="button" class="btn btn-info">
                        <span class="glyphicon glyphicon-download"></span>&nbsp;导出pdf
                    </button>

                    <table id="userTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                        <tr>
                            <th></th>
                            <th>用户名称</th>
                            <th>用户密码</th>
                            <th>真实姓名</th>
                            <th>用户地区</th>
                            <th>用户头像</th>
                            <th>用户性别</th>
                            <th>用户生日</th>
                            <th>用户电话</th>
                            <th>用户邮箱</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--新增用户div--%>
    <div id="addUserDiv" style="display: none">
        <div class="panel panel-primary">
            <div class="panel-heading">新增用户</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户名称</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="addUserName" placeholder="请输入用户名称"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户密码</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="addPassword" placeholder="请输入用户密码"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">真实姓名</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="addRealName" placeholder="请输入真实姓名"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户头像</label>
                        <div class="col-md-10">
                            <input type="text" style="margin-bottom: 10px" class="form-control" id="addFileName"/>
                            <input type="file" multiple class="form-control" name="image" id="image"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户性别</label>
                        <div class="col-md-10">
                            <input class="radio-inline" type="radio" name="addSex" value="1"/>男
                            <input class="radio-inline" type="radio" name="addSex" value="0"/>女
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户生日</label>
                        <div class="col-md-10">
                            <input class="form-control" type="text" id="addBirthday"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户电话</label>
                        <div class="col-md-10">
                            <input class="form-control" type="text" id="addPhoneNumber"/>
                        </div>
                    </div>
                    <div class="form-group" id="addAreaDiv">
                        <label class="col-md-2 control-label">用户地区</label>

                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户邮箱</label>
                        <div class="col-md-10">
                            <input class="form-control" type="email" id="addEmail"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--修改用户div--%>
    <div id="updUserDiv" style="display: none">
        <div class="panel panel-primary">
            <div class="panel-heading">修改用户</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户名称</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="updUserName" placeholder="请输入用户名称"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户密码</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="updPassword" placeholder="请输入用户密码"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">真实姓名</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" id="updRealName" placeholder="请输入真实姓名"/>
                        </div>
                    </div>
                    <div class="form-group">
                    <label class="col-md-2 control-label">用户地区</label>
                    <div class="col-md-10" id="updAreaDiv">
                    </div>
                </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户头像</label>
                        <div class="col-md-10">
                            <input type="text" id="updFileName"/>
                            <input type="text" id="updNewFileName"/>
                            <input type="file" multiple class="form-control" name="image" id="updImage"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户性别</label>
                        <div class="col-md-10">
                            <input class="radio-inline" type="radio" name="updSex" value="1"/>男
                            <input class="radio-inline" type="radio" name="updSex" value="0"/>女
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户生日</label>
                        <div class="col-md-10">
                            <input class="form-control" type="text" id="updBirthday"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户电话</label>
                        <div class="col-md-10">
                            <input class="form-control" type="text" id="updPhoneNumber"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">用户邮箱</label>
                        <div class="col-md-10">
                            <input class="form-control" type="email" id="updEmail"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script>

    var addUserHTML;
    var updUserHTML;
    var v_status = 1;
    var user;

    //导出Excel
    function exportExcel(){
        var productForm = document.getElementById("userForm");
        //设置form表单的提交地址（利用js方式设置表单提交路径必直接写在form标签里灵活性更好）
        productForm.action = "/user/exportExcel.jhtml";
        //通过js代码的方式提交form表单（注意，form标签里的method属性值为post）
        productForm.submit();
    }

    //导出pdf
    function exportPdf() {
        var productForm = document.getElementById("userForm");
        //设置form表单的提交地址（利用js方式设置表单提交路径必直接写在form标签里灵活性更好）
        productForm.action = "/user/exportPdf.jhtml";
        //通过js代码的方式提交form表单（注意，form标签里的method属性值为post）
        productForm.submit();
    }

    //页面加载事件
    $(function(){
        initCreateDate("#minDate");
        initCreateDate("#maxDate");
        initCreateDate("#addBirthday");
        initAreaSelect(1);
        initAddAreaSelect(1);
        initUserTable();
        addUserHTML = $("#addUserDiv").html();
        updUserHTML = $("#updUserDiv").html();
    })

    function initAreaSelect(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }

        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/area/queryAreaListByPid.jhtml",
            "data":{"id":id},
            success:function (result){
                if(result.data != null && result.data.length > 0){
                    var v_areaList = result.data;
                    var v_html = '<div class="col-md-3"><select name="areaSelect" onchange="initAreaSelect(this.value,this)" class="form-control"><option value="-1">===请选择===</option>';
                    for (var i = 0; i < v_areaList.length; i++) {
                        var area = v_areaList[i];
                        v_html += '<option value="'+ area.id +'">'+ area.name +'</option>';
                    }
                    v_html += "</select></div>";

                    $("#areaDiv").append(v_html);
                }
            }
        })
    }

    function initAddAreaSelect(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }

        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/area/queryAreaListByPid.jhtml",
            "data":{"id":id},
            success:function (result){
                if(result.data != null && result.data.length > 0){
                    var v_areaList = result.data;
                    var v_html = '<div class="col-md-3"><select name="addAreaSelect" onchange="initAddAreaSelect(this.value,this)" class="form-control"><option value="-1">===请选择===</option>';
                    for (var i = 0; i < v_areaList.length; i++) {
                        var area = v_areaList[i];
                        v_html += '<option value="'+ area.id +'">'+ area.name +'</option>';
                    }
                    v_html += "</select></div>";

                    $("#addAreaDiv").append(v_html);
                }
            }
        })
    }

    function initUpdAreaSelect(id,obj){

        if(obj){
            $(obj).parent().nextAll().remove();
        }

        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/area/queryAreaListByPid.jhtml",
            "data":{"id":id},
            success:function (result){
                if(result.data != null && result.data.length > 0){
                    var v_areaList = result.data;
                    var v_html = '<div class="col-md-3"><select name="updAreaSelect" onchange="initUpdAreaSelect(this.value,this)" class="form-control"><option value="-1">===请选择===</option>';
                    for (var i = 0; i < v_areaList.length; i++) {
                        var area = v_areaList[i];
                        v_html += '<option value="'+ area.id +'">'+ area.name +'</option>';
                    }
                    v_html += "</select></div>";

                    $("#updAreaDiv").append(v_html);
                }
            }
        })
    }

    function AreaSelectChange(){
        if(v_status == 2){
            $("#updAreaDiv").html("");
            initUpdAreaSelect(1);
            $("#updAreaDiv").html("<button type=\"button\" class=\"btn btn-danger\" onclick=\"AreaSelectChange();\"><i class=\"glyphicon glyphicon-trash\"></i> 取消编辑</button>");
            v_status = 1;
        }else{
            $("#updAreaDiv").html("");
            $("#updAreaDiv").html(user.areaNames + '<button type="button" class="btn btn-success" onclick="AreaSelectChange();"><i class="glyphicon glyphicon-pencil"></i> 编辑</button>');
            v_status = 2;
        }
    }

    //修改用户
    var updUserDialog;
    function showUpdUserDiv(id){
        $.ajax({
            "type":"post",
            "url":"<%=request.getContextPath()%>/user/queryUserById.jhtml?id=" + id,
            success:function (result) {
                if(result.code == 200){
                    user = result.data;
                    var fileName = result.data.fileName;
                    if(fileName != null && fileName != ""){
                        var fileNameArr = fileName.split(",");
                    }
                    initFileInput("#updImage","#updNewFileName",fileNameArr);
                    $("#updUserName").val(user.userName);
                    $("#updPassword").val(user.password);
                    $("#updRealName").val(user.realName);
                    $("[name=updSex][value="+user.sex+"]").prop("checked",true);
                    $("#updBirthday").val(user.birthday);
                    $("#updPhoneNumber").val(user.phoneNumber);
                    $("#updEmail").val(user.userEmail);
                    $("#updFileName").val(user.fileName);

                    if(v_status == 1){
                        v_status = 2;
                        $("#updAreaDiv").html(user.areaNames + '<button type="button" class="btn btn-success" onclick="AreaSelectChange();"><i class="glyphicon glyphicon-pencil"></i> 编辑</button>');
                    }


                    updUserDialog = bootbox.confirm({
                        title:"修改用户",
                        size:"large",
                        message:$("#updUserDiv form"),
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
                                //获取修改用户表单中的数据
                                var v_param = {};
                                v_param.userId = user.userId;
                                v_param.userName = $("#updUserName").val();
                                v_param.password = $("#updPassword").val();
                                v_param.realName = $("#updRealName").val();
                                v_param.sex = $("[name=updSex]:checked").val();
                                v_param.birthday = $("#updBirthday").val();
                                v_param.phoneNumber = $("#updPhoneNumber").val();
                                v_param.userEmail = $("#updEmail").val();
                                v_param.fileName = $("#updFileName").val();
                                v_param.newFileName = $("#updNewFileName").val();
                                v_param.newLoginTime = user.newLoginTime;
                                v_param.oldLoginTimeStr = user.oldLoginTimeStr;

                                if(v_status == 2){
                                    v_param.shengId = user.shengId;
                                    v_param.shiId = user.shiId;
                                    v_param.xianId = user.xianId;
                                }else{
                                    v_param.shengId = $($("select[name=updAreaSelect]")[0]).val();
                                    v_param.shiId = $($("select[name=updAreaSelect]")[1]).val();
                                    v_param.xianId = $($("select[name=updAreaSelect]")[2]).val();
                                }
                                console.log(v_param);
                                //发起修改用户的ajax请求
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/user/updateUser.jhtml",
                                    type:"post",
                                    data:v_param,
                                    dataType:"json",
                                    success:function(result){
                                        if(result.code == 200){
                                            alert("修改成功！");
                                            search();
                                        }
                                    },
                                    error:function(){
                                        alert("修改失败！");
                                    }
                                });
                            }
                            AreaSelectChange();
                            $("#updUserDiv").html(updUserHTML);
                        }
                    });
                }
            }
        })
    }

    //删除用户
    function deleteUser(id) {
        bootbox.confirm({
            title:"删除用户",
            size:"small",
            message:"您确定要删除吗？",
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
                    $.ajax({
                        "type":"post",
                        "url":"<%=request.getContextPath()%>/user/deleteUser.jhtml?id=" + id,
                        success:function(result) {
                            if(result.code == 200){
                                alert("删除成功！");
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

    //新增用户
    var addUserDialog;
    function showAddUserDiv(){
        initFileInput("#image","#addFileName");
        addUserDialog = bootbox.confirm({
            title:"新增用户",
            size:"large",
            message:$("#addUserDiv form"),
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
                    //获取新增用户表单中的数据
                    var v_param = {};
                    v_param.userName = $("#addUserName").val();
                    v_param.password = $("#addPassword").val();
                    v_param.realName = $("#addRealName").val();
                    v_param.sex = $("[name=addSex]:checked").val();
                    v_param.birthday = $("#addBirthday").val();
                    v_param.phoneNumber = $("#addPhoneNumber").val();
                    v_param.userEmail = $("#addEmail").val();
                    v_param.fileName = $("#addFileName").val();
                    v_param.shengId = $($("select[name=areaSelect]")[0]).val();
                    v_param.shiId = $($("select[name=areaSelect]")[0]).val();
                    v_param.xianId = $($("select[name=areaSelect]")[0]).val();



                    //发起新增用户的ajax请求
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/addUser.jhtml",
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
                $("#addUserDiv").html(addUserHTML);
            }
        });
    }

    //初始化日期插件
    function initCreateDate(id) {
        $(id).datetimepicker({
            format:"YYYY-MM-DD",
            locale:"zh-CN",
            showClear:true
        });
    }

    //获取条件查询表单中的值 并刷新表格
    function search() {
        var v_param = {};
        v_param.userName = $("#userName").val();
        v_param.realName = $("#realName").val();
        v_param.minDate = $("#minDate").val();
        v_param.maxDate = $("#maxDate").val();
        v_param.shengId = $($("select[name=areaSelect]")[0]).val();
        v_param.shiId = $($("select[name=areaSelect]")[1]).val();
        v_param.xianId = $($("select[name=areaSelect]")[2]).val();

        //将三个下拉框的值赋给隐藏域
        $("#shengId").val($($("select[name=areaSelect]")[0]).val());
        $("#shiId").val($($("select[name=areaSelect]")[1]).val());
        $("#xianId").val($($("select[name=areaSelect]")[2]).val());

        userTable.settings()[0].ajax.data = v_param;
        userTable.ajax.reload();
    }

    //初始化dataTables表格
    var userTable;
    function initUserTable(){

        userTable = $("#userTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            ajax:{
                "url":"/user/queryUserList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"userId",
                    render:function (data) {
                        return '<input type="checkbox" value="'+ data +'"/>';
                    }
                },
                {"data":"userName"},
                {"data":"password"},
                {"data":"realName"},
                {"data":"areaNames",
                    "width":"20%",
                },
                {"data":"fileName",
                    render:function (data) {
                        if(data != null && data != ""){
                            var v_fileNameArr = data.split(",");
                            var v_image = "";
                            for(var i = 0; i < v_fileNameArr.length; i++){
                                v_image += '<img height="50px" src="'+ v_fileNameArr[i] +'"/>';
                            }
                            return v_image;
                        }else{
                            return "";
                        }
                    }
                },
                {"data":"sex",
                    render:function (data) {
                        return data==0?"女":"男"
                    },
                    "width":"7%",
                },
                {"data":"birthday"},
                {"data":"phoneNumber"},
                {"data":"userEmail"},
                {"data":"userId",
                    render:function (data) {
                        return '<button type="button" class="btn btn-danger" onclick="deleteUser('+ data +');"><i class="glyphicon glyphicon-trash"></i> 删除</button>'
                            + '<button type="button" class="btn btn-primary" onclick="showUpdUserDiv('+ data +');"><i class="glyphicon glyphicon-trash"></i> 修改</button>';
                    }
                },
            ]
        })
    }
</script>
</html>
