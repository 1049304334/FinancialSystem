<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% HashMap userMap = (HashMap) session.getAttribute("familyMap");%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="page-header welcome-home">
    <h1>&nbsp;&nbsp;<small>储蓄账户管理</small></h1>
</div>

<div class="container main-div">
    <table class="base-table">
        <tr style="text-align: left">
            <td colspan="5">
                <button class="layui-btn" onclick="javaScript:showModal();"><i class="layui-icon icon-display">&#xe654;</i>新建储蓄账户</button>
            </td>
        </tr>
    </table>
    <table id="accountTable" lay-filter="accountTableFilter">

    </table>
</div>

<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="newAccountModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>新建账户</h4>
            </div>
            <div class="modal-body">
                <table class="base-table">
                    <tr>
                        <td><label>账号：</label></td>
                        <td colspan="6">
                            <input class="layui-input" id="accountNo" placeholder="请输入自己的银行账号"/>
                        </td>
                    </tr>
                    <tr style="height:16px"></tr>
                    <tr>
                        <td><label>银行名称：</label></td>
                        <td colspan="6"><input type="text" class="layui-input" id="bankName"/></td>
                    </tr>
                    <tr style="height:16px"></tr>
                    <tr>
                        <td><label>银行地址：</label></td>
                        <td colspan="6"><input type="text" class="layui-input" id="bankAddress"/></td>
                    </tr>
                    <tr style="height:16px"></tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                <button type="button" class="layui-btn" onclick="saveNewAccount()">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="deleteAccount">
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon icon-display">&#xe640;</i>删除</a>
</script>

<script>
    $(function(){
        loadTableData();
    })

    function loadTableData(){
        var userId = <%="'"+userMap.get("id")+"'"%>;
        var dataUrl = "/bankAccountServlet?method=getBankAccount&userId="+userId;

        layui.use('table', function(){
            var table = layui.table;

            table.on('tool(accountTableFilter)', function(obj){
                var data = obj.data;
                if(obj.event==='del'){
                    layer.confirm('确定删除么', function(index){
                        deleteAccount(data);
                        obj.del();
                        layer.close(index);
                    });
                }
            });

            table.render({
                elem: '#accountTable'
                ,width:1100
                ,cellMinWidth: 0
                ,url: dataUrl
                ,page: true
                ,cols: [[
                    {field: 'account_no', title: '账号', width:300,sort:'true',align:"center"}
                    ,{field: 'bank_name', title: '银行名称',sort:'true', width:300,align:"center"}
                    ,{field: 'bank_address', title: '银行地址', width:400,align:"center"}
                    ,{toolbar: '#deleteAccount',align:'center'}
                ]]
            });
        });
    }

    function showModal(){
        $("#newAccountModal").modal('show');
    }

    function hideModal(){
        $("#newAccountModal").modal('hide');
    }

    function saveNewAccount(){
        var data = {};
        data.accountNo = $("#accountNo").val();
        data.bankName = $("#bankName").val();
        data.bankAddress = $("#bankAddress").val();
        if(data.accountNo==""||data.bankName==""){
            layer.msg("请将信息输入完整");
            return;
        }
        $.ajax({
            type:'post',
            async:false,
            data:data,
            url:"/bankAccountServlet?method=saveBankAccount",
            success:function(msg){
                var status = JSON.parse(msg);
                if(status.res=='0'){
                    layer.msg("保存成功");
                    hideModal();
                    loadTableData();
                }else{
                    layer.alert("保存失败，此账号已存在");
                }
            },
            error:function(){
                layer.msg("保存失败");
            }
        })
    }

    function deleteAccount(obj){
        var data = {};
        data.accountNo = obj.account_no;
        $.ajax({
            type:'post',
            data:data,
            async:true,
            url:'bankAccountServlet?method=deleteAccount',
            error:function(){
                layer.msg("删除失败");
            }
        })
        loadTableData();
    }
</script>

</body>
</html>
