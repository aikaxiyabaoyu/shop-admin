<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2020/1/14
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="../common/nav.jsp"/>
    <button type="button" class="btn btn-primary" onclick="addStandardTable()">增加规格</button>
    <button type="button" class="btn btn-primary" onclick="addStandard()">提交</button>
    <table id="standardTable" class="table table-striped table-bordered">
        <tr>
            <td>规格名：</td>
            <td><input name="standardName" type="text" class="form-control"/></td>
            <td>规格排序：</td>
            <td><input name="standardSort" type="text" class="form-control"/></td>
            <td>
                <button type="button" class="btn btn-danger" onclick="deleteStandardTable(this)">删除规格</button>
                <button type="button" class="btn btn-primary" onclick="addStandardRow(this)">增加规格值</button>
            </td>
        </tr>
    </table>

    <div id="standardTableDiv" style="display: none">
        <table class="table table-striped table-bordered">
            <tr>
                <td>规格名：</td>
                <td><input name="standardName" type="text" class="form-control"/></td>
                <td>规格排序：</td>
                <td><input name="standardSort" type="text" class="form-control"/></td>
                <td>
                    <button type="button" class="btn btn-danger" onclick="deleteStandardTable(this)">删除规格</button>
                    <button type="button" class="btn btn-primary" onclick="addStandardRow(this)">增加规格值</button>
                </td>
            </tr>
        </table>
    </div>
    <textarea id="standardRowDiv" style="display: none">
        <tr>
            <td>规格值：</td>
            <td><input name="standardValue"  type="text" class="form-control"/></td>
            <td>规格值排序：</td>
            <td><input name="standardValueSort" type="text" class="form-control"/></td>
            <td>
                <button type="button" class="btn btn-danger" onclick="deleteStandardRow(this)">删除规格值</button>
            </td>
        </tr>
    </textarea>
</body>
<script>
    function addStandardTable() {
        $("body>table").last().after($("#standardTableDiv").html());
    }

    function addStandardRow(obj) {
        $(obj).parents("tbody").append($("#standardRowDiv").val());
    }

    function deleteStandardTable(obj) {
        $(obj).parents("table").remove();
    }

    function deleteStandardRow(obj) {
        $(obj).parents("tr").remove();
    }
    
    function addStandard() {
        var standardNameStr = "";
        var standardSortStr = "";
        var standardValueStr = "";
        $("body>table").find("input[name=standardName]").each(function () {
            standardNameStr += "," + this.value;
        })

        $("body>table").find("input[name=standardSort]").each(function () {
            standardSortStr += "," + this.value;
        })

        if(standardNameStr.length > 0){
            standardNameStr = standardNameStr.substring(1);
        }
        if(standardSortStr.length > 0){
            standardSortStr = standardSortStr.substring(1);
        }

        //将规格值拼成  红色=1,蓝色=2;32G=1,64G=2 这种格式
        //先循环表格
        $("body>table").each(function () {
            var standardValueArr = [];
            var standardValueSortArr = [];
            var standardValue = "";
            //将当前表格中的规格值放入数组中
            $(this).find("input[name=standardValue]").each(function () {
                standardValueArr.push(this.value);
            })
            //将当前表格中的规格值排序放入数组中
            $(this).find("input[name=standardValueSort]").each(function () {
                standardValueSortArr.push(this.value);
            })
            //循环遍历规格值数组
            for (let i = 0; i < standardValueArr.length; i++) {
                standardValue += "," + standardValueArr[i] + "=" + standardValueSortArr[i];
            }

            //截取第一个逗号并将值赋给全局变量
            standardValue = standardValue.substring(1);
            standardValueStr += standardValue + ";";
        })

        console.log(standardNameStr);
        console.log(standardSortStr);
        console.log(standardValueStr);
        $.ajax({
            type:"post",
            url:"/standard/addStandard.jhtml",
            data:{
                "standardNameStr":standardNameStr,
                "standardSortStr":standardSortStr,
                "standardValueStr":standardValueStr,
            },
            success:function (result) {

            }
        })
    }
</script>
</html>
