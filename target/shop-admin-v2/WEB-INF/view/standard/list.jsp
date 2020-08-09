<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2020/1/15
  Time: 14:10
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
                    <div class="panel-heading">规格列表</div>
                    <button style="margin: 10px 0px" type="button" class="btn btn-primary" onclick="location.href='/standard/toAdd.jhtml'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <table id="standardTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                        <tr>
                            <th>id</th>
                            <th>规格名称</th>
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
    //页面加载事件
    $(function(){

        initStandardTable();

    });

    //重新加载表格
    function search(){
        standardTable.ajax.reload();
    }

    //初始化dataTables表格
    var standardTable;
    function initStandardTable(){

        standardTable = $("#standardTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            ajax:{
                "url":"/standard/queryStandardList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"id"},
                {"data":"name"},
                {"data":"id",
                    render:function (data) {
                        return '<button type="button" class="btn btn-danger" onclick="deleteStandard('+ data +');"><i class="glyphicon glyphicon-pencil"></i> 删除</button>' +
                            '<button type="button" class="btn btn-primary" onclick="toEdit('+ data +');"><i class="glyphicon glyphicon-pencil"></i> 修改</button>';
                    }
                },
            ]
        })
    }
    
    function deleteStandard(id) {
        bootbox.confirm({
            title:"删除规格",
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
                        "url":"<%=request.getContextPath()%>/standard/deleteStandard.jhtml?id=" + id,
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
    
    function toEdit(id) {
        
    }
</script>
</html>
