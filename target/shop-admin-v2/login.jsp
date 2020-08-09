<%--
  Created by IntelliJ IDEA.
  User: 932531710qq.com
  Date: 2019/12/24
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="<%=request.getContextPath()%>/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">用户登录</div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2"></label>
                            <label class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="userName" placeholder="请输入用户名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2"></label>
                            <label class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-4">
                                <input type="password" class="form-control" id="password" placeholder="请输入密码">
                            </div>
                        </div>
                        <div class="form-group" style="text-align: center">
                            <button type="button" class="btn btn-primary" onclick="login();"><i class="glyphicon glyphicon-ok"></i> 登录</button>
                            <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
    <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap3/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap3/js/bootbox.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap3/js/bootbox.locales.js"></script>
    <script>
        function login() {
            var userName = $("#userName").val();
            var password = $("#password").val();
            if(userName == null || userName == ""){
                alert("用户名不能为空！");
            }else if(password == null || password == ""){
                alert("密码不能为空！");
            }else{
                $.ajax({
                    type:"post",
                    data:{"userName":userName,
                          "password":password
                    },
                    url:"<%=request.getContextPath()%>/user/login.jhtml",
                    success:function (result) {
                        if(result.code == 200){
                            location.href = "/index.jsp";
                        }else{
                            alert(result.message);
                        }
                    }
                })
            }
        }
    </script>
</html>
