<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% HashMap familyMap = (HashMap) request.getSession().getAttribute("familyMap");%>
<html>
<head>
    <title></title>
</head>
<body>
<!--债权债务统计页面-->
<!--统计债权总额，负债总额，30天内应还借款和应收账款-->
<div class="page-header">
    <h1>&nbsp;&nbsp;<small>债权债务统计</small></h1>
</div>

<div class="container main-div">
    <table class="base-table">
        <tr>
            <td colspan="2"></td>
            <td><label>债权总额:</label></td>
            <td><label style="color: #FF5722;font-size: 24px" id="totalCredit">650</label></td>
            <td></td>
            <td><label>债务总额:</label></td>
            <td><label style="color: #009688;font-size: 24px" id="totalDebt">623</label></td>
            <td colspan="2"></td>
        </tr>
        <tr style="height: 48px;">
            <td colspan="9"><hr/></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="3"><label>30日内到期债权</label></td>
            <td></td>
            <td colspan="3"><label>30日内到期债务</label></td>
            <td></td>
        </tr>
        <tr style="height:24px"></tr>
        <tr>
            <td></td>
            <td></td>
            <td colspan="2">
                <div style="text-align: left">
                    <ul class="layui-timeline" id="creditTimeLine">

                    </ul>
                </div>
            </td>
            <td></td>
            <td></td>
            <td colspan="2">
                <div style="text-align: left">
                    <ul class="layui-timeline" id="debtTimeLine">

                    </ul>
                </div>
            </td>
            <td></td>
        </tr>
    </table>
</div>

<script>

    $(function(){
        getStatisticData()
    })

    /**
     * 获取统计数据
     * @param cycle 统计周期
     */
    function getStatisticData(){

        $.ajax({
            type:'post',
            url:'<%=path%>/debtServlet?method=getStatisticData&cycle='+30,
            async:true,
            success:function(data){
                var msg = JSON.parse(data);
                showTotal(msg);
                generateTimeline(msg);
            },
            error:function(){
                layer.msg("获取统计信息失败！");
            }
        })
    }

    function showTotal(msg){
        $("#totalCredit")[0].innerText = msg.totalCredit.totalCredit;
        $("#totalDebt")[0].innerText = msg.totalDebt.totalDebt;
    }

    function setCreditTimeline(data){

        for(var i=0;i<data.repayingCredit.length;i++){
            var str1 = "<li class='layui-timeline-item'>";
            var str2 = "<i class='layui-icon layui-timeline-axis'></i>"
            var str3 = "<div class='layui-timeline-content layui-text'>";
            var str4 = "<h3 class='layui-timeline-title'>"+"<b>"+data.repayingCredit[i].repay_date.slice(5,10)+"</b>"+"</h3>";
            var str5 = "<p>"+data.repayingCredit[i].lender_name+"&nbsp;&nbsp;&nbsp;&nbsp;"+"<b style='color: red'>"+data.repayingCredit[i].balance+" 元"+"</b>"+"<br/><i>"+data.repayingCredit[i].remark+"</i></p>";
            var str6 = "</div></li>";

            var timelineHtml = str1+str2+str3+str4+str5+str6;
            $("#creditTimeLine").append(timelineHtml);
        }
    }

    function setDebtTimeline(data){

        for(var i=0;i<data.repayingDebt.length;i++){
            var str1 = "<li class='layui-timeline-item'>";
            var str2 = "<i class='layui-icon layui-timeline-axis'></i>"
            var str3 = "<div class='layui-timeline-content layui-text'>";
            var str4 = "<h3 class='layui-timeline-title'><b>"+data.repayingCredit[i].repay_date.slice(5,10)+"</b>"+"</h3>";
            var str5 = "<p>"+data.repayingDebt[i].borrower_name+"&nbsp;&nbsp;&nbsp;&nbsp;<b style='color: red'>"+data.repayingDebt[i].balance+" 元"+"</b><br/><i>"+data.repayingDebt[i].remark+"</i></p>";
            var str6 = "</div></li>";

            var timelineHtml = str1+str2+str3+str4+str5+str6;
            $("#debtTimeLine").append(timelineHtml);
        }
    }

    function generateTimeline(msg){
        setCreditTimeline(msg);
        setDebtTimeline(msg);
    }
</script>
</body>
</html>
