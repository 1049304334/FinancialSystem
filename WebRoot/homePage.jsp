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
                <td><small><span class="income-txt" id="recentIncome">获取中</span></small></td>
                <td rowspan="3"><button class="layui-btn" onclick="showIncomes()"><i class="layui-icon icon-display">&#xe602;</i>查看详情</button></td>
            </tr>
            <tr style="height: 28px"></tr>
            <tr>
                <td>支出：</td>
                <td><small><span class="outcome-txt" id="recentExpand">获取中</span></small></td>
                <td></td>
            </tr>
            <tr style="height: 48px">
                <td colspan="3">
                    <hr/>
                </td>
            </tr>
            <tr>
                <td>待办事项：</td>
                <td><small id="recentNotes">获取中</small></td>
                <td><button class="layui-btn" onclick="showNotes()"><i class="layui-icon icon-display">&#xe63c;</i>查看备忘</button></td>
            </tr>
            <tr style="height: 48px">
                <td colspan="3">
                    <hr/>
                </td>
            </tr>
            <tr>
                <td>债权债务：</td>
                <td><small id="recentDebts">获取中</small></td>
                <td><button class="layui-btn" onclick="showDebts()"><i class="layui-icon icon-display">&#xe602;</i>查看详情</button></td>
            </tr>
            <tr style="height: 96px"></tr>
        </table>
        <hr/>

    </div>
<script>

    $(function(){
        $.ajax({
            type:'post',
            url:'<%=path%>/loginServlet?method=getHomePageInfo',
            async:true,
            success:function(msg){
                var data = JSON.parse(msg);
                setValueToPage(data);
            },
            error:function(){
                layer.msg("获取首页信息失败");
            }
        })
    })

    function setValueToPage(data){
        if(data.recentIncome.totalIncome!=undefined){
            $("#recentIncome")[0].innerText = data.recentIncome.totalIncome;
        }else{
            $("#recentIncome")[0].innerText = "无数据"
        }
        if(data.recentExpand.totalExpand!=undefined){
            $("#recentExpand")[0].innerText = data.recentExpand.totalExpand;
        }else{
            $("#recentExpand")[0].innerText = "无数据"
        }
        $("#recentNotes")[0].innerText = data.recentNoteNum.num+"个待办事项";
        $("#recentDebts")[0].innerText = "共"+(parseInt(data.recentCreditNum.num)+parseInt(data.recentDebtNum.num))+"笔";
    }

    function showIncomes(){
        $(".layui-nav-item:eq(1)").addClass("layui-nav-itemed");
        $(".layui-nav-item:eq(1)>dl>dd:eq(1)").addClass("layui-this");
        $("#mainDiv").load("<%=path%>/pages/inoutcome/statistics.jsp");
    }

    function showDebts(){
        $(".layui-nav-item:eq(3)").addClass("layui-nav-itemed");
        $(".layui-nav-item:eq(3)>dl>dd:eq(2)").addClass("layui-this");
        $("#mainDiv").load("<%=path%>/pages/debt/statistics.jsp");
    }

    function showNotes(){
        $(".layui-nav-item:eq(4)").addClass("layui-nav-itemed");
        $(".layui-nav-item:eq(4)>dl>dd:eq(1)").addClass("layui-this");
        $("#mainDiv").load("<%=path%>/pages/note/notes.jsp");
    }
</script>
</body>
</html>
