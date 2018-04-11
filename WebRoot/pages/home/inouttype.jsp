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
        <h1>&nbsp;&nbsp;<small>收支类型管理</small></h1>
    </div>

    <div class="container main-div">
        <table class="base-table">
            <tr style="text-align: left">
                <td colspan="5">
                    <button class="layui-btn" onclick="showModal()"><i class="layui-icon icon-display">&#xe654;</i>新建收支类型</button>
                </td>
            </tr>
        </table>
        <table id="inout-type-table" lay-filter="typeTable">

        </table>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="newTypeModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>新建收支类型</h4>
                </div>
                <div class="modal-body">
                    <table class="base-table">
                        <tr>
                            <td><label>类型：</label></td>
                            <td colspan="6">
                                <select id="newTypeSelect" class="form-control">
                                    <option value="">请选择类型</option>
                                    <option value="1">收入</option>
                                    <option value="2">支出</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="height:16px"></tr>
                        <tr>
                            <td><label>名称：</label></td>
                            <td colspan="6"><input type="text" class="form-control" id="newTypeName"/></td>
                        </tr>
                        <tr style="height:16px"></tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                    <button type="button" class="layui-btn" onclick="saveNewType()">保存</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/html" id="deleteType">
        <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon icon-display">&#xe640;</i>删除</a>
    </script>

<script>
    $(function(){
        loadTableData();
    })

    function loadTableData(){
        var familyId = <%="'"+familyMap.get("family_id")+"'"%>;
        var dataUrl = "/incomeExpendServlet?method=getAllIncomeOutcomeType&familyId="+familyId;

        layui.use('table', function(){
            var table = layui.table;

            table.on('tool(typeTable)', function(obj){
                var data = obj.data;
                if(obj.event==='del'){
                    layer.confirm('<b>确定删除此类型吗？</b><br/>删除后不影响查看此类型下的收支记录', function(index){
                        deleteType(data);
                        obj.del();
                        layer.close(index);
                    });
                }
            });

            table.render({
                elem: '#inout-type-table'
                ,width:1100
                ,cellMinWidth: 0
                ,url: dataUrl
                ,page: true
                ,cols: [[
                    {field: 'type_name', title: '类型名', width:500,align:"center"}
                    ,{field: 'type_direction', title: '类型',sort:'true', width:500,align:"center"}
                    ,{toolbar: '#deleteType',align:'center'}
                ]]
            });
        });
    }

    function showModal(){
        $("#newTypeModal").modal('show');
    }

    function hideModal(){
        $("#newTypeModal").modal('hide');
    }

    function saveNewType(){
        var data = {};
        data.typeName = $("#newTypeName").val();
        data.typeDirection = $("#newTypeSelect").val();
        if(data.typeName==""||data.typeDirection==""){
            layer.msg("请将信息输入完整");
            return;
        }
        $.ajax({
            type:'post',
            async:false,
            data:data,
            url:"/homeManageServlet?method=saveNewType",
            success:function(){
                layer.msg("保存成功");
            },
            error:function(){
                layer.msg("保存失败");
            }
        })
        hideModal();
        loadTableData();
    }

    function deleteType(obj){
        var data = {};
        data.typeId = obj.type_id;
        $.ajax({
            type:'post',
            data:data,
            async:true,
            url:'/homeManageServlet?method=deleteType',
            error:function(){
               layer.msg("删除失败");
            }
        })
    }
</script>
</body>
</html>
