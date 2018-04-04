<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="page-header welcome-home">
    <h1>&nbsp;&nbsp;<small>新建备忘</small></h1>
</div>

<div class="container main-div">
    <table class="base-table">
        <tr style="text-align: left">
            <td colspan="5">
                <button class="layui-btn" onclick="saveNote()"><i class="layui-icon icon-display">&#xe61d;</i>保存备忘</button>
            </td>
        </tr>
    </table>
    <table class="base-table">
        <tr style="height:24px"></tr>
        <tr>
            <td><label>提醒时间：</label></td>
            <td colspan="2">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="tipTime" placeholder="点击设置时间">
                    </div>
                </div>
            </td>
            <td colspan="8"></td>
        </tr>
        <tr style="height:24px"></tr>
        <tr>
            <td><label>备忘内容：</label></td>
            <td colspan="10">
                <textarea class="layui-textarea" id="noteContent" style="width: 99%;float: right" placeholder="最多128个汉字"></textarea>
            </td>
        </tr>
    </table>
</div>
<script>

    $(function(){

        layui.use('laydate', function() {
            var laydate = layui.laydate;
            var dateNow = new Date();
            var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();

            var ins22 = laydate.render({
                elem: '#tipTime'
                ,type:'datetime'
                ,min: 'limit'
                ,ready: function(){
                    ins22.hint('日期可选值设定在'+limit+'之后');
                }
            });
        })
    })

    function saveNote(){
        var data = {};
        data.tipTime = $("#tipTime").val();
        data.noteContent = $("#noteContent").val();
        if(data.tipTime==""||data.noteContent==""){
            layer.msg("信息还没输入完整");
            return;
        }
        $.ajax({
            type:'post',
            data:data,
            url:'/noteServlet?method=saveNote',
            async:false,
            success:function(){
                layer.msg("保存成功");
            },
            error:function(){
                layer.msg("保存失败");
            }
        })
    }
</script>
</body>
</html>
