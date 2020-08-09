<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2019/12/16
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <jsp:include page="../common/nav.jsp"/>
    <%--分类列表div--%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            分类列表
            <button class="btn btn-success btn-sm" onclick="addClassify()">
                <span class="glyphicon glyphicon-plus"></span> 新增
            </button>
            <button class="btn btn-warning btn-sm" onclick="updateClassify()">
                <span class="glyphicon glyphicon-pencil"></span> 修改
            </button>
            <button class="btn btn-danger btn-sm" onclick="deleteClassify()">
                <span class="glyphicon glyphicon-trash"></span> 删除
            </button>
        </div>
        <ul id="classifyZtree" class="ztree"></ul>
    </div>

    <%--新增分类div--%>
    <div style="display: none" id="addClassifyDiv">
        <form class="form-horizontal" id="addClassifyForm">
            <div class="form-group">
                <label class="col-sm-2 control-label">上级名称:</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="parentName" readonly />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">分类名称:</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="name" />
                </div>
            </div>
        </form>
    </div>

    <%--修改分类div--%>
    <div style="display: none" id="updateClassifyDiv">
        <form class="form-horizontal" id="updateClassifyForm">
            <div class="form-group">
                <label class="col-sm-2 control-label">上级名称:</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="update_parentName" readonly />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">分类名称:</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="update_name" />
                </div>
            </div>
        </form>
    </div>
</body>
<script>

    var zTreeObj;

    var addClassifyDivHTML;
    var updClassifyDivHTML;

    //ztree的配置信息
    var settings ={
        data:{
            simpleData:{
                enable:true,
                pIdKey:"pid"
            }
        }
    };

    $(function(){
        initClassifyZtree();
        addClassifyDivHTML = $("#addClassifyDiv").html();
        updClassifyDivHTML = $("#updateClassifyDiv").html();
    })

    //初始化ztree
    function initClassifyZtree() {
        $.ajax({
            url:"<%=request.getContextPath()%>/classify/queryList.jhtml",
            type:"post",
            success:function (result) {
                if(result.code == 200){
                    zTreeObj = $.fn.zTree.init($("#classifyZtree"),settings,result.data);
                }
            }
        })
    }

    //新增分类
    function addClassify(){
        //获取ztree上所有被选中的节点
        var selectedNodes = zTreeObj.getSelectedNodes();
        //获取当前选中的节点
        if(selectedNodes.length == 1){
            var selectNode = selectedNodes[0];

            $("#addClassifyDiv #parentName").val(selectNode.name);

            //弹出新增分类对话框
            bootbox.confirm({
                title:"新增分类",
                message:$("#addClassifyDiv form"),
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
                        v_param.name = $("#addClassifyForm #name").val();
                        v_param.pid = selectNode.id;

                        $.ajax({
                            url: "<%=request.getContextPath()%>/classify/addClassify.jhtml",
                            type:"post",
                            data:v_param,
                            success:function (result) {
                                if(result.code == 200){
                                    var classify = result.data;

                                    //新建一个节点
                                    var Node = {"id":classify.id,"name":classify.name,"pid":classify.pid};

                                    //新增树节点
                                    zTreeObj.addNodes(selectNode,0,Node);
                                }
                            }
                        })
                    }

                    $("#addClassifyDiv").html(addClassifyDivHTML);
                }
            })
        }else if(selectedNodes.length == 0){
            alert("请先选择父级节点！");
        }else{
            alert("至多选择一个父级节点！");
        }
    }

    //删除分类
    function deleteClassify() {
        bootbox.confirm({
            title:"删除分类",
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
                    var selectedNodes = zTreeObj.getSelectedNodes();
                    if(selectedNodes.length == 0){
                        alert("请选择你要删除的节点！");
                    }else{

                        //获取选中的节点的所有子节点以及选中的节点
                        var transformToArray = zTreeObj.transformToArray(selectedNodes);

                        var ids = [];
                        for(var i = 0; i < transformToArray.length; i++) {
                            ids.push(transformToArray[i].id);
                        }

                        //发送一个删除分类的ajax请求
                        $.ajax({
                            url:"<%=request.getContextPath()%>/classify/deleteClassify.jhtml",
                            data:{"ids":ids},
                            type:"post",
                            success:function (result) {
                                for(var i = 0; i<selectedNodes.length; i++){
                                    zTreeObj.removeNode(selectedNodes[i]);
                                }
                                alert("删除成功");
                            }
                        })
                    }
                }
            }
        });
    }

    //修改分类
    function updateClassify(){
        //获取ztree上所有被选中的节点
        var selectedNodes = zTreeObj.getSelectedNodes();
        //获取当前选中的节点
        if(selectedNodes.length == 1){
            var selectNode = selectedNodes[0];
            if(selectNode.pid == null || selectNode.pid == 0){
                alert("该节点为根节点，不可修改！");
            }else{
                var parentNode = selectNode.getParentNode();
                $("#updateClassifyDiv #update_parentName").val(parentNode.name);
                $("#updateClassifyDiv #update_name").val(selectNode.name);
                //弹出修改分类对话框
                bootbox.confirm({
                    title:"修改分类",
                    message:$("#updateClassifyDiv form"),
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
                            v_param.id = selectNode.id;
                            v_param.name = $("#updateClassifyForm #update_name").val();

                            $.ajax({
                                url: "<%=request.getContextPath()%>/classify/updateClassify.jhtml",
                                type:"post",
                                data:v_param,
                                success:function (result) {
                                    if(result.code == 200){
                                        selectNode.name = result.data;

                                        //修改树节点
                                        zTreeObj.updateNode(selectNode);
                                    }
                                }
                            })
                        }

                        $("#updateClassifyDiv").html(updClassifyDivHTML);
                    }
                })
            }
        }else if(selectedNodes.length == 0){
            alert("请先选择父级节点！");
        }else{
            alert("至多选择一个父级节点！");
        }
    }
</script>
</html>
