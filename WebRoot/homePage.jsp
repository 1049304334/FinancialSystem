<%@ page import="com.swx.po.User" %>
<%@ page import="com.swx.po.Family" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String path = request.getContextPath();%>
<% User user = (User)session.getAttribute("user");%>
<% Family family = (Family)session.getAttribute("family");%>
<html>
<head>
    <title>欢迎页</title>
</head>
<body>
    <div>
        <div class="page-header welcome-home">
            <h1>&nbsp;&nbsp;欢迎，${userMap['true_name']}&nbsp;&nbsp;&nbsp;&nbsp;
                <small><c:out value="${familyMap['family_name']}"></c:out>
                    <c:if test="${userMap['id'] == familyMap['admin_id']}">
                        的管理员
                    </c:if>
                    <c:if test="${userMap['id'] != familyMap['admin_id']}">
                        的成员
                    </c:if>
                </small>
            </h1>
        </div>
        <table class="base-table recent-info">
            <tr style="height: 28px"></tr>
            <tr>
                <td>近一个月收入：</td>
                <td><small><span class="income-txt">10000.00</span></small></td>
                <td rowspan="3"><button class="layui-btn"><i class="layui-icon icon-display">&#xe602;</i>查看详情</button></td>
            </tr>
            <tr style="height: 28px"></tr>
            <tr>
                <td>支出：</td>
                <td><small><span class="outcome-txt">9999.00</span></small></td>
                <td></td>
            </tr>
            <tr style="height: 48px">
                <td colspan="3">
                    <hr/>
                </td>
            </tr>
            <tr>
                <td>待办事项：</td>
                <td><small>2个待办事项</small></td>
                <td><button class="layui-btn"><i class="layui-icon icon-display">&#xe63c;</i>查看备忘</button></td>
            </tr>
            <tr style="height: 48px">
                <td colspan="3">
                    <hr/>
                </td>
            </tr>
            <tr>
                <td>债权债务：</td>
                <td><small>共2笔</small></td>
                <td><button class="layui-btn"><i class="layui-icon icon-display">&#xe602;</i>查看详情</button></td>
            </tr>
            <tr style="height: 96px"></tr>
        </table>
        <hr/>

    </div>
</body>
</html>
