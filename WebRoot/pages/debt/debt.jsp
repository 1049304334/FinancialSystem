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
    <h1>&nbsp;&nbsp;<small>债务管理</small></h1>
</div>

<div class="container main-div">
    <table class="base-table">
        <tr style="text-align: left">
            <td colspan="5">
                <button class="layui-btn" onclick="showCreateModal()"><i class="layui-icon icon-display">&#xe654;</i>添加家庭成员</button>
            </td>
        </tr>
    </table>
    <table id="member-table" lay-filter="memberTable">

    </table>
</div>

<!-- 新建家庭成员模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="newMemberModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>添加家庭成员</h4>
            </div>
            <div class="modal-body">
                <table class="base-table">
                    <tr>
                        <td><label>真实姓名：</label></td>
                        <td colspan="6"><input type="text" id="trueName" class="form-control" placeholder="请设置真实姓名"/></td>
                    </tr>
                    <tr style="height: 16px"></tr>
                    <tr>
                        <td><label>登录名：</label></td>
                        <td colspan="6"><input type="text" id="userName" class="form-control" placeholder="注册后不可修改"/></td>
                    </tr>
                    <tr style="height: 16px"></tr>
                    <tr>
                        <td><label>密码：</label></td>
                        <td colspan="6"><input type="password" id="password" class="form-control"/></td>
                    </tr>
                    <tr style="height: 16px"></tr>
                    <tr>
                        <td><label>重复密码：</label></td>
                        <td colspan="6"><input type="password" id="repassword" class="form-control"/></td>
                    </tr>
                    <tr style="height: 16px"></tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                <button type="button" class="layui-btn" onclick="saveNewMember()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑家庭成员模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="editMemberModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>修改家庭成员信息</h4>
            </div>
            <div class="modal-body">
                <table class="base-table">
                    <tr>
                        <td><label>真实姓名：</label></td>
                        <td colspan="6">
                            <input type="text" id="editTrueName" class="form-control"/>
                            <input type="hidden" id="userId"/>
                        </td>
                    </tr>
                    <tr style="height: 16px"></tr>
                    <tr>
                        <td><label>登录名：</label></td>
                        <td colspan="6"><input type="text" id="editUserName" class="form-control" disabled/></td>
                    </tr>
                    <tr style="height: 16px"></tr>
                    <tr>
                        <td><label>密码：</label></td>
                        <td colspan="6"><input type="password" id="editPassword" class="form-control"/></td>
                    </tr>
                    <tr style="height: 16px"></tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                <button type="button" class="layui-btn" onclick="saveEdit()">保存</button>
            </div>
        </div>
    </div>
</div>



<script type="text/html" id="updateMember">
    <a class="layui-btn layui-btn-sm" lay-event="edit"><i class="layui-icon icon-display">&#xe642;</i>修改</a>
</script>

<script>
    $(function(){
        loadTableData();
    })

    function loadTableData(){
        var familyId = <%="'"+familyMap.get("family_id")+"'"%>;
        var dataUrl = "/homeManageServlet?method=getAllMembers&familyId="+familyId;

        layui.use('table', function(){
            var table = layui.table;

            table.on('tool(memberTable)', function(obj){
                var data = obj.data;
                if(obj.event==='edit'){
                    showEditModal(data);
                }
            });

            table.render({
                elem: '#member-table'
                ,width:1100
                ,cellMinWidth: 0
                ,url: dataUrl
                ,page: true
                ,cols: [[
                    {field: 'true_name', title: '真实名称', width:500,align:"center"}
                    ,{field: 'user_name', title: '登录名',sort:'true', width:500,align:"center"}
                    ,{toolbar: '#updateMember',align:'center'}
                ]]
            });
        });

    }
    function showCreateModal(){
        $("#newMemberModal").modal('show');
    }

    function hideCreateModal(){
        $("#newMemberModal").modal('hide');
    }

    function saveNewMember(){
        var data = {};
        data.trueName = $("#trueName").val();
        data.userName = $("#userName").val();
        data.password = $("#password").val();
        data.repassword = $("#repassword").val();
        if(data.trueName==""||data.userName==""||data.password==""){
            layer.msg("请将信息输入完整");
            return;
        }
        if(data.password!=data.repassword){
            layer.msg("两次输入的密码不一致！");
            return;
        }
        $.ajax({
            type:'post',
            async:false,
            data:data,
            url:"/homeManageServlet?method=createNewMember",
            success:function(msg){
                var status = JSON.parse(msg);
                if(status.res=='0'){
                    layer.alert("此登录名已被占用");
                }else{
                    layer.msg("已保存");
                    hideCreateModal();
                    loadTableData();
                    resetModalVal();
                }
            },
            error:function(){
                layer.msg("保存失败");
            }
        })
    }

    function resetModalVal(){
        $("#trueName").val("");
        $("#userName").val("");
        $("#password").val("");
        $("#repassword").val("");
    }

    function showEditModal(data){
        $("#editMemberModal").modal('show');
        $("#userId").val(data.id);
        $("#editTrueName").val(data.true_name);
        $("#editUserName").val(data.user_name);
        $("#editPassword").val(data.password);
    }

    function hideEditModal(){
        $("#editMemberModal").modal('hide');
    }

    function saveEdit(){
        var data = {};
        data.userId = $("#userId").val();
        data.trueName = $("#editTrueName").val()
        data.password = $("#editPassword").val();

        $.ajax({
            type:'post',
            url:"/homeManageServlet?method=editMember",
            data:data,
            async:true,
            success:function(){
                layer.msg("修改成功");
                hideEditModal();
                loadTableData();
            },
            error:function(){
                layer.msg("修改失败");
            }

        })
    }

</script>
</body>
</html>
