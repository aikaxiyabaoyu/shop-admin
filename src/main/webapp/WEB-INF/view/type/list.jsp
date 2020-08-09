<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2020/2/1
  Time: 9:31
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
                <div class="panel-heading">类型列表</div>
                <button style="margin: 10px 0px" type="button" class="btn btn-primary" onclick="toAddType()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                <table id="typeTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>类型id</th>
                        <th>类型名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(function(){
        
        initTypeTable();
        
    })
    
    var typeTable;
    function initTypeTable() {
        typeTable = $("#typeTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            ajax:{
                "url":"/type/queryTypeList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"typeId"},
                {"data":"typeName"},
                {"data":"typeId",
                    render:function (data) {
                        return '<button type="button" class="btn btn-danger" onclick="deleteType('+ data +');"><i class="glyphicon glyphicon-trash"></i> 删除</button>'
                            + '<button type="button" class="btn btn-primary" onclick="showUpdateTypeDiv('+ data +');"><i class="glyphicon glyphicon-trash"></i> 修改</button>';
                    }
                },
            ]
        })
    }

    function toAddType() {

        location.href="/type/toAdd.jhtml";

    }
</script>
</html>
