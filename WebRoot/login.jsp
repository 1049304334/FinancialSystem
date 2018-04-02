<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>家庭财务管理系统</title>
    
	<jsp:include page="/commons.jsp"></jsp:include>
  </head>
  	
  <body>
  	<div class="welcome-title">
  		<label>家庭财务管理系统</label>
  	</div>
	<form action="loginServlet?method=index" method="post" id="indexForm"></form>>
    <div class="login-div">
	    <form action="loginServlet?method=loginCheck" method="post">
	    	<table class="base-table">
	    		<tr>
	    			<td><label class="label-control">用户名：</label></td>
	    			<td colspan="5"><input type="text" name="userName" class="form-control"/></td>
	    			<td><a href="regedit.jsp">注册</a></td>
	    		</tr>
	    		<tr style="height:18px">
	    		</tr>
	    		<tr>
	    			<td><label class="label-control">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
	    			<td colspan="5"><input type="password" name="password" class="form-control"/></td>
	    			<td></td>
	    		</tr>
	    		<tr style="height:18px">
	    		</tr>
	    		<tr>
	    			<td></td>
	    			<td colspan="5">
	    				<input type="button" class="btn btn-primary login-btn" value="登录" onclick="loginCheck()"/>
	    			</td>
	    			<td></td>
	    		</tr>
	    	</table>
	    </form>
    </div>
  		<script>
			function loginCheck(){
			    var userName = $("input[name='userName']").val();
			    var password = $("input[name='password']").val();
				var data = {};
				data.userName = userName;
				data.password = password;

				$.ajax({
					type:"post",
					url:"loginServlet?method=loginCheck",
					data:data,
					async:false,
					success:function(msg){
					    var info = JSON.parse(msg)
						if(info.res=="fail"){
						    layer.msg("用户名或密码错误");
						    return;
						}else if (info.res=="success"){
							$("#indexForm").submit();
						}
					},
					error:function(msg){
					    alert("请求失败！");
					}
				})
			}
		</script>
  </body>
</html>
