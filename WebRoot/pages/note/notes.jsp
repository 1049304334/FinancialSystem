<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% HashMap familyMap = (HashMap)session.getAttribute("familyMap");%>
<% String path = request.getContextPath();%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="page-header welcome-home">
    <h1>&nbsp;&nbsp;<small>备忘录管理</small></h1>
</div>

    <div class="container main-div">
        <table class="base-table">
            <tr style="text-align: left">
                <td colspan="5">
                    <%--<button class="layui-btn" onclick="showCreateModal()"><i class="layui-icon icon-display">&#xe654;</i>添加家庭成员</button>--%>
                </td>
            </tr>
        </table>
        <table id="notes-table" lay-filter="notesTable">

        </table>
    </div>

<!--修改备忘模态框-->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="editNoteModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>修改备忘录</h4>
            </div>
            <div class="modal-body">
                <table class="base-table">
                    <tr>
                        <td><label>提醒时间：</label></td>
                        <td colspan="3">
                            <input type="hidden" id="noteId"/>
                            <input type="text" class="layui-input" id="tipTime" placeholder="点击设置时间">
                        </td>
                        <td colspan="3"></td>
                    </tr>
                    <tr style="height:24px"></tr>
                    <tr>
                        <td><label>备忘内容：</label></td>
                        <td colspan="6">
                            <textarea class="layui-textarea" id="noteContent" style="width: 99%;" placeholder="最多128个汉字"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary" data-dismiss="modal">取消</button>
                <button type="button" class="layui-btn" onclick="editNote()">保存</button>
            </div>
        </div>
    </div>
</div>

    <!--表格菜单栏-->
    <script  type="text/html" id="noteOption">
        <a class="layui-btn layui-btn-sm" lay-event="edit"><i class="layui-icon icon-display">&#xe642;</i>修改</a>
        <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del"><i class="layui-icon icon-display">&#xe640;</i>删除</a>
    </script>

    <script>

        $(function(){
            loadTableData();
        })

        $(function(){

            layui.use('laydate', function() {
                var laydate = layui.laydate;
                var dateNow = new Date();
                var limit = dateNow.getFullYear()+'-'+(dateNow.getMonth()+1)+'-'+dateNow.getDate();

                var tipTime = laydate.render({
                    elem: '#tipTime'
                    ,type:'datetime'
                    ,min: 'limit'
                    ,ready: function(){
                        tipTime.hint('日期可选值设定在'+limit+'之后');
                    }
                });
            })
        })

        function loadTableData(){
            var familyId = <%="'"+familyMap.get("family_id")+"'"%>;
            var dataUrl = "/noteServlet?method=getAllNote&familyId="+familyId;
            layui.use('table', function(){
                var table = layui.table;

                table.on('tool(notesTable)', function(obj){
                    var data = obj.data;
                    if(obj.event==='edit'){
                        showEditModal(data);
                    }
                    if(obj.event==='del'){
                        layer.confirm('确定删除么', function(index){
                            deleteNote(data);
                            obj.del();
                            layer.close(index);
                        });
                    }
                });

                table.render({
                    elem: '#notes-table'
                    ,width:1100
                    ,cellMinWidth: 0
                    ,url: dataUrl
                    ,page: true
                    ,cols: [[
                        {field: 'note_content', title: '备忘录内容', width:600,align:"center"}
                        ,{field: 'true_name', title: '创建人',sort:'true', width:100,align:"center"}
                        ,{field: 'tip_time', title: '提醒时间',sort:'true', width:200,align:"center"}
                        ,{toolbar: '#noteOption',align:'center'}
                    ]]
                });
            });

        }

        function deleteNote(data){
            $.ajax({
                type:'post',
                data:data,
                async:true,
                url:'/noteServlet?method=deleteNote',
                success:function(){
                    layer.msg("删除成功");
                    loadTableData();
                },
                error:function(){
                    layer.msg("删除失败");
                }
            })
        }

        function showEditModal(note){
            $("#editNoteModal").modal('show');
            $("#tipTime").attr("placeholder",note.tip_time);
            $("#noteContent").val(note.note_content);
            $("#noteId").val(note.note_id);
        }

        function hideEditModal(){
            $("#editNoteModal").modal('hide');
            $("#tipTime").val("");
            $("#noteContent").val("");
            $("#noteId").val("");
        }

        function editNote(){
            var data = {};
            data.tipTime = $("#tipTime").val();
            data.noteContent = $("#noteContent").val();
            data.noteId = $("#noteId").val();
            $.ajax({
                type:'post',
                data:data,
                url:"/noteServlet?method=editNote",
                async:false,
                success:function (){
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
