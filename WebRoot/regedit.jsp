<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册</title>
    
	<jsp:include page="/commons.jsp"></jsp:include>

  </head>
  
  <body>
    <div class="welcome-title">
  		<label>注册</label>
  	</div>
    <div class="regedit-div">
    <form method="post" id="regeditForm" action="loginServlet?method=regedit">
    	<table class="base-table">
    		<tr>
    			<td colspan="2"><label class="label-control">家庭名称：</label></td>
    			<td colspan="5"><input type="text" class="form-control" name="familyName" placeholder="请输入家庭名称"></td>
    		</tr>
    		<tr style="height:32px"></tr>
    		<tr>
    			<td colspan="2"><label class="label-control">用户名：</label></td>
    			<td colspan="5"><input type="text" class="form-control" name="userName" placeholder="请设置用户名"></td>
    		</tr>
    		<tr style="height:32px"></tr>
    		<tr>
    			<td colspan="2"><label class="label-control">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
    			<td colspan="5"><input type="password" class="form-control" name="password" placeholder="请设置密码"></td>
    		</tr>
    		<tr style="height:32px"></tr>
    		<tr>
    			<td colspan="2"><label class="label-control">再次输入密码：</label></td>
    			<td colspan="5"><input type="password" class="form-control" name="rePassword" placeholder="请重复输入密码"></td>
    		</tr>
    		<tr style="height:32px"></tr>
    		<tr>
    			<td colspan="2"><label class="label-control">真实姓名：</label></td>
    			<td colspan="5"><input type="text" class="form-control" name="realName" placeholder="请输入真实姓名"></td>
    		</tr>
    		<tr style="height:32px"></tr>
    		<tr>
    			<td colspan="2"></td>
    			<td colspan="5"><input type="button" value="注册" class="btn btn-primary login-btn" onclick="regeditCheck()"></td>
    		</tr>
    		<tr style="height:24px"></tr>
    		<tr>
    			<td colspan="2"></td>
    			<td colspan="5"><input type="reset" value="重置" class="btn btn-default login-btn"></td>
    		</tr>
    	</table>
    	</form>
    </div>

	<script>
		function regeditCheck(){

		    var familyName = $("input[name='familyName']").val();
		    var userName = $("input[name='userName']").val();
		    var password = $("input[name='password']").val();
		    var rePassword = $("input[name='rePassword']").val();
		    var realName = $("input[name='realName']").val();

		    if(familyName==""||familyName==undefined){
                layer.msg("请输入家庭名称")
				return;
			}
		    if(userName==""||userName==undefined){
                layer.msg("请输入用户名")
				return;
			}
		    if(password==""||password==undefined){
                layer.msg("请设置密码")
				return;
			}
		    if(password!=rePassword){
                layer.msg("两次输入的密码不一致")
				return;
			}
		    if(realName==""||realName==undefined){
                layer.msg("请输入家庭名称")
				return;
			}

		    var data = {};
		    data.userName=userName;
		    $.ajax({
				type:"post",
				url:"loginServlet?method=regeditCheck",
				data:data,
				async:true,
				success:function(msg){
					var flag = JSON.parse(msg);
					if(flag.status==0){
                        regedit();
					}else{
					    layer.alert("此用户名已被占用");
					}
				},
				error:function(){
					alert("error");
				}
			})
		}

		function regedit(){
		    $("#regeditForm").submit();
		}
	</script>
  </body>
</html>
