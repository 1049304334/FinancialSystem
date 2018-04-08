<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% HashMap familyMap = (HashMap) request.getSession().getAttribute("familyMap");%>
<html>
<head>
    <title></title>
</head>
<body>
<!--储蓄统计页面-->
<!--统计存款总额、取款总额、统计周期变化额（以各张卡分组）-->
    <div class="page-header">
        <h1>&nbsp;&nbsp;<small>储蓄统计</small></h1>
    </div>

    <div class="container main-div">
        <table class="base-table">
            <tr style="text-align: left">
                <td><label>统计周期：</label></td>
                <td colspan="1">
                    <select id="countCycle" class="form-control">
                        <option value="30" selected>30天内</option>
                        <option value="90">90天内</option>
                        <option value="365">一年内</option>
                    </select>
                </td>
                <td colspan="6"></td>
            </tr>
            <tr style="height: 24px;"></tr>
        </table>
        <table class="base-table">
            <tr style="text-align: left">
                <td><label>存取总计:</label></td>
                <td colspan="8"></td>
            </tr>
            <tr style="height: 48px;"></tr>
            <tr>
                <td></td>
                <td colspan="3"><label>存款统计</label></td>
                <td></td>
                <td colspan="3"><label>取款统计</label></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td colspan="3"><div id="depositChart" class="chart-div"></div></td>
                <td></td>
                <td colspan="3"><div id="withdrawChart" class="chart-div"></div></td>
                <td></td>
            </tr>
        </table>
    </div>

<script>

    //当统计周期变化时，会调用此函数
    $("#countCycle").change(function(){
        var cycle = parseInt($("#countCycle").val());
        getStatisticData(cycle);
    })

    $(function(){
        getStatisticData(30)
    })

    /**
     * 获取统计数据
     * @param cycle 统计周期
     */
    function getStatisticData(cycle){
        var cycle = $("#countCycle").val();//统计周期
        //统计周期支持用户手动输入天数，但使用下拉列表可免于校验
        $.ajax({
            type:'post',
            url:'/bankAccountServlet?method=getStatisticData&cycle='+cycle,
            async:true,
            success:function(data){
                var msg = JSON.parse(data);
                generateChart(msg)
            },
            error:function(){
                layer.msg("获取统计信息失败！");
            }
        })
    }


    function setDepositChart(data){
        var depositChart = echarts.init(document.getElementById('depositChart'));
        var deposit = data.depositSum;
        var amountArr = [];
        var xAxisArr = [];
        for(var i=0;i<deposit.length;i++){
            xAxisArr.push(deposit[i].bank_name+" "+deposit[i].account_no.slice(deposit[i].account_no.length-4,deposit[i].account_no.length))
            amountArr.push(deposit[i].depositSum);
        }

        depositChart.setOption({
            grid:{
                x:50,
                y:50,
                x2:50,
                y2:50,
                borderWidth:1
            },
            xAxis: {
                data: xAxisArr,
            },
            yAxis: {},
            series: [{
                name: '存款额',
                type: 'bar',
                barMaxWidth:30,
                data: amountArr,
                label:{
                    normal:{
                        show:true,
                        position:'top',
                    }
                },
            }]
        })
    }

    function setWithdrawChart(data){

        var withdrawChart = echarts.init(document.getElementById('withdrawChart'));
        var deposit = data.withdrawSum;
        var amountArr = [];
        var xAxisArr = [];
        for(var i=0;i<deposit.length;i++){
            xAxisArr.push(deposit[i].bank_name+" "+deposit[i].account_no.slice(deposit[i].account_no.length-4,deposit[i].account_no.length))
            amountArr.push(deposit[i].withdrawSum);
        }

        withdrawChart.setOption({
            grid:{
                x:50,
                y:50,
                x2:50,
                y2:50,
                borderWidth:1
            },
            xAxis: {
                data: xAxisArr,
            },
            yAxis: {},
            series: [{
                name: '存款额',
                type: 'bar',
                barMaxWidth:30,
                data: amountArr,
                label:{
                    normal:{
                        show:true,
                        position:'top',
                    }
                },
            }]
        })
    }

    function generateChart(msg){
        setDepositChart(msg);
        setWithdrawChart(msg);
    }
</script>
</body>
</html>
