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
  	
  <body background="img/bg.jpg">
  	<div class="welcome-title">
  		<label style="color: #009688">家庭财务管理系统</label>
  	</div>
	<form action="loginServlet?method=index" method="post" id="indexForm"></form>
    <div class="login-div">
	    <form action="loginServlet?method=loginCheck" method="post">
	    	<table class="base-table">
	    		<tr>
	    			<td><label class="label-control">用户名：</label></td>
	    			<td colspan="5"><input type="text" name="userName" class="layui-input"/></td>
	    			<td><a href="regedit.jsp">注册</a></td>
	    		</tr>
	    		<tr style="height:18px">
	    		</tr>
	    		<tr>
	    			<td><label class="label-control">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
	    			<td colspan="5"><input type="password" name="password" class="layui-input"/></td>
	    			<td></td>
	    		</tr>
	    		<tr style="height:18px">
	    		</tr>
				<tr>
					<td><label class="label-control">验证码：</label></td>
					<td colspan="2"><input type="text" id="veriCode" class="layui-input"/></td>
					<td colspan="4"><img id="codeImg" src="<%=path%>/loginServlet?method=generateVerificationCode" onclick="changeCode()"/></td>
				</tr>
				<tr style="height:18px">
				</tr>
	    		<tr>
	    			<td></td>
	    			<td colspan="5">
	    				<input type="button" class="layui-btn login-btn" value="登录" onclick="loginCheck()"/>
	    			</td>
	    			<td></td>
	    		</tr>
	    	</table>
	    </form>
    </div>
  		<script>

            $(document).keydown(function(event){
                if(event.keyCode == 13){
                    loginCheck();
                    }
                });

			function loginCheck(){
			    var userName = $("input[name='userName']").val();
			    var password = $("input[name='password']").val();
			    var veriCode = $("#veriCode").val();
			    if(userName==""){
			        layer.msg("请输入用户名");
			        return;
				}
                if(password==""){
                    layer.msg("请输入密码");
                    return;
                }
                if(veriCode==""){
                    layer.msg("请输入验证码");
                    return;
                }
				var data = {};
				data.userName = userName;
				data.password = password;
				data.veriCode = veriCode;
				$.ajax({
					type:"post",
					url:"<%=path%>/loginServlet?method=loginCheck",
					data:data,
					async:false,
					success:function(msg){
					    var info = JSON.parse(msg)
						if(info.res=="fail"){
						    layer.msg("用户名或密码错误");
						    return;
						}else if(info.res=="1"){
						    layer.alert("验证码错误");
                            $("#veriCode").val("");
                            changeCode();
						}else{
                            $("#indexForm").submit();
                        }
					},
					error:function(msg){
					    alert("请求失败！");
					}
				})
			}

			function changeCode(){
				var date = new Date();
				var time = date.getTime() ;
				$("#codeImg")[0].src = "<%=path%>/loginServlet?method=generateVerificationCode&time="+time;
            }
		</script>
  </body>
</html>
