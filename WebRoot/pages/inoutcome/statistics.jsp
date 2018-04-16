<%@ page import="java.util.HashMap" %>
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
            <td>&nbsp;&nbsp;&nbsp;&nbsp;<label>收支总计:</label></td>
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
            <td colspan="3"><label>收入来源统计</label></td>
            <td></td>
            <td colspan="3"><label>支出去向统计</label></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="3">
                <div id="incomeChart" class="chart-div"></div>
            </td>
            <td></td>
            <td colspan="3">
                <div id="expandChart" class="chart-div"></div>
            </td>
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
    function getStatisticData() {

        var dateRange = {};
        dateRange.startDate = $("#startDate").val();
        dateRange.endDate = $("#endDate").val();
        if(dateRange.startDate==""||dateRange.endDate==""||dateRange.startDate>dateRange.endDate){
            layer.alert("日期输入有误，请重新输入");
            return;
        }
        $.ajax({
            type: 'post',
            data:dateRange,
            url: '<%=path%>/incomeExpendServlet?method=getStatisticData',
            async: true,
            success: function (data) {
                var msg = JSON.parse(data);
                generateChart(msg)
            },
            error: function () {
                layer.msg("获取统计信息失败！");
            }
        })
    }

    //设置收入支出进度条的宽度和文字
    function setProgressBar(data) {
        var totalIncome = parseFloat(data.income.totalIncome);
        var totalExpand = parseFloat(data.expand.totalExpand);
        var incomeRate = totalIncome / (totalIncome + totalExpand) * 100;
        var expandRate = 100 - incomeRate;
        $(".income-div").width(Math.round(incomeRate) + "%");
        $(".expand-div").width(Math.round(expandRate) + "%");
        $(".income-div")[0].innerHTML = "&nbsp;&nbsp;总收入：" + totalIncome + "元";
        $(".expand-div")[0].innerHTML = "&nbsp;&nbsp;总支出：" + totalExpand + "元";
        //宽度的改变可能会影响div中文字的样式，下面两行代码用于设置div的title属性。
        //当div的宽度太小以至于文字无法正常显示时，将鼠标移至div上悬停，就可以看到以文字提示形式出现的金额提示
        $(".income-div").attr("title", "总收入：" + totalIncome + "元");
        $(".expand-div").attr("title", "总支出：" + totalExpand + "元");
    }

    function setIncomeChart(data) {
        var incomeChart = echarts.init(document.getElementById('incomeChart'));
        var incomes = data.countIncomeByType;
        var newArr = [];
        for (var i = 0; i < incomes.length; i++) {
            var obj = {};
            obj.name = incomes[i].type_name;
            obj.value = incomes[i].total;
            newArr.push(obj)
        }

        incomeChart.setOption({

            series: [
                {
                    name: '收入来源分析',
                    type: 'pie',
                    radius: '55%',
                    label: {            //饼图图形上的文本标签
                        normal: {
                            show: true,
                            position: '', //标签的位置
                            formatter: '{b}\n{d}%\n{c}元'
                        }
                    },
                    data: newArr,
                }
            ]
        })

    }

    function setExpandChart(data) {
        var expandChart = echarts.init(document.getElementById('expandChart'));
        var incomes = data.countOutcomeByType;
        var newArr = [];
        for (var i = 0; i < incomes.length; i++) {
            var obj = {};
            obj.name = incomes[i].type_name;
            obj.value = incomes[i].total;
            newArr.push(obj)
        }

        expandChart.setOption({

            series: [
                {
                    name: '支出去向分析',
                    type: 'pie',
                    radius: '55%',
                    label: {            //饼图图形上的文本标签
                        normal: {
                            show: true,
                            position: '', //标签的位置
                            formatter: '{b}\n{d}%\n{c}元'
                        }
                    },
                    data: newArr,
                }
            ]
        })

    }

    function generateChart(msg) {
        if(msg.countOutcomeByType.length==0&&msg.countIncomeByType.length==0){
            layer.msg("没有这段时间内的收支记录");
            return;
        }
        if(msg.countOutcomeByType.length==0&&msg.countIncomeByType.length!=0){
            layer.msg("没有这段时间内的支出记录");
            setProgressBar(msg);
            setIncomeChart(msg);
            return;
        }
        if(msg.countIncomeByType.length==0&&msg.countOutcomeByType.length!=0){
            layer.msg("没有这段时间内的收入记录");
            setProgressBar(msg);
            setExpandChart(msg);
            return;
        }
        setProgressBar(msg);
        setIncomeChart(msg);
        setExpandChart(msg);
    }
</script>
</body>
</html>
