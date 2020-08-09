<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">电商管理系统</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li><a href="/product/toList.jhtml">商品管理</a></li>
                <li><a href="/user/toList.jhtml">用户管理</a></li>
                <li><a href="/area/toList.jhtml">地区管理</a></li>
                <li><a href="/brand/toList.jhtml">品牌管理</a></li>
                <li><a href="/classify/toList.jhtml">分类管理</a></li>
                <li><a href="/log/toList.jhtml">日志管理</a></li>
                <li><a href="/standard/toList.jhtml">规格管理</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎:${user.realName}
                    <c:if test="${!empty user.loginTime}">
                        ，用户上次登录时间:<fmt:formatDate value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </c:if>
                    ，用户今天是第${user.loginCount}次登陆
                </a></li>
                <li><a href="/user/logout.jhtml">注销</a></li>
            </ul>
        </div>
    </div>
</nav>

<%--bootstrap的css--%>
<link href="<%=request.getContextPath()%>/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet"/>
<%--dataTables的css--%>
<link href="<%=request.getContextPath()%>/js/DataTables/DateTables-1.10.20/css/dataTables.bootstrap.min.css" rel="stylesheet"/>
<%--fileInput的css--%>
<link href="<%=request.getContextPath()%>/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>
<%--datetimepicker的css--%>
<link href="<%=request.getContextPath()%>/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet"/>
<%--ztree的css--%>
<link href="<%=request.getContextPath()%>/js/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet"/>

<%--jquery的js--%>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<%--bootstrap的js--%>
<script src="<%=request.getContextPath()%>/js/bootstrap3/js/bootstrap.min.js"></script>
<%--dataTables的js--%>
<script src="<%=request.getContextPath()%>/js/DataTables/datatables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/DataTables/DateTables-1.10.20/js/dataTables.bootstrap.min.js"></script>
<%--bootbox的js--%>
<script src="<%=request.getContextPath()%>/js/bootstrap3/js/bootbox.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap3/js/bootbox.locales.js"></script>
<%--fileInput的js--%>
<script src="<%=request.getContextPath()%>/js/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-fileinput/js/locales/zh.js"></script>
<%--datetimepicker的js--%>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<%--ztree的js--%>
<script src="<%=request.getContextPath()%>/js/zTree/js/jquery.ztree.all.min.js"></script>
<%--日期转换的js--%>
<script src="<%=request.getContextPath()%>/js/date-format.js"></script>