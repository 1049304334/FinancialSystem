<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% HashMap familyMap = (HashMap)session.getAttribute("familyMap");%>

<html>
<head>
    <title>收支记录</title>
</head>
<body>
    <div>
        <div class="page-header welcome-home">
            <h1>&nbsp;&nbsp;<small>收支记录</small></h1>
        </div>
        <div class="layui-tab layui-tab-card">
            <ul class="layui-tab-title">
                <li class="layui-this">收入记录</li>
                <li>支出记录</li>
            </ul>

            <div class="layui-tab-content">
                <!--收入记录-->
                <div class="layui-tab-item layui-show">
                        <table class="base-table">
                            <tr>
                                <td style="text-align: left">
                                    <button class="layui-btn" onclick="showIncomeModal()"><i class="layui-icon icon-display">&#xe642;</i>记笔收入</button>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr style="height: auto">
                                <td colspan="4">
                                    <table id="income-table">

                                    </table>
                                </td>
                            </tr>
                        </table>
                </div>
                <!--支出记录-->
                <div class="layui-tab-item">
                    <table class="base-table">
                        <tr>
                            <td style="text-align: left">
                                <button class="layui-btn" onclick="showExpandModal()"><i class="layui-icon icon-display">&#xe642;</i>记笔支出</button>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr style="height: auto">
                            <td colspan="4">
                                <table id="expand-table">

                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!--收入记录模态框-->
        <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="incomeModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>记录收入</h4>
                    </div>
                    <div class="modal-body">
                        <table class="base-table">
                            <tr>
                                <td><label>收入类型：</label></td>
                                <td colspan="6">
                                    <select id="incomeType" lay-verify="required" class="layui-input">
                                        <option value="">--请选择类型--</option>
                                    </select>
                                </td>
                            </tr>
                            <tr style="height:24px"></tr>
                            <tr>
                                <td><label>收入日期：</label></td>
                                <td colspan="6">
                                    <input type="text" id="incomeDate" placeholder="点击选择日期" class="layui-input"/>
                                </td>
                            </tr>
                            <tr style="height:24px"></tr>
                            <tr>
                                <td><label>收入金额：</label></td>
                                <td colspan="6">
                                    <input type="text" id="incomeAmount" placeholder="￥" autocomplete="off" class="layui-input">
                                </td>
                            </tr>
                            <tr style="height:24px"></tr>
                            <tr>
                                <td><label>备注：</label></td>
                                <td colspan="6">
                                    <textarea class="layui-textarea" placeholder="最多128个汉字" id="incomeRemark"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                        <button type="button" class="layui-btn" onclick="saveIncomeRecord()">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <!--支出记录模态框-->
        <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="expandModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>记录支出</h4>
                    </div>
                    <div class="modal-body">
                        <table class="base-table">
                            <tr>
                                <td><label>支出类型：</label></td>
                                <td colspan="6">
                                    <select id="expandType" lay-verify="required" class="layui-input">
                                        <option value="">--请选择类型--</option>
                                    </select>
                                </td>
                            </tr>
                            <tr style="height:24px"></tr>
                            <tr>
                                <td><label>支出日期：</label></td>
                                <td colspan="6">
                                    <input type="text" id="expandDate" placeholder="点击选择日期" class="layui-input"/>
                                </td>
                            </tr>
                            <tr style="height:24px"></tr>
                            <tr>
                                <td><label>支出金额：</label></td>
                                <td colspan="6">
                                    <input type="text" id="expandAmount" placeholder="￥" autocomplete="off" class="layui-input">
                                </td>
                            </tr>
                            <tr style="height:24px"></tr>
                            <tr>
                                <td><label>备注：</label></td>
                                <td colspan="6">
                                    <textarea class="layui-textarea" placeholder="最多128个汉字" id="expandRemark"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                        <button type="button" class="layui-btn" onclick="saveExpandRecord()">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <script>

            $(function(){
                loadIncomeRecord()
                loadExpandRecord()
                getTypes();
            })

            function loadIncomeRecord(){

                var familyId = <%="'"+familyMap.get("family_id")+"'"%>;
                var dataUrl = "<%=path%>/incomeExpendServlet?method=getIncomeRecord&familyId="+familyId;

                layui.use(['table','laydate'], function(){
                    var table = layui.table;
                    var laydate = layui.laydate;

                    var dateNow = new Date();
                    var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();

                    var obj = laydate.render({
                        elem:'#incomeDate',
                        type:'date',
                        max:'limit',
                        ready:function(){
                            obj.hint("可选日期在今日及之前");
                        }
                    })

                    table.render({
                        elem: '#income-table'
                        ,height: 400
                        ,width:1100
                        ,url: dataUrl
                        ,page: true
                        ,cols: [[
                             {field: 'amount', title: '金额', width:191,align:'center',sort:'true'}
                            ,{field: 'type_name', title: '收入类型', width:270,align:'center',sort:'true'}
                            ,{field: 'income_date', title: '日期', width:190,align:'center',sort:'true'}
                            ,{field: 'true_name', title: '用户', width:270,align:'center',sort:'true'}
                            ,{field: 'remark', title: '备注', width:172}
                        ]]
                    });
                });
            }

            function loadExpandRecord(){

                var familyId = <%="'"+familyMap.get("family_id")+"'"%>;
                var dataUrl = "<%=path%>/incomeExpendServlet?method=getExpandRecord&familyId="+familyId;

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
                        elem: '#expand-table'
                        ,height: 400
                        ,width:1100
                        ,url: dataUrl
                        ,page: true
                        ,cols: [[
                            {field: 'amount', title: '金额', width:191,align:'center',sort:'true'}
                            ,{field: 'type_name', title: '支出类型', width:270,align:'center',sort:'true'}
                            ,{field: 'outcome_date', title: '日期', width:190,align:'center',sort:'true'}
                            ,{field: 'true_name', title: '用户', width:270,align:'center',sort:'true'}
                            ,{field: 'remark', title: '备注', width:172}
                        ]]
                    });
                });
            }


            /**
             * 获取此家庭所有的收入类型和收支类型，并拼接到下拉列表
             */
            function getTypes(){
                var incomeTypeHtml = "";
                var expandTypeHtml = "";

                $.ajax({
                    type:'post',
                    url:'<%=path%>/incomeExpendServlet?method=getTypes',
                    async:true,
                    success:function(res){
                        var info = JSON.parse(res)
                        var types = info.types;
                        for(var i = 0;i < types.length;i++){
                            if(types[i].type_direction=='收入'){
                                incomeTypeHtml += '<option value='+types[i].type_id+'>'+types[i].type_name+'</option>';
                            }else{
                                expandTypeHtml += '<option value='+types[i].type_id+'>'+types[i].type_name+'</option>';
                            }
                        }
                        //将两条字符串拼接到两个select上
                        $("#incomeType").append(incomeTypeHtml);
                        $("#expandType").append(expandTypeHtml);
                    },
                    error:function(){
                        layer.msg("获取收支类型信息失败");
                    }
                })
            }

            function showIncomeModal(){
                $("#incomeModal").modal('show');
            }

            function hideIncomeModal(){
                $("#incomeModal").modal('hide');
            }

            function showExpandModal(){
                $("#expandModal").modal('show');
            }

            function hideExpandModal(){
                $("#expandModal").modal('hide');
            }

            function clearModalInput() {
                $("#incomeType").val("");
                $("#incomeDate").val("");
                $("#incomeAmount").val("");
                $("#incomeRemark").val("");

                $("#expandType").val("");
                $("#expandDate").val("");
                $("#expandAmount").val("");
                $("#expandRemark").val("");
            }

            /**
             * 保存收入记录
             */
            function saveIncomeRecord(){
                var record = {};
                record.incomeType = $("#incomeType").val();
                record.incomeDate = $("#incomeDate").val();
                record.incomeAmount = $("#incomeAmount").val();
                record.incomeRemark = $("#incomeRemark").val();

                if(record.type==""){
                    layer.msg("请选择收入类型");
                    return;
                }
                if(record.incomeDate==""){
                    layer.msg("请选择收入日期");
                    return;
                }
                if(record.incomeAmount==""){
                    layer.msg("请输入收入金额");
                    return;
                }

                $.ajax({
                    type:'post',
                    data:record,
                    url:'<%=path%>/incomeExpendServlet?method=saveIncomeRecord',
                    async:false,
                    success:function(){
                        layer.msg("已保存");
                        hideIncomeModal();
                        loadIncomeRecord();
                    },
                    error:function(){
                        layer.msg("保存失败");
                    }
                })
            }

            function saveExpandRecord(){
                var record = {};
                record.expandType = $("#expandType").val();
                record.expandDate = $("#expandDate").val();
                record.expandAmount = $("#expandAmount").val();
                record.expandRemark = $("#expandRemark").val();

                if(record.expandType==""){
                    layer.msg("请选择支出类型");
                    return;
                }
                if(record.expandDate==""){
                    layer.msg("请选择支出日期");
                    return;
                }
                if(record.expandAmount==""){
                    layer.msg("请输入支出金额");
                    return;
                }

                $.ajax({
                    type:'post',
                    data:record,
                    url:'<%=path%>/incomeExpendServlet?method=saveExpandRecord',
                    async:false,
                    success:function(){
                        layer.msg("已保存");
                        hideExpandModal();
                        loadExpandRecord();
                        clearModalInput();
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
