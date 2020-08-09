<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2020/1/15
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="../common/nav.jsp"/>
<form class="form-horizontal" role="form">
    <div class="form-group">
        <div class="row">
            <button type="button" onclick="addType()" class="btn btn-primary">提交</button>
            <label class="col-md-3 control-label">类型名</label>
            <div class="col-md-3">
                <input id="typeName" type="text" class="form-control"/>
            </div>
        </div>
    </div>
</form>

<div class="row">
    <div class="col-md-6">
        <table id="brandTable" style="width: 100%" class="table table-striped table-bordered">
            <tr>
                <td colspan="5">
                    品牌列表
                </td>
            </tr>
        </table>

    </div>
    <div class="col-md-6">
        <table id="standardTable" style="width: 100%" class="table table-striped table-bordered">
            <tr>
                <td colspan="2">
                    规格列表
                </td>
            </tr>
        </table>

    </div>
</div>

    <textarea style="display: none;" id="brandTableDiv">
        <tr>
            <td name="brandTd"></td>
            <td name="brandTd"></td>
            <td name="brandTd"></td>
            <td name="brandTd"></td>
            <td name="brandTd"></td>
        </tr>
    </textarea>

    <textarea style="display: none;" id="standardTableDiv">
        <tr>
            <td name="standardTd"></td>
            <td name="standardTd"></td>
        </tr>
    </textarea>
</body>
<script>
    $(function () {
        initTables();
    })

    function initTables() {
        $.ajax({
            type:"post",
            url:"/type/initTables.jhtml",
            success:function (result) {
                var brandList = result.data.brandList;
                var standardList = result.data.standardList;

                if(brandList.length < 5){
                    $("#brandTable tbody").append($("#brandTableDiv").val());
                    for (var i = 0; i < brandList.length; i++) {
                        $("[name=brandTd]").eq(i).html('<input name="brandCheckbox" type="checkbox"/><input name="brandHidden" value="'+ brandList[i].brandId +'" type="hidden"/>');
                        $("[name=brandTd]").eq(i).append(brandList[i].brandName);
                    }
                }else if(brandList.length % 5 == 0){
                    for (var i = 0; i < brandList.length/5; i++) {
                        $("#brandTable tbody").append($("#brandTableDiv").val());
                    }
                    for (var i = 0; i < brandList.length; i++) {
                        $("[name=brandTd]").eq(i).html('<input name="brandCheckbox" type="checkbox"/><input name="brandHidden" value="'+ brandList[i].brandId +'" type="hidden"/>');
                        $("[name=brandTd]").eq(i).append(brandList[i].brandName);
                    }
                }else{
                    for (var i = 0; i < brandList.length % 5+1; i++) {
                        $("#brandTable tbody").append($("#brandTableDiv").val());
                    }
                    for (var i = 0; i < brandList.length; i++) {
                        $("[name=brandTd]").eq(i).html('<input name="brandCheckbox" type="checkbox"/><input name="brandHidden" value="'+ brandList[i].brandId +'" type="hidden"/>');
                        $("[name=brandTd]").eq(i).append(brandList[i].brandName);
                    }
                }

                if(standardList.length % 2 == 0){
                    for (var i = 0; i < standardList.length/2; i++) {
                        $("#standardTable tbody").append($("#standardTableDiv").val());
                    }
                    for (var i = 0; i < standardList.length; i++) {
                        $("[name=standardTd]").eq(i).html('<input name="standardCheckbox" type="checkbox"/><input value="'+ standardList[i].id +'" name="standardHidden" type="hidden"/>');
                        $("[name=standardTd]").eq(i).append(standardList[i].name);
                    }
                }else{
                    for (var i = 0; i < (standardList.length+1)/2; i++) {
                        $("#standardTable tbody").append($("#standardTableDiv").val());
                    }
                    for (var i = 0; i < standardList.length; i++) {
                        $("[name=standardTd]").eq(i).html('<input name="standardCheckbox" type="checkbox"/><input value="'+ standardList[i].id +'" name="standardHidden" type="hidden"/>');
                        $("[name=standardTd]").eq(i).append(standardList[i].name);
                    }
                }
            }
        })
    }

    function addType() {
        var brandIds = "";
        var standardIds = "";
        var typeName = $("#typeName").val();
        $("input[name=brandCheckbox]:checked").each(function () {
            brandIds += "," + $(this).parents("td").find("input[name=brandHidden]:hidden")[0].value;
        })
        $("input[name=standardCheckbox]:checked").each(function () {
            standardIds += "," + $(this).parents("td").find("input[name=standardHidden]:hidden")[0].value;
        })

        $.ajax({
             type:"post",
             data: {
                 "typeName":typeName,
                 "brandIds":brandIds,
                 "standardIds":standardIds
             },
             url: "/type/addType.jhtml",
             success:function (result) {
                 alert("新增成功");
             }
         })
     }
</script>
</html>
