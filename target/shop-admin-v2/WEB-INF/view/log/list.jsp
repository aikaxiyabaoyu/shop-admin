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
                <div class="panel-heading">日志查询</div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户名称</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="userName" placeholder="请输入用户名称">
                            </div>
                            <label class="col-sm-2 control-label">真实姓名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名">
                            </div>
                        </div>
                        <div class="form-group" id="areaDiv">
                            <label class="col-sm-2 control-label">日期区间</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="minDate"/>
                                    <span class="input-group-addon">-</span>
                                    <input type="text" class="form-control" id="maxDate"/>
                                </div>
                            </div>
                            <label class="col-sm-2 control-label">日志信息</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="info" placeholder="请输入日志信息">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">请求状态</label>
                            <div class="col-sm-4" id="radioDiv">
                                <label class="radio-inline">
                                    <input name="status" value="1" type="radio"/>成功
                                </label>
                                <label class="radio-inline">
                                    <input name="status" value="2" type="radio"/>失败
                                </label>
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
                <div class="panel-heading">日志列表</div>
                <table id="logTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>日志ID</th>
                        <th>用户名称</th>
                        <th>真实姓名</th>
                        <th>信息</th>
                        <th>添加时间</th>
                        <th>状态</th>
                        <th>内容</th>
                        <th>参数</th>
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
        initLogTable();
        initCreateDate();
    });

    //初始化日期插件
    function initCreateDate() {
        $("#minDate,#maxDate").datetimepicker({
            format:"YYYY-MM-DD HH:mm:ss",
            locale:"zh-CN",
            showClear:true
        });
    }

    //重新加载表格
    function search(){
        var v_param = {};

        v_param.userName = $("#userName").val();
        v_param.realName = $("#realName").val();
        v_param.minDate = $("#minDate").val();
        v_param.maxDate = $("#maxDate").val();
        v_param.info = $("#info").val();
        v_param.status = $("input[name=status]:checked").val();

        logTable.settings()[0].ajax.data = v_param;
        logTable.ajax.reload();
    }

    //初始化dataTables表格
    var logTable;
    function initLogTable(){

        logTable = $("#logTable").DataTable({
            language:{
                "url":"<%=request.getContextPath()%>/js/DataTables/Chinese.json"
            },
            "searching": false,
            "processing": true,
            "lengthMenu": [2,5,10,20],
            "serverSide": true,
            ajax:{
                "url":"/log/queryLogList.jhtml",
                "type":"post"
            },
            "columns":[
                {"data":"logId"},
                {"data":"userName"},
                {"data":"realName"},
                {"data":"info"},
                {"data":"insertTime"},
                {"data":"status",
                    "render":function (data) {
                        return data==1?"成功":"失败";
                    }
                },
                {"data":"content"},
                {"data":"paramInfo"},
            ]
        })
    }
</script>
</html>
