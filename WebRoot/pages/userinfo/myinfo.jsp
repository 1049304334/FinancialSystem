<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String path = request.getContextPath();%>
<% HashMap userMap = (HashMap) request.getSession().getAttribute("userMap");%>
<% String userId = (String) userMap.get("id");%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div class="page-header welcome-home">
        <h1>&nbsp;&nbsp;<small>我的信息</small></h1>
    </div>
    <div class="container main-div">
        <div class="layui-form">
            <button class="layui-btn" onclick="saveEdit()"><i class="layui-icon icon-display">&#xe61d;</i>保存修改</button>
            <table class="layui-table" lay-size="lg">
                <colgroup>
                    <col width="250">
                    <col width="850">
                </colgroup>
                <tbody>
                <tr style="text-align: center">
                    <td><label>用户ID</label></td>
                    <td><input class="layui-input" id="userId" title="不可修改" disabled/></td>
                </tr>
                <tr style="text-align: center">
                    <td><label>真实姓名</label></td>
                    <td><input type="text" class="layui-input" id="trueName"/></td>
                </tr>
                <tr style="text-align: center">
                    <td><label>登录名</label></td>
                    <td><input class="layui-input" id="account" title="不可修改" disabled/></td>
                </tr>
                <tr style="text-align: center">
                    <td><label>密码</label></td>
                    <td><input type="password" class="layui-input" id="password" placeholder="点击修改密码" onclick="showPasswordModal()"/></td>
                </tr>
                <tr style="text-align: center">
                    <td><label>家庭名称</label></td>
                    <td><input class="layui-input" id="familyName" title="不可修改" disabled/></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="passwordModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>修改密码</h4>
                </div>
                <div class="modal-body">
                    <table class="base-table">

                        <tr>
                            <td><label>输入旧密码：</label></td>
                            <td colspan="3">
                                <input type="password" class="layui-input" id="oldPassword"/>
                                <input type="hidden" id="currPassword"/>
                            </td>
                        </tr>
                        <tr style="height: 16px;"></tr>
                        <tr>
                            <td><label>输入新密码：</label></td>
                            <td colspan="3"><input type="password" class="layui-input" id="newPassword"/></td>
                        </tr>
                        <tr style="height: 16px;"></tr>
                        <tr>
                            <td><label>重复新密码：</label></td>
                            <td colspan="3"><input type="password" class="layui-input" id="reNewPassword"/></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                    <button type="button" class="layui-btn" onclick="editPassword()">保存</button>
                </div>
            </div>
        </div>
    </div>

    <script>

        $(function(){
            getUserInfo();
        })

        function getUserInfo(){

            $.ajax({
                type:'post',
                url:'<%=path%>/loginServlet?method=getUserInfo',
                async:true,
                success:function(data){
                    var info = JSON.parse(data);
                    setValueToPage(info);
                },
                error:function(){
                    layer.msg('获取个人信息失败');
                }
            })
        }

        function setValueToPage(info){
            $("#userId").val(info.userId);
            $("#trueName").val(info.trueName);
            $("#account").val(info.account);
            $("#currPassword").val(info.password);
            $("#familyName").val(info.familyName);
        }

        function saveEdit(){
            var data = {};
            data.userId = $("#userId").val();
            data.trueName = $("#trueName").val();
            data.password = $("#password").val();
            if(data.password == ''){
                data.password = $("#currPassword").val();
            }
            $.ajax({
                type:'post',
                data:data,
                url:'<%=path%>/homeManageServlet?method=editMember',
                success:function(){
                    layer.msg("保存成功");
                    getUserInfo();
                },
                error:function(){
                    layer.msg("保存失败");
                }
            })
        }

        function showPasswordModal(){
            $("#passwordModal").modal('show')
        }

        function editPassword(){
            var currPassword = $("#currPassword").val();
            var oldPassword = $("#oldPassword").val();
            var newPassword = $("#newPassword").val();
            var rePassword = $("#reNewPassword").val();
            if(currPassword!=oldPassword){
                layer.alert("旧密码输入错误！");
                return;
            }
            if(newPassword==''){
                layer.alert("新密码不能为空");
                return;
            }
            if(newPassword!=rePassword){
                layer.alert("两次输入不一致！");
                return;
            }
            $("#password").val(newPassword);
            $("#passwordModal input").val("");
            $("#passwordModal").modal('hide')
        }
    </script>
</body>
</html>
