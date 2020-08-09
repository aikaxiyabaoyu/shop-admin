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
                <div class="panel-heading">会员查询</div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">会员名称</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="memberName" placeholder="请输入会员名称">
                            </div>
                            <label class="col-sm-2 control-label">真实姓名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">日期区间</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="minDate"/>
                                    <span class="input-group-addon">-</span>
                                    <input type="text" class="form-control" id="maxDate"/>
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
                <div class="panel-heading">会员列表</div>
                <table id="memberTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>会员名称</th>
                        <th>会员密码</th>
                        <th>真实姓名</th>
                        <th>会员生日</th>
                        <th>电子邮箱</th>
                        <th>手机号</th>
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
        initMemberTable();
        initCreateDate();
    });

    //初始化日期插件
    function initCreateDate() {
        $("#minDate,#maxDate").datetimepicker({
            format:"YYYY-MM-DD",
            locale:"zh-CN",
            showClear:true
        });
    }

    //重新加载表格
    function search(){
        var v_param = {};

        v_param.name = $("#memberName").val();
        v_param.realName = $("#realName").val();
        v_param.minDate = $("#minDate").val();
        v_param.maxDate = $("#maxDate").val();

        memberTable.settings()[0].ajax.data = v_param;
        memberTable.ajax.reload();
    }

    //初始化dataTables表格
    var memberTable;
    function initMemberTable(){

        memberTable = $("#memberTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            ajax:{
                "url":"/member/queryMemberList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"id"},
                {"data":"memberName"},
                {"data":"password"},
                {"data":"realName"},
                {"data":"birthday"},
                {"data":"mail"},
                {"data":"phone"},
            ]
        })
    }
</script>
</html>
