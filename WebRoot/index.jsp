<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% HashMap familyMap = (HashMap)session.getAttribute("familyMap");%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>家庭财务管理系统</title>
      <jsp:include page="/menu.jsp"></jsp:include>
  </head>

  <body>
        <div class="main-div" id="mainDiv">

        </div>
  <script>

        /*自动提示备忘录：
        *   在index加载完成后，使用setInterval,每5秒向服务器请求是否有三十分钟内到期的备忘录
        *   若有即将到期的备忘录，则在右下角弹窗提醒，并将该备忘录保存入noteArr数组
        *   在下次查询到有即将到期的备忘录后，检查该备忘录是否已保存在noteArr中，
        *   若已保存，则代表此条信息之前已提醒，不再弹窗提醒。
        *   *刷新页面会导致noteArr被重置，所有即将到期的备忘录会再次弹窗
        **/

        var noteArr = [];

        layui.use(['element','laydate','table'], function(){
            var element = layui.element;
        });

        $(function(){
            $("#mainDiv").load("<%=path%>/homePage.jsp");
        })

        function getNoteTips(){

            var familyId = <%="'"+familyMap.get("family_id")+"'"%>;

            var timeStamp = new Date().getTime();
            var tipStamp = new Date(timeStamp+1800000);
            var tipTime = tipStamp.getFullYear()+'-'+(tipStamp.getMonth()+1)+'-'+tipStamp.getDate()+' '+tipStamp.getHours()+':'+tipStamp.getMinutes()+':'+tipStamp.getSeconds();
            var data = {};
            data.tipTime = tipTime;
            data.familyId = familyId;
            $.ajax({
                type:'post',
                data:data,
                async:true,
                url:'<%=path%>/noteServlet?method=getNoteTip',
                success:function(res){
                    var info = JSON.parse(res);
                    if(info.notes.length > 0){
                        showTip(info);
                    }
                },
                error:function(){
                    layer.msg("获取备忘录信息失败！");
                }
            })
        }

        /**
         * 检查接收到的备忘信息是否已提醒
         * @param info
         */
        function checkTips(note){
            var tipedNum = noteArr.length;
            for(var i=0;i<tipedNum;i++){
                if(note.note_id == noteArr[i].note_id){
                    return false;
                }else{
                    continue;
                }
            }
            return true;
        }

        /**
         * 右下iframe窗显示提示
         * @param info
         */
        function showTip(info){

            for(var i=0;i<info.notes.length;i++){
                if(checkTips(info.notes[i])){
                    //显示提示
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 1, //不显示关闭按钮
                        shade: [0],
                        area: ['340px', '215px'],
                        offset: 'rb', //右下角弹出
                        time: 60000, //10分钟后自动关闭
                        anim: 2,
                        content: ['<%=path%>/notetip.html', 'no']
                    });
                    noteArr.push(info.notes[i]);
                }
            }
        }

        //每5秒请求一次
        $(function(){
           // setInterval("getNoteTips()",5000)
        })

  </script>
  </body>
</html>
