<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manageHome.aspx.cs" Inherits="manageHome" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta name="renderer" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="../Scripts/layui/css/layui.css" rel="stylesheet" />
    <link href="../plugins/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Style/theme_styles.css" rel="stylesheet" />
    <script src="../Scripts/layui/layui.js"></script>
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        a {
            text-decoration: none;
        }

            a:hover {
                text-decoration: none;
            }

            a:active {
                text-decoration: none;
            }

            a:visited {
                text-decoration: none;
            }

        .addUser {
            width: 360px;
            height: 330px;
            background-color: #ffffff;
            position: fixed;
            left: 30%;
            top: 150px;
            border-radius: 15px;
            cursor: text;
            display: none;
            z-index: 16;
        }

        #tabAdd {
            margin-left: 20px;
        }

            #tabAdd td {
                padding: 4px;
                line-height: 22px;
                border-radius: 2px;
            }

        #content-header {
            margin-bottom: 0;
            padding: 0;
        }

        #tabAdd td:nth-child(1) {
            color: rebeccapurple;
        }



        h2 {
            text-align: center;
        }

        .control {
            font-size: 10px;
            color: chocolate;
        }

        .update {
            width: 360px;
            height: 300px;
            background-color: #00ffff;
            position: fixed;
            left: 30%;
            top: 150px;
            border-radius: 15px;
            cursor: text;
            display: none;
            z-index: 3;
            border: none;
        }
        #date,#isEat{
             margin-top:8px;    
       }

        .demoTable {
            position: absolute;
            left: 450px;
            top: 140px;
            z-index: 2;
        }

        #groupList {
            position: absolute;
            left: 122px;
            top: 153px;
            z-index: 3;
            height: 26px;
        }

        .breadcrumb {
            margin: 23px;
            padding: 8px 15px;
            font-size: 16px;
        }

        #userTable {
            margin-top: 0px;
        }

        .layui-table-tool {
            z-index: 1;
        }

        span p {
            display: inline-block;
            position: absolute;
            right: 50px;
            top: 22px;
        }

        #id, #date {
            width: 230px;
        }

        .hy-title {
            height: 30px;
            font-size: 16px;
            border-bottom: 1px solid #e7ebee;
            margin: 14px 0 14px 20px;
            font-weight: bold;
        }

        .hy-title span {
            border-bottom: 4px solid #7fc8ba;
            line-height: 30px;
            padding-bottom: 3px;
            padding-right: 15px;
        }

        #layui-layer-shade10 {
            display: none;
        }

        #submit {
            display: none;
        }

        #tabadd tr td:nth-child(3) {
            color: #ff5722;
        }

        input::-webkit-input-placeholder {
            color: #c2c2c2;
        }
    </style>

    <script>

  
        var fileID = window.parent.location.search.replace('?id=', '');
        $.post("../handler/managehome.ashx", { fileID: fileID });
        var returnResult;
        function returnResult(result) {
            if (result) {
                layer.closeAll();
                layer.msg("修改成功", { icon: 1 });
                userTable();
            }
            else { layer.msg("修改失败", { icon: 0 }); }
        }


        var count;
        function userTable() {

            layui.use('table', function () {
                var table = layui.table;
                //第一个实例
                table.render({
                    elem: '#userTable'
                    , height: 'full-149'
                   
                    , url: '../Jsons/json' + fileID + '.json' //数据接口
                    , page: {
                        limit: 1000,
                        limits: [10, 20, 100, 500, 1000],
                    }
                    //开启分页
                    , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                        var result;
                        count = res.count;
                        if (this.page.curr) {
                            result = res.data.slice(this.limit * (this.page.curr - 1), this.limit * this.page.curr);
                        }
                        else {
                            result = res.data.slice(0, this.limit);
                        }
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": result //解析数据列表
                        };
                    }
                    , cols: [[ //表头
                        { type: 'radio', toolbar: '#barDemo' }
                        , { field: 'UNumber', title: '工号', width: 90, align: 'center' }
                        , { field: 'UName', title: '姓名', width: 90, align: 'center' }
                        , { field: 'USex', title: '性别', width: 80, align: 'center' }
                        , { field: 'UPhone', title: '手机号', width: 140, align: 'center' }
                        , { field: 'URole', title: '角色', width: 90, sort: true, align: 'center' }
                        , { field: 'UAddTime', title: '注册时间', width: 190, sort: true, align: 'center' }
                        , { field: 'UGroup', title: '部门', width: 120, align: 'center' }
                        , { field: 'operation', title: '操作', width: 100, align: 'center', toolbar: '#operation' }
                        , { field: 'UAmount', title: '本年度值班', width: 130, sort: true, align: 'center', templet: "<div>{{d.UAmount+'天'}}</div> " }
                    ]]
                    , toolbar: 'default'
                    , id: 'users'
                    , text: {
                        none: '未查询到记录'
                    }
                    , autoSort: true
                   
                    
                });

                table.on('toolbar(test)', function (obj) {
                    var UNumber = $(".layui-table-click td").eq(1).children("div").html();
                    switch (obj.event) {
                        case 'add':
                            $("#layui-layer-shade10").show();
                            $(".addUser").show();
                            break;
                        case 'delete':
                            if (parseInt(UNumber) == window.parent.location.search.replace('?id=', '')) {
                                layer.msg("您不能删除当前用户！");
                            } else if (isNaN(UNumber)) {
                                layer.msg("您先选择用户！");
                            } else {
                                layer.confirm('确定删除该用户？', {
                                    btn: ['确定', '取消'] //可以无限个按钮
                                }, function (index, layero) {
                                    $.post("../handler/managehome.ashx", { num: UNumber, fileID: fileID },
                                        function (data) {
                                            if (data) {
                                                layer.msg("删除成功！");
                                                userTable();
                                            } else {
                                                layer.msg("删除失败！");
                                            }
                                        });
                                });
                            }
                            break;
                        case 'update':
                            if (isNaN(UNumber)) {
                                layer.msg("请先选择用户！");
                            } else {
                                // $(".update").attr({ src: 'userUpdate.aspx?id=' + parseInt(UNumber) }).toggle();
                                layer.open({
                                    type: 2,
                                    area: ['360px', '370px'],
                                    content: 'userUpdate.aspx?id=' + parseInt(UNumber),
                                    success: function (layero, index) {
                                        var body = layer.getChildFrame('body', index);
                                        var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method(); )                                                                            
                                        body.find('#btn_close').click(function () {
                                            layer.close(index);
                                        });
                                    }
                                });

                            }
                            break;

                    };
                });
                table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data //获得当前行数据
                        , layEvent = obj.event; //获得 lay-event 对应的值
                    if (layEvent === 'edit') {
                        nameShow(data);
                    }
                });
            });
            
        }//生成表格
        userTable();
        var $html = $("<a name='myUser'></a>");
        function keydown() {          
            if (event.keyCode == 13) {            
                $("#Query").mousedown();              
            }
        }
        $(function () {
            
            $("#Query").mousedown(function () {            
                var str = $("#userQuery").val();
                for (i = 0; i < count; i++) {
                    if (str == $("td[data-field='UName']").eq(i).children("div").html() | parseInt(str) == parseInt($("td[data-field='UNumber']").eq(i).children("div").html())) {
                        $("td[data-field='UName']").eq(i).children("div").append($html);
                        $("td[data-field='UNumber']").eq(i).parent("tr").toggleClass("layui-table-hover");
                        
                        return;
                    }
                }
                if (i == count) {
                    layer.msg("无此用户");
                }
            });
            $("#Query").mouseleave(function () {
                $html.remove();
            });
           



            $("#groupList").change(function () {
                if ($("#groupList").val() != "null") {

                    $.post("../handler/manageHome.ashx", { groupList: $("#groupList").val(), fileID: fileID });

                    userTable();
                }
            });

        });

        var on_off;
        function nameShow(data) {
            layer.open({
                title: '值班添加'
                , content: '<span>工号：<p>' + data.UName + '</p><input type="number" value=' + data.UNumber + ' readonly="readonly" id="id""/></span><br/><span>日期：<input type="date" id="date" min="' + new Date().toISOString().substring(0, 10) +'"/></span><br/><span>公司就餐：<input type="checkbox" id="isEat"/></span>'
                , btn: ['提交']
                , offset: '120px'
                , yes: function () {
                    var setDate = $("#date").val();
                    var setEat = $("#isEat").prop('checked'); 
                    if (setDate == null || setDate == "") {
                        on_off = 6;
                        nameShow(data);
                    } else {
                        $.post("../Handler/managedutyshow.ashx", { setID: data.UNumber, setDate: setDate,setEat:setEat, fileID: fileID },
                            function (addResult) {
                                if (addResult == "添加成功") {
                                    $(".layui-table-click td[data-field='UAmount'] div").html((parseInt(data.UAmount) + 1) + "天");
                                    layer.msg(addResult, { icon: 1 });
                                }
                                else { layer.msg(addResult, { icon: 5 }); }
                            });
                    }
                }
                , anim: on_off
            });
            on_off = 0;
        }


        $(function () {
            $("#UNumber").keyup(function () {
                var check = /^\d{2,6}$/;
                if (check.test($(this).val())) {
                    $.post("../handler/managehome.ashx", { addNumber: $("#UNumber").val(), fileID: fileID }, function (result) {

                        if (result == "") {
                            $("#UNumber").parent().next().html("<img src='../Image/对号.jpg' width='20px'/>");
                        } else {
                            $("#UNumber").parent().next().html(result);
                        }
                    });
                } else {
                    $(this).parent().next().html("请输入2-6位工号");
                }
            });
            $("#UName").keyup(function () {
                var check = /^[\u4e00-\u9fa5]{0,}$/;
                if ($(this).val() != "" & check.test($(this).val())) {
                    $(this).parent().next().html("<img src='../Image/对号.jpg' width='20px'/>");
                } else {
                    $(this).parent().next().html("请输入中文姓名");

                }
            });
            $("#UPhone").keyup(function () {
                var check = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
                if (check.test($(this).val())) {
                    $(this).parent().next().html("<img src='../Image/对号.jpg' width='20px'/>");
                } else {
                    $(this).parent().next().html("请检查手机号");

                }
            });
            $("#addUser").click(function () {

                $("#UNumber,#UName,#UPhone").keyup();
                if (($("#tabAdd tr:nth-child(1) td:nth-child(3)").html() == $("#tabAdd tr:nth-child(2) td:nth-child(3)").html()) & ($("#tabAdd tr:nth-child(2) td:nth-child(3)").html() == $("#tabAdd tr:nth-child(4) td:nth-child(3)").html())) {
                    $.post("../handler/managehome.ashx", { addNumber: $("#UNumber").val(), addName: $("#UName").val(), addSex: $("#USex").val(), addPhone: $("#UPhone").val(), addRole: $("#URole").val(), addGroup: $("#UGroup").val(), fileID: fileID },
                        function (result) {
                            layer.msg(result);
                            $(".addUser").hide();
                            $("#layui-layer-shade10").hide();
                            userTable();
                            $("#UNumber,#UName,#UPhone").val("");
                            $("#UNumber,#UName,#UPhone").parent().next().html("");
                        });
                }
            });

            $("#off").click(function () {
                $(".addUser").hide();
                $("#UNumber,#UName,#UPhone").parent().next().html("");
                $("#layui-layer-shade10").hide();
            });

        });
        
    </script>
    <script type="text/html" id="operation">
        <a class="layui-btn layui-btn-sm" lay-event="edit">添加值班</a>
        
    </script>
</head>
<body onkeydown="keydown();">
    <form id="form1" runat="server">

        <div class="layui-layer-shade" id="layui-layer-shade10" style="z-index: 10; background-color: rgb(0, 0, 0); opacity: 0.3;"></div>
        <div id="content-header" class="clearfix">
            <div class="pull-left">
                <ol class="breadcrumb">
                    <li><a id="refresh" href="javascript:window.parent.location.reload()">主页</a></li>
                    <li class="active"><span>用户管理</span></li>
                </ol>
            </div>
        </div>

        <div class="hy-title">
            <span><i class="fa fa-cube"></i>用户管理</span>
        </div>
        <select id="groupList">
            <option>-软件工程部-</option>
            <option>车检一组</option>
            <option>车检二组</option>
            <option>车检三组</option>
            <option>环保组</option>
            <option>综合组</option>
            <option>驾考组</option>
            <option>车管业务组</option>
            <option>技术支持组</option>
        </select>
       
        <div class="demoTable">

            <span>工号/姓名</span>
            <div class="layui-inline">
                <input class="layui-input" id="userQuery" style="width: 150px" />
            </div>
            <a href="#myUser">
                <button class="layui-btn" id="Query" type="button">搜索</button></a>
        </div>
        <table id="userTable" lay-filter="test"></table>
        <iframe class="update"></iframe>

        <div class="addUser layui-anim layui-anim-scale">

            <h2>注册用户</h2>
            <table id="tabAdd">
                <tr>
                    <td>工号：</td>
                    <td>
                        <input id="UNumber" placeholder="请输入2-6位工号" type="number" />
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td>姓名：</td>
                    <td>
                        <input id="UName" type="text" placeholder="请输入中文姓名" />
                    </td>
                    <td></td>

                </tr>
                <tr>
                    <td>性别：</td>
                    <td>
                        <asp:DropDownList ID="USex" runat="server">
                            <asp:ListItem Value="男">男</asp:ListItem>
                            <asp:ListItem Value="女">女</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>手机：</td>
                    <td>
                        <input id="UPhone" type="tel" placeholder="请输入11位手机号" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>角色：</td>
                    <td>
                        <asp:DropDownList ID="URole" runat="server">
                            <asp:ListItem Value="员工">员工</asp:ListItem>
                            <asp:ListItem Value="管理员">管理员</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>部门：</td>
                    <td>
                        <asp:DropDownList ID="UGroup" runat="server">
                            <asp:ListItem Value="车检一组">车检一组</asp:ListItem>
                            <asp:ListItem Value="车检二组">车检二组</asp:ListItem>
                            <asp:ListItem Value="车检三组">车检三组</asp:ListItem>
                            <asp:ListItem Value="环保组">环保组</asp:ListItem>
                            <asp:ListItem Value="综合组">综合组</asp:ListItem>
                            <asp:ListItem Value="驾考组">驾考组</asp:ListItem>
                            <asp:ListItem Value="车管业务组">车管业务组</asp:ListItem>
                            <asp:ListItem Value="技术支持组">技术支持组</asp:ListItem>
                        </asp:DropDownList>

                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" /></td>
                    <td>
                        <input type="button" id="addUser" class="layui-btn" value="注册" />
                        <input type="button" value="取消" id="off" class="layui-btn" />
                    </td>
                </tr>

            </table>

        </div>
    </form>

</body>
</html>
