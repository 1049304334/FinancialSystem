<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% HashMap familyMap = (HashMap) request.getSession().getAttribute("familyMap");%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div class="page-header">
        <h1>&nbsp;&nbsp;<small>收支统计</small></h1>
    </div>

    <div class="container main-div">
        <table class="base-table">
            <tr style="text-align: left">
                <td><label>统计周期：</label></td>
                <td colspan="1">
                    <select id="countCycle" class="form-control">
                        <option value="30" selected>30天</option>
                        <option value="90">90天</option>
                        <option value="365">一年</option>
                    </select>
                </td>
                <td colspan="6"></td>
            </tr>
            <tr style="height: 24px;"></tr>
        </table>
        <table class="base-table">
            <tr style="text-align: left">
                <td><label>收支总计:</label></td>
                <td colspan="9">
                    <div class="inout-progress-bar">
                        <div class="income-div"></div>
                        <div class="expand-div"></div>
                    </div>
                </td>
            </tr>
            <tr style="height: 48px;"></tr>
            <tr>
                <td></td>
                <td colspan="3"><label>收入类型统计</label></td>
                <td></td>
                <td colspan="3"><label>支出类型统计</label></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td colspan="3"><div id="incomeChart" class="chart-div"></div></td>
                <td></td>
                <td colspan="3"><div id="expandChart" class="chart-div"></div></td>
                <td></td>
            </tr>
        </table>
    </div>

<script>

    $(function(){
        getStatisticData(30)
    })

    /**
     * 获取统计数据
     * @param cycle 统计周期
     */
    function getStatisticData(cycle){
        var cycle = $("#countCycle").val();
        $.ajax({
            type:'post',
            url:'/incomeExpendServlet?method=getStatisticData&cycle='+cycle,
            async:true,
            success:function(data){
                var msg = JSON.parse(data);
                console.log(msg);
                setProgressBar(msg);
                setIncomeChart(msg);
                setExpandChart(msg);
            },
            error:function(){
                layer.msg("获取统计信息失败！");
            }
        })
    }

    function setProgressBar(data){
        var totalIncome = parseFloat(data.income.totalIncome);
        var totalExpand = parseFloat(data.expand.totalExpand);
        var incomeRate = totalIncome/(totalIncome + totalExpand)*100;
        var expandRate = 100 - incomeRate;
        $(".income-div").width(Math.round(incomeRate)+"%");
        $(".expand-div").width(Math.round(expandRate)+"%");
        $(".income-div")[0].innerHTML="&nbsp;&nbsp;总收入："+totalIncome+"元";
        $(".expand-div")[0].innerHTML="&nbsp;&nbsp;总支出："+totalExpand+"元";
    }

    function setIncomeChart(data){
        var incomeChart = echarts.init(document.getElementById('incomeChart'));
        var incomes = data.countIncomeByType;
        var newArr = [];
        for(var i=0;i<incomes.length;i++){
            var obj = {};
            obj.name = incomes[i].type_name;
            obj.value = incomes[i].total;
            newArr.push(obj)
        }

        incomeChart.setOption({
            series : [
                {
                    name: '收入来源分析',
                    type: 'pie',
                    radius: '55%',
                    data:newArr,
                }
            ]
        })

    }

    function setExpandChart(data){
        var expandChart = echarts.init(document.getElementById('expandChart'));
        var incomes = data.countOutcomeByType;
        var newArr = [];
        for(var i=0;i<incomes.length;i++){
            var obj = {};
            obj.name = incomes[i].type_name;
            obj.value = incomes[i].total;
            newArr.push(obj)
        }

        expandChart.setOption({
            series : [
                {
                    name: '支出分析',
                    type: 'pie',
                    radius: '55%',
                    data:newArr,
                }
            ]
        })

    }
</script>
</body>
</html>
