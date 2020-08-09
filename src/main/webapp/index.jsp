<%@page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
</body>
<%--jquery的js--%>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script>
    $(function () {
        location.href="/product/toList.jhtml";
    })
</script>
</html>
