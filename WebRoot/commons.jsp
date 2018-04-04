<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'commons.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	  <link rel="stylesheet" type="text/css" href="layui/css/layui.css">
	  <link rel="stylesheet" type="text/css" href="css/style.css">
	  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	  <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.css">
	  <link rel="stylesheet" type="text/css" href="css/datatables.min.css">

	<script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
    <script type="text/javascript" src="js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	<script type="text/javascript" src="layui/layui.js"></script>
	<script type="text/javascript" src="js/datatables.min.js"></script>
	<script type="text/javascript" src="js/echarts.js"></script>

  </head>
  
  <body>
  </body>
</html>
