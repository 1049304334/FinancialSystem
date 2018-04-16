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
            <tr>
                <td><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计周期：</label></td>
                <td>从</td>
                <td colspan="2" >
                    <input type="text" class="layui-input" id="startDate" placeholder="选择开始日期"/>
                </td>
                <td>到</td>
                <td colspan="2" >
                    <input type="text" class="layui-input" id="endDate" placeholder="选择结束日期"/>
                </td>
                <td><button class="layui-btn" onclick="getStatisticData()"><i class="layui-icon icon-display" style="font-size: 16px">&#xe615;</i>查看</button></td>
                <td colspan="2"></td>
            </tr>
            <tr style="height: 24px;"></tr>
        </table>
        <table class="base-table">
            <tr>
                <td>&nbsp;&nbsp;<label>存取总计:</label></td>
                <td colspan="8"></td>
            </tr>
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


    $(function(){
        initStartDate();
        initEndDate();
    })

    function initStartDate(){
        layui.use('laydate',function(){
            var laydate = layui.laydate;
            var dateNow = new Date();
            var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();
            var startDate = laydate.render({
                elem:'#startDate',
                type:'date',
                max:limit,

            })
        })
    }

    function initEndDate(){
        layui.use('laydate',function(){
            var laydate = layui.laydate;
            var dateNow = new Date();
            var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();
            var endDate = laydate.render({
                elem:'#endDate',
                type:'date',
                max:limit,

            })
        })
    }
    /**
     * 获取统计数据
     * @param cycle 统计周期
     */
    function getStatisticData(){
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if(startDate==""||endDate==""||startDate>endDate){
            layer.alert("日期输入有误，请重新输入");
            return;
        }
        var dateRange = {};
        dateRange.startDate = startDate;
        dateRange.endDate = endDate;

        $.ajax({
            type:'post',
            data:dateRange,
            url:'<%=path%>/bankAccountServlet?method=getStatisticData',
            async:true,
            success:function(data){
                var msg = JSON.parse(data);
                generateChart(msg)
                console.log(msg)
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
                y2:70,
                borderWidth:1
            },
            xAxis: {
                data: xAxisArr,
                axisLabel: {  
   					interval:0,  
   					rotate:40  
				},
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
                y2:70,
                borderWidth:1
            },
            xAxis: {
                data: xAxisArr,
                axisLabel: {  
   					interval:0,  
   					rotate:40  
				},
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

        if(msg.depositSum.length==0&&msg.withdrawSum.length==0){
            layer.msg("没有这段时间内的存取款记录");
            return;
        }
        if(msg.depositSum.length==0&&msg.withdrawSum.length!=0){
            layer.msg("没有这段时间内的存款记录");
            setWithdrawChart(msg);
            return;
        }
        if(msg.depositSum.length!=0&&msg.withdrawSum.length==0){
            layer.msg("没有这段时间内的取款记录");
            setDepositChart(msg);
            return;
        }
        setDepositChart(msg);
        setWithdrawChart(msg);
    }
</script>
</body>
</html>
