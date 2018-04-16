<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<jsp:include page="/commons.jsp"></jsp:include>
	<style type="text/css">
		a:hover{
			text-decoration: none;
		}
		a:visited{
			text-decoration: none;
		}
		a:active{
			text-decoration: none;
		}
		a:link{
			text-decoration: none;
		}
	</style>
  </head>
  
  <body>
<c:out value="${userMap['true_name']}"></c:out>

  <ul class="layui-nav layui-nav-tree layui-nav-side layui-bg-cyan" lay-filter="test">
	  <!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
	  <li class="layui-nav-item">
		  <a href="javascript:;"><i class="layui-icon icon-display">&#xe612;</i>&nbsp;&nbsp;<c:out value="${userMap['true_name']}"></c:out></a>
		  <dl class="layui-nav-child">
			  <dd><a href="javascript:showMyInfo();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我的信息</a></dd>
			  <dd><a href="javascript:exitLogin();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退出登录</a></dd>
		  </dl>
	  </li>
	  <li class="layui-nav-item">
		  <a href="javascript:;"><i class="layui-icon icon-display">&#xe65e;</i>&nbsp;&nbsp;收支管理</a>
		  <dl class="layui-nav-child">
			  <dd><a href="javascript:showIncomeAndOutcome();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收支记录</a></dd>
			  <dd><a href="javascript:showIncomeExpandStatistics();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看统计</a></dd>
		  </dl>
	  </li>
	  <li class="layui-nav-item">
		  <a href="javascript:;"><i class="layui-icon icon-display">&#xe735;</i>&nbsp;&nbsp;储蓄管理</a>
		  <dl class="layui-nav-child">
			  <dd><a href="javascript:showBankOperations();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存取记录</a></dd>
			  <dd><a href="javascript:showSavingStatistics();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;储蓄统计</a></dd>
			  <dd><a href="javascript:showBankAccount();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;储蓄账户</a></dd>
		  </dl>
	  </li>
	  <li class="layui-nav-item">
		  <a href="javascript:;"><i class="layui-icon icon-display">&#xe6b2;</i>&nbsp;&nbsp;债权债务</a>
		  <dl class="layui-nav-child">
			  <dd><a href="javascript:showCreditor();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;债权管理</a></dd>
			  <dd><a href="javascript:showDebt();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;债务管理</a></dd>
			  <dd><a href="javascript:showDebtStatistics();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计</a></dd>
		  </dl>
	  </li>
	  <li class="layui-nav-item">
		  <a href="javascript:;"><i class="layui-icon icon-display">&#xe63c;</i>&nbsp;&nbsp;备忘录</a>
		  <dl class="layui-nav-child">
			  <dd><a href="javascript:showCreateNote();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新建备忘录</a></dd>
			  <dd><a href="javascript:showNotes();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看备忘录</a></dd>
		  </dl>
	  </li>
	  
	  <c:if test="${userMap['id'] == familyMap['admin_id']}">
          <li class="layui-nav-item">
			  <a href="javascript:;"><i class="layui-icon icon-display">&#xe68e;</i>&nbsp;&nbsp;家庭管理</a>
			  <dl class="layui-nav-child">
				  <dd><a href="javascript:showMemberManage();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;成员管理</a></dd>
				  <dd><a href="javascript:showInOutType();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收支类型管理</a></dd>
			  </dl>
	  	  </li>
      </c:if>
	  
  </ul>
  </body>
  <script>

      function showIncomeAndOutcome(){
          $("#mainDiv").load("<%=path%>/pages/inoutcome/incomeAndExpand.jsp");
      }

      function showInOutType(){
          $("#mainDiv").load("<%=path%>/pages/home/inouttype.jsp");
      }

      function showMemberManage(){
          $("#mainDiv").load("<%=path%>/pages/home/members.jsp");
      }

      function showCreateNote(){
          $("#mainDiv").load("<%=path%>/pages/note/createnote.jsp");
      }

      function showNotes(){
          $("#mainDiv").load("<%=path%>/pages/note/notes.jsp");
      }

      function showBankAccount(){
          $("#mainDiv").load("<%=path%>/pages/saving/bankaccount.jsp");
      }

      function showBankOperations(){
          $("#mainDiv").load("<%=path%>/pages/saving/bankoperation.jsp");
      }

      function showDebt(){
          $("#mainDiv").load("<%=path%>/pages/debt/debt.jsp");
      }

      function showCreditor(){
          $("#mainDiv").load("<%=path%>/pages/debt/creditor.jsp");
      }

      function showIncomeExpandStatistics(){
          $("#mainDiv").load("<%=path%>/pages/inoutcome/statistics.jsp");
      }

      function showSavingStatistics(){
          $("#mainDiv").load("<%=path%>/pages/saving/statistics.jsp");
      }

      function showDebtStatistics(){
          $("#mainDiv").load("<%=path%>/pages/debt/statistics.jsp");
	  }

	  function showMyInfo(){
          $("#mainDiv").load("<%=path%>/pages/userinfo/myinfo.jsp");
	  }

	  function exitLogin(){
          layer.confirm('确定退出吗？', {
              btn: ['确定','取消']
          }, function(){
              location.href = '<%=path%>/loginServlet?method=exitLogin';
          }, function(){

          });
	  }
  </script>
</html>
