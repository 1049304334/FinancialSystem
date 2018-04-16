<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% HashMap familyMap = (HashMap)session.getAttribute("familyMap");%>

<html>
<head>
    <title>存取记录</title>
</head>
<body>
<div>
    <div class="page-header welcome-home">
        <h1>&nbsp;&nbsp;<small>存取记录</small></h1>
    </div>
    &nbsp;<button class="layui-btn" onclick="showRecordModal()"><i class="layui-icon icon-display">&#xe642;</i>记录存取款</button>

    <div class="layui-tab layui-tab-card">
        <ul class="layui-tab-title">
            <li class="layui-this">存款记录</li>
            <li>取款记录</li>
        </ul>

        <div class="layui-tab-content">
            <!--存入记录-->
            <div class="layui-tab-item layui-show">
                <table class="base-table">
                    <tr style="height: auto">
                        <td colspan="4">
                            <table id="deposit-table">

                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <!--取出记录-->
            <div class="layui-tab-item">
                <table class="base-table">
                    <tr style="height: auto">
                        <td colspan="4">
                            <table id="withdraw-table">

                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!--存取款记录模态框-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="incomeModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>存取款记录</h4>
                </div>
                <div class="modal-body">
                    <table class="base-table">
                        <tr>
                            <td><label>操作类型：</label></td>
                            <td colspan="6">
                                <select id="operationType" lay-verify="required" class="layui-input">
                                    <option value="">请选择操作类型</option>
                                    <option value="deposit">存款</option>
                                    <option value="withdraw">取款</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="height:24px"></tr>
                        <tr>
                            <td><label>操作账号：</label></td>
                            <td colspan="6">
                                <select id="bankAccount" class="layui-input">
                                    <option value="">请选择一个账户</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="height:24px"></tr>
                        <tr>
                            <td><label>操作日期：</label></td>
                            <td colspan="6">
                                <input type="text" id="operationDate" placeholder="点击选择日期" class="layui-input"/>
                            </td>
                        </tr>
                        <tr style="height:24px"></tr>
                        <tr>
                            <td><label>金额：</label></td>
                            <td colspan="6">
                                <input type="text" id="operationAmount" placeholder="￥" autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                        <tr style="height:24px"></tr>
                        <tr>
                            <td><label>备注：</label></td>
                            <td colspan="6">
                                <textarea class="layui-textarea" placeholder="最多128个汉字" id="operationRemark"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                    <button type="button" class="layui-btn" onclick="saveOperationRecord()">保存</button>
                </div>
            </div>
        </div>
    </div>

    <script>

        $(function(){
            initPage();
        })

        function initPage(){
            loadDepositRecord();
            loadWithdrawRecord();
            getAccounts();
        }

        function loadDepositRecord(){

            layui.use(['table','laydate'], function(){
                var table = layui.table;
                var laydate = layui.laydate;

                var dateNow = new Date();
                var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();

                var obj = laydate.render({
                    elem:'#operationDate',
                    type:'date',
                    max:'limit',
                    ready:function(){
                        obj.hint("可选日期在今日及之前");
                    }
                })

                table.render({
                    elem: '#deposit-table'
                    ,height: 400
                    ,width:1100
                    ,url: '<%=path%>/bankAccountServlet?method=getDepositRecord'
                    ,page: true
                    ,cols: [[
                        {field: 'account_no', title: '账号', width:300,align:'center',sort:'true'}
                        ,{field: 'amount', title: '金额', width:200,align:'center',sort:'true'}
                        ,{field: 'operation_date', title: '存款日期', width:200,align:'center',sort:'true'}
                        ,{field: 'remark', title: '备注', width:394}
                    ]]
                });
            });
        }

        function loadWithdrawRecord(){

            layui.use(['table','laydate'], function(){
                var table = layui.table;
                var laydate = layui.laydate;

                var dateNow = new Date();
                var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();

                var obj = laydate.render({
                    elem:'#expandDate',
                    type:'date',
                    max:'limit',
                    ready:function(){
                        obj.hint("可选日期在今日及之前");
                    }
                })

                table.render({
                    elem: '#withdraw-table'
                    ,height: 400
                    ,width:1100
                    ,url: '<%=path%>/bankAccountServlet?method=getWithdrawRecord'
                    ,page: true
                    ,cols: [[
                        {field: 'account_no', title: '账号', width:300,align:'center',sort:'true'}
                        ,{field: 'amount', title: '金额', width:200,align:'center',sort:'true'}
                        ,{field: 'operation_date', title: '取款日期', width:200,align:'center',sort:'true'}
                        ,{field: 'remark', title: '备注', width:394}
                    ]]
                });
            });
        }

        /**
         * 获取此家庭所有的收入类型和收支类型，并拼接到下拉列表
         */
        function getAccounts(){
            var accountHtml = "<option value=''>请选择账户</option>";

            $.ajax({
                type:'post',
                url:'<%=path%>/bankAccountServlet?method=getBankAccount',
                async:true,
                success:function(res){
                    var info = JSON.parse(res)
                    var accounts = info.data;
                    for(var i = 0;i < accounts.length;i++){
                        accountHtml += '<option value='+accounts[i].account_no+'>'+accounts[i].bank_name+'&nbsp;&nbsp;&nbsp;&nbsp;'+accounts[i].account_no.slice(accounts[i].account_no.length-4,accounts[i].account_no.length)+'</option>';
                    }
                    //将两条字符串拼接到两个select上
                    $("#bankAccount").empty();
                    $("#bankAccount").append(accountHtml);
                },
                error:function(){
                    layer.msg("获取收支类型信息失败");
                }
            })
        }

        function showRecordModal(){
            $("#incomeModal").modal('show');
        }

        function hideRecordModal(){
            $("#incomeModal").modal('hide');
            $("#incomeModal input").val("");
            $("#incomeModal select").val("");
        }

        function clearModalInput() {

        }

        /**
         * 保存收入记录
         */
        function saveOperationRecord(){
            var record = {};
            record.operationType = $("#operationType").val();
            record.bankAccount = $("#bankAccount").val();
            record.operationDate = $("#operationDate").val();
            record.operationAmount = $("#operationAmount").val();
            record.operationRemark = $("#operationRemark").val();

            if(record.operationType==""){
                layer.msg("请选择操作类型");
                return;
            }
            if(record.bankAccount==""){
                layer.msg("请选择账户");
                return;
            }
            if(record.operationDate==""){
                layer.msg("请设置日期");
                return;
            }
            if(record.operationAmount==""){
                layer.msg("请输入金额");
                return;
            }

            $.ajax({
                type:'post',
                data:record,
                url:'<%=path%>/bankAccountServlet?method=saveOperationRecord',
                async:false,
                success:function(){
                    layer.msg("已保存");
                    hideRecordModal();
                    initPage();
                },
                error:function(){
                    layer.msg("保存失败");
                }
            })
        }

    </script>
</div>
</body>
</html>
