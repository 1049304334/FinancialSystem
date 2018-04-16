<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% HashMap familyMap = (HashMap)session.getAttribute("familyMap");%>
<% String path = request.getContextPath();%>
<html>
<head>
    <title></title>
</head>
<body>
<div class="page-header welcome-home">
    <h1>&nbsp;&nbsp;<small>债权管理</small></h1>
</div>

<div class="container main-div">
    <table class="base-table">
        <tr style="text-align: left">
            <td colspan="5">
                <button class="layui-btn" onclick="showCreateModal()"><i class="layui-icon icon-display">&#xe654;</i>添加债权记录</button>
            </td>
        </tr>
    </table>
    <table id="credit-table" lay-filter="creditTable">

    </table>
</div>

<!-- 新建债权模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="newCreditModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>添加债权记录</h4>
            </div>
            <div class="modal-body">
                <table class="base-table">
                    <tr>
                        <td colspan="2"><label>借款人姓名：</label></td>
                        <td colspan="6"><input type="text" id="lenderName" class="layui-input"/></td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td colspan="2"><label>借款日期：</label></td>
                        <td colspan="6"><input type="text" id="lendDate" class="layui-input"/></td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td colspan="2"><label>金额：</label></td>
                        <td colspan="6"><input type="text" id="balance" class="layui-input"/></td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td colspan="2"><label>约定还款日：</label></td>
                        <td colspan="6"><input type="text" id="repayDate" class="layui-input"/></td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td colspan="2"><label>备注：</label></td>
                        <td colspan="6"><textarea id="remark" class="layui-textarea"></textarea></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                <button type="button" class="layui-btn" onclick="saveCreditor()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 更新债权模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="editCreditModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>更新债权信息</h4>
            </div>
            <div class="modal-body">
                <table class="base-table">
                    <tr>
                        <td><label>借款人</label></td>
                        <td colspan="6">
                            <input type="text" name="lenderName" class="layui-input" disabled/>
                            <input type="hidden" name="lendId"/>
                        </td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td><label>余额</label></td>
                        <td colspan="6">
                            <input type="text" name="balance" class="layui-input"/>
                        </td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td><label>还款日期</label></td>
                        <td colspan="6">
                            <input type="text" name="repayDate" id="newRepayDate" class="layui-input"/>
                        </td>
                    </tr>
                    <tr style="height: 24px"></tr>
                    <tr>
                        <td><label>备注</label></td>
                        <td colspan="6">
                            <textarea name="remark" class="layui-textarea"></textarea>
                        </td>
                    </tr>
                    <tr style="height: 24px"></tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                <button type="button" class="layui-btn" onclick="saveEdit()">保存</button>
            </div>
        </div>
    </div>
</div>



<script type="text/html" id="updateCredit">
    <a class="layui-btn layui-btn-sm" lay-event="edit"><i class="layui-icon icon-display">&#xe642;</i>更新</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon icon-display">&#xe640;</i>删除</a>
</script>

<script>
    $(function(){
        initPage();
    })

    function initPage(){
        setDate();
        loadTableData();
        resetModalVal();
    }
    /**
     * 启用模态框上的两个日期选择框，使其可以弹出日期选择
     */
    function setDate(){
        layui.use('laydate',function(){
            var laydate = layui.laydate;

            var dateNow = new Date();
            var maxLimit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();

            var date1 = laydate.render({
                elem:'#lendDate',
                type:'date',
                max:'maxLimit',
                ready:function(){
                    date1.hint("可选日期在今日及之前");
                }
            })

            var date2 = laydate.render({
                elem:'#repayDate',
                type:'date',
                min:'maxLimit',
                ready:function(){
                    date2.hint("可选日期在今日及之后");
                }
            })

            var date3 = laydate.render({
                elem:'#newRepayDate',
                type:'date',
                min:'maxLimit',
                ready:function(){
                    date3.hint("可选日期在今日及之后");
                }
            })
        })
    }

    /**
     * 加载表格数据
     */
    function loadTableData(){

        layui.use('table', function(){
            var table = layui.table;

            table.on('tool(creditTable)', function(obj){
                var data = obj.data;
                if(obj.event==='edit'){
                    showEditModal(data);
                }
                if(obj.event==='del'){
                    layer.confirm("确定删除？",function(){
                        deleteCredit(data);
                    })
                }
            });

            table.render({
                elem: '#credit-table'
                ,width:1100
                ,cellMinWidth: 0
                ,url: '<%=path%>/debtServlet?method=getCreditors'
                ,page: true
                ,cols: [[
                    {field: 'balance', title: '余额', width:150,align:"center",sort:'true'}
                    ,{field: 'lender_name', title: '借款人', width:100,align:"center"}
                    ,{field: 'lend_date', title: '借款日期',sort:'true', width:175,align:"center"}
                    ,{field: 'repay_date', title: '还款日期',sort:'true', width:175,align:"center"}
                    ,{field: 'remark', title: '备注', width:300,align:"center"}
                    ,{toolbar: '#updateCredit',align:'center'}
                ]]
            });
        });

    }
    function showCreateModal(){
        $("#newCreditModal").modal('show');
        resetModalVal();
    }

    function hideCreateModal(){
        $("#newCreditModal").modal('hide');
        resetModalVal()
    }

    function saveCreditor(){
        var data = {};
        data.lenderName = $("#lenderName").val();
        data.lendDate = $("#lendDate").val();
        data.balance = $("#balance").val();
        data.repayDate = $("#repayDate").val();
        data.remark = $("#remark").val();

        if(data.lenderName==""||data.lendDate==""||data.balance==""||data.repayDate==""){
            layer.msg("请将信息输入完整");
            return;
        }

        $.ajax({
            type:'post',
            async:false,
            data:data,
            url:"<%=path%>/debtServlet?method=saveCredit",
            success:function(){
                layer.msg("保存成功");
                hideCreateModal();
                initPage();
            },
            error:function(){
                layer.msg("保存失败");
            }
        })
    }

    function resetModalVal(){
        $("#lenderName").val("");
        $("#lendDate").val("");
        $("#balance").val("");
        $("#repayDate").val("");
        $("#remark").val("");

        $("input[name='lenderName']").val("");
        $("input[name='balance']").val("");
        $("input[name='repayDate']").val("");
        $("textarea[name='remark']").val("");
    }

    function showEditModal(data){
        $("#editCreditModal").modal('show');
        $("input[name='lendId']").val(data.lend_id);
        $("input[name='lenderName']").val(data.lender_name);
        $("input[name='balance']").val(data.balance);
        $("input[name='repayDate']").val(data.repay_date);
        $("textarea[name='remark']").val(data.remark);
    }

    function hideEditModal(){
        $("#editCreditModal").modal('hide');
        resetModalVal();
    }

    //待修改
    function saveEdit(){
        var data = {};
        data.lendId = $("input[name='lendId']").val();
        data.balance = $("input[name='balance']").val();
        data.repayDate = $("input[name='repayDate']").val();
        data.remark = $("textarea[name='remark']").val();

        $.ajax({
            type:'post',
            url:"<%=path%>/debtServlet?method=editCredit",
            data:data,
            async:true,
            success:function(){
                layer.msg("修改成功");
                hideEditModal();
                initPage()
            },
            error:function(){
                layer.msg("修改失败");
            }

        })
    }

    function deleteCredit(data){

        var lendId = data.lend_id;
        if(data.balance>0){
            layer.alert("不允许删除余额大于0的债权记录");
            return
        }

        $.ajax({
            type:'post',
            url:'<%=path%>/debtServlet?method=deleteCredit&lendId='+lendId,
            async:false,
            success:function (){
                layer.msg("已删除");
                initPage();
            }
        })

    }
</script>
</body>
</html>
