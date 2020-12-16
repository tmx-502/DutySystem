<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manageDutyShow.aspx.cs" Inherits="manageDutyShow" %>

<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Windows" %>
<%@ Import Namespace="System.Windows.Forms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
  <meta name="renderer" content="webkit"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

    <link href="../plugins/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Style/theme_styles.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <script src="../Scripts/layui/layui.js"></script>
    <link href="../Scripts/layui/css/layui.css" rel="stylesheet" />
    <script src="../Scripts/FileSaver.js"></script>
    <script src="../Scripts/jquery.wordexport.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/clipboard@2.0.6/dist/clipboard.min.js"></script>
    <style>
        body { 
 -webkit-font-smoothing: antialiased;
 -moz-osx-font-smoothing: grayscale; 
} 
        .breadcrumb {
            margin: 23px;
            padding: 8px 15px;
            font-size: 16px;
        }

        .dutyList {
            margin-left: 30px;
        }

        .demoTable {
            position: absolute;
            left: 450px;
            top: 140px;
            z-index: 2;
        }

        .dutyList td {
            border: 1px solid black;
            text-align: center;
            width: 100px;
        }

        .dutyList tr:nth-child(-n+3) {
            font-weight: 700;
        }

        #date, #number, #name {
            width: 230px;
            border: 1px solid blue;
        }

        #Button1, #Button2, #Button6 {
            color: #808080;
            width: 60px;
        }

        #Button5 {
            border: none;
        }

        .tdBg {
            background-color: #efefef;
        }

        #content-header {
            margin-bottom: 0;
            padding: 0;
        }

        .hy-title {
            height: 30px;
            font-size: 16px;
            border-bottom: 1px solid #e7ebee;
            margin: 15px 0 15px 20px;
            font-weight: bold;
        }

            .hy-title span {
                border-bottom: 4px solid #7fc8ba;
                line-height: 30px;
                padding-bottom: 3px;
                padding-right: 15px;
            }



        .layui-table-tool {
            z-index: 1;
        }
        #dutyQuery1{
            display:none;
        }
         #dutyQuery, #dutyQuery1{
            width:190px;
        }

        #id, #date {
            width: 230px;
        }

        span p {
            display: inline-block;
            position: absolute;
            right: 50px;
            top: 22px;
        }

        .selectList {
            height: 36px;
        }    
     
        .word table{
            margin:auto;      
            text-align:center;
            line-height: 28px;
            font-size:16px;
        }
        .word table td:first-child{
            width:70px;
            line-height: 28px;
        }
        .word table td:last-child{
            min-width:250px
        }
              
         
         #group li{
             cursor:context-menu;          
         }
         #nameList li{
             cursor:grab;          
         }
        #menu ul{
            display: none;
            border: 1px solid black;
            width:100px;          
            float:left;
            margin-left:43px;
            margin-top:-65px;
            z-index:11;
            background-color:#F0F0F0;
            color:#01AAED;
        }       
       #nameList ul{         
         margin-left:0px;        
       }
       .menu_date{
           float:left;
           z-index:10;                        
       }
       #date,#isEat{
             margin-top:8px;    
       }
       #getName{
           width:230px;
           
       }      
        #groupList {
            position: absolute;
            left: 90px;
            top: 150px;
            z-index: 3;
            height: 26px;
            display:none;
        }
    </style>
    <script>
        var fileID = window.parent.location.search.replace('?id=', '');      
        $(function () {
            $(".dutyList tr:nth-child(n+5)").hover(function () {
                $(this).addClass("tdBg");
            }, function () {
                $(this).removeClass("tdBg");

            });
            if (window.location.search.split('?r=')[0].replace('?id=', '') == "")  $("#groupList").show();                   
        });

        var on_off;
        var tips = "";
        function nameShow() {
            
            var $htmlStr = '<span>工号：<p>' + tips + '</p><input type="number" id="id" oninput="javaScript:getName();"/></span><br/><span>日期：<input type="date" id="date"  min="' + new Date().toISOString().substring(0, 10) + '" /></span><br/><span>公司就餐：<input type="checkbox" id="isEat"/></span>';
            if (window.location.search.split('?r=')[0].replace('?id=', '') == "") {
                $htmlStr = $("#getGroup").html();
            }
            layer.open({
                title: '值班添加'
                , content: $htmlStr
                , offset: '120px'
                , btn: ['提交']
                , yes: function () {
                    var setID = $("#id").val();
                    var setDate = $("#date").val();
                    var setEat = $("#isEat").prop('checked');                  
                    if (window.location.search.split('?r=')[0].replace('?id=', '') == "") {
                        setID = $("#getName").val().replace(/[^0-9]/ig, "");                        
                    }
                    if (setID == "" ) {
                        layer.tips("姓名不能为空", "#getName");
                        return false;
                    } else if (setDate == "") {
                        layer.tips("日期不能为空", "#date");
                        return false;
                    }
                    else {
                        $.post("../Handler/managedutyshow.ashx", { setID: setID, setDate: setDate, setEat: setEat, fileID: fileID },
                            function (addResult) {
                                if (addResult == "添加成功") {
                                    dutyTable();
                                    layer.msg(addResult, { icon: 1 });
                                }
                                else {
                                    layer.msg(addResult, { icon: 5 });
                                    return false;
                                }
                            });
                    }
                }
                , anim: on_off
                , success: function (layero, index) {
                   
                    var mask = $(".layui-layer-shade");
                    mask.appendTo(layero.parent());
            <% string path = HttpContext.Current.Server.MapPath("/Jsons") + "\\data.json";
        System.IO.File.WriteAllText(path, DS.BLL.User.GetUsersJson(), Encoding.UTF8);%>
                        $.getJSON("../Jsons/data.json", function (data) {
                            $("#group").children().each(function () { $("#nameList").append("<ul class=" + this.id + "></ul>"); });
                            $.each(data.data, function (key, value) {
                                $("#group").children().each(function () {
                                    if (value.UGroup == $(this).html()) {
                                        $("." + this.id + "").append("<li onclick='javascript:cli(event);' >" + value.UName + " - " + value.UNumber +"</li");
                                    }
                                });
                            });
                        });

                        $("#getName").click(function () {
                            $("#group").show();
                        });
                    $("#group>li").mouseover(function () {
                        $(this).css("background-color", "#c2c2c2").siblings().css("background-color","#F0F0F0")
                            $("." + this.id + "").show().siblings().hide();
                        });                   
                    
                }
            });
            on_off = 0;
            tips = "";
                if (window.location.search.split('?r=')[0].replace('?id=', '') != "") {
                    $("#id").attr({ "value": parseInt(window.location.search.split('?r=')[0].replace('?id=', '')), "readonly": "readonly" });
                getName();
            }
        }
        function getName() {
            var checkID = $("#id").val();
            $.post("../Handler/manageDutyshow.ashx", { checkID: checkID },
                function (getName) {
                    $("span p").text(getName);
                });
        }


        function dutyTable() {
            var dutyData;
            layui.use('table', function () {
                var table = layui.table;
                table.render({
                    elem: '#dutyTable'
                    , height:'full-149'
                    , url: '../Jsons/json' + fileID + '.json' //数据接口
                    , page: {
                        limit: 1000,
                        limits: [100, 1000],
                    }
                    , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                        var result;
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
                    , cols: [[
                        { type: 'checkbox' }
                        , { field: 'UNumber', title: '工号', width: 90, sort: true, align: 'center' }
                        , { field: 'UName', title: '姓名', width: 90, align: 'center' }
                        , { field: 'DutyTime', title: '值班时间', width: 130, sort: true, align: 'center', templet: "<div>{{layui.util.toDateString(d.DutyTime, 'yyyy-MM-dd')}}</div> " }
                        , { field: 'IsWeekend', title: '出勤类型', width: 110, align: 'center' }
                        , { field: 'UGroup', title: '部门', width: 120, align: 'center' }
                        , {
                            field: 'IsEat', title: '公司就餐', width: 100, align: 'center', hide: true, templet: function (d) {
                                if (
                                    $.trim(d.IsEat)== "True") { return "是"; } else { return "否"; }
                            }
                        }
                    ]]
                    , toolbar: 'default'
                    , id: 'dutys'
                    , text: {
                        none: '未查询到记录'
                    }
                    , done: function (res, curr, count) { 
                        
                        $("div[lay-event='update']").remove();
                        var data = res.data;
                        dutyData = res.data;
                        for (var i = 0; i < data.length; i++) {
                            if ((new Date().getTime() - new Date(data[i].DutyTime).getTime()) >= 1000 * 60 * 60 * 24 * 7) {
                                $(".layui-table-header").find("input[name = 'layTableCheckbox'][lay-filter='layTableAllChoose']").each(function () {

                                    $(this).attr("disabled", 'disabled').next().removeClass("layui-form-checked");
                                    $(this).parent().click(function () {
                                        layer.tips("存在过期值班", this);
                                    })
                                    layui.form.render('checkbox');

                                });
                            }
                        }
                        var i = 0;
                        $(".layui-table-body.layui-table-main").find("input[name='layTableCheckbox']").each(function () {
                            if ((new Date().getTime() - new Date(data[i].DutyTime).getTime()) >= 1000 * 60 * 60 * 24 * 7) {
                                $(this).attr({ disabled: 'disabled' });
                                $(this).parent().click(function () {
                                    layer.tips("该值班已过期超过7天",this);
                                })
                                
                                layui.form.render('checkbox');
                            }
                            i++;
                        });
                       

                    }

                });
                
                 
                table.on('toolbar(test)', function (obj) {
                    switch (obj.event) {
                        case 'add':
                            nameShow();
                            break;
                        case 'delete':
                            if (table.checkStatus("dutys").data.length == 0) {
                                layer.msg("请选择值班项！");
                            } else {
                                layer.confirm('确定删除该值班项？', {
                                    btn: ['确定', '取消'] //可以无限个按钮
                                }, function (index, layero) {
                                    for (var i = 0; i < table.checkStatus("dutys").data.length; i++) {
                                        $.post("../Handler/manageDutyshow.ashx", { deleteID: table.checkStatus("dutys").data[i].UNumber, deleteDate: table.checkStatus("dutys").data[i].DutyTime, fileID: fileID },
                                            function (deleteResult) {
                                                if (deleteResult) {
                                                    layer.msg("删除成功");
                                                    $(".layui-form-checked").parents("tr").remove();
                                                } else { layer.msg("删除失败"); }
                                            });
                                    }
                                    return false;

                                });
                            }
                            break;
                        case 'update':
                            break;
                        case 'LAYTABLE_EXPORT':
                           
                            if (window.location.search.split('?r=')[0].replace('?id=', '') == "") {

                                $(".layui-table-tool-panel").append("<li data-type='showTable'>预览当前值班表</li>");
                                if (dutyData.length == 0) {
                                    layer.msg("当前无值班数据，换个条件试试！", { icon: 0 });
                                    return false;
                                }
                                /*$("li[data-type='docx']").click(function () {
                                    $(".word h2").append("软件工程部" + dutyData[dutyData.length - 1].DutyTime.substring(0, 10) + "-" + dutyData[0].DutyTime.substring(0, 10) + "值班安排");
                                    for (i = 0; i < dutyData.length; i++) {
                                        if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "车检一组") $("#word .word table tr:nth-child(1) td:nth-child(3)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "车检二组") $(".word table tr:nth-child(2) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "车检三组") $(".word table tr:nth-child(3) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "环保组") $(".word table tr:nth-child(4) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "驾考组") $(".word table tr:nth-child(5) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "车检一组") $(".word table tr:nth-child(6) td:nth-child(3)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "车检二组") $(".word table tr:nth-child(7) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "车检三组") $(".word table tr:nth-child(8) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "环保组") $(".word table tr:nth-child(9) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                        if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "驾考组") $(".word table tr:nth-child(10) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                    }
                                    var $tab = $('#word').html();
                                    $(".word").wordExport("软件部" + dutyData[dutyData.length - 1].DutyTime.substring(5, 10) + "-" + dutyData[0].DutyTime.substring(5, 10) + "值班表");
                                    $(".word table td:last-child").empty();
                                    $(".word h2").empty();
                                });*/
                                
                                $("li[data-type='showTable']").click(function () {
                                    layer.open({
                                        title: "软件工程部" + dutyData[dutyData.length - 1].DutyTime.substring(0, 10) + "-" + dutyData[0].DutyTime.substring(0, 10) + "值班安排"
                                        ,type: 0
                                        , anim: 2
                                        , area: '450px'
                                        , skin: "layui-layer-lan"
                                        , content: $("#word").html()
                                        , success: function (layero, index) {
                                            var total1=0;
                                            var total2=0;
                                            for (i = 0; i < dutyData.length; i++) {
                                                if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "车检一组") $(".word table tr:nth-child(1) td:nth-child(3)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "车检二组") $(".word table tr:nth-child(2) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "车检三组") $(".word table tr:nth-child(3) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期六" && dutyData[i].UGroup.trim() == "环保组") $(".word table tr:nth-child(4) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "车检一组") $(".word table tr:nth-child(5) td:nth-child(3)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "车检二组") $(".word table tr:nth-child(6) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "车检三组") $(".word table tr:nth-child(7) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期天" && dutyData[i].UGroup.trim() == "环保组") $(".word table tr:nth-child(8) td:nth-child(2)").append(dutyData[i].UName + "&nbsp;");
                                                if (dutyData[i].IsWeekend == "星期六" && dutyData[i].IsEat.trim()=="True") total1 = total1 + 1;
                                                if (dutyData[i].IsWeekend == "星期天" && dutyData[i].IsEat.trim()=="True") total2 = total2 + 1;
                                                 
                                               
                                            }
                                            $(".word table tr:nth-child(9) td:nth-child(1)").append("就餐统计：周六 "+total1+"人、周日"+total2+"人");
                                        }
                                        , btn: ['关闭窗口']
                                        
                                    });
                                });                                                                
                            }
                            break;
                    };

                });

            });


        }
        dutyTable();
       
        function checkQuery() {
            if ($(".selectList").val() == "1") {
                $("#dutyQuery1").hide();
                $("#dutyQuery1").val(null);
                $("#dutyQuery").show();            
            } else {             
                $("#dutyQuery").hide();
                $("#dutyQuery1").show();
            }
                                };

                                

        $(function () { 
            var QueryData1 = window.location.search.split('?r=')[0].replace('?id=', '');

            if (QueryData1 != "") {
                $.post("../Handler/manageDutyshow.ashx", { QueryData1: QueryData1, fileID: fileID },
                    function (str) {
                        dutyTable();
                        if (str != "") layer.msg(str);
                        $(".demoTable").html(null);
                        $(".active").html("值班查看");
                        $(".hy-title span span").html("历史值班");
                        return false;
                    });
            } else {
                $(".demoTable").html($("#str1").html());              
                var myDate = new Date;
                myDate.setDate(myDate.getDate() + (6 - myDate.getDay()));                  
                var value = myDate.getFullYear() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate() + " ~ ";
                var year = myDate.getFullYear();
                var mouth = myDate.getMonth() + 1;
                var date = myDate.getDate();
                layui.use('laydate', function () {
                    var laydate = layui.laydate;                   
                    if (laydate.getEndDate() == date) {
                        mouth = mouth + 1;
                        date = 1;
                    } else {
                        date = date + 1;
                    }
                    if (mouth == 13) {
                        year = year + 1;
                        mouth = 1;
                    }
                    value = value + year + "-" + mouth + "-" + date;
                    laydate.render({
                        elem: '#dutyQuery' //指定元素
                        , range: '~'
                        , calendar: true
                        , value: value
                        , btns: ['confirm']
                    });
                    laydate.render({
                        elem: '#date' //指定元素
                        
                        , calendar: true
                        
                        , btns: ['confirm']
                    });
                    
                    $.post("../Handler/manageDutyshow.ashx", { QueryData: value, Querygroup: $("#groupList").val(), fileID: fileID });
                    dutyTable();
                });                              
            }
        });
        function query() {
            var QueryData = $("#dutyQuery").val();
            var QueryData1 = $("#dutyQuery1").val();
            var Querygroup = $("#groupList").val();         
            if ($(".selectList").val() == "1") {
                $.post("../Handler/manageDutyshow.ashx", { QueryData: QueryData, Querygroup: Querygroup, fileID: fileID },
                    function (str) {
                        if (str != "") layer.msg(str);
                        dutyTable();
                        return false;
                    });
            } else {               
                $.post("../Handler/manageDutyshow.ashx", { QueryData1: QueryData1, Querygroup: Querygroup, fileID: fileID },
                    function (str) {
                        if (str != "") layer.msg(str);
                        dutyTable();
                        return false;
                    });
            }
           
        };

        //值班添加获取用户
        function cli(event) {
            $("#getName").val($(event.target).html());
            $("#menu ul").hide();
        };
        
        $(function () {
            $("#dutyQuery1").keyup(function () {
                $("#groupList").val("-软件工程部-");
            });
        });
        
        
    </script>
    <script type="text/html" id="str1">     
        <select class='selectList' oninput='javaScript: checkQuery();'>
            <option value='1'>值班日期:</option>
            <option value='2'>姓名/工号:</option>
            </select >
            <div class='layui-inline'>
                 <input type="text" class="layui-input" id="dutyQuery"/>
                 <input type="text" class="layui-input" id="dutyQuery1"/>
            </div>
            <button class='layui-btn' id='Query' type='button' onclick='javascript:query();'>搜索</button>
    </script>


    <script id="getGroup" type="text/html">
            <div id="menu" class="layui-anim layui-anim-fadein">
                <span>姓名：<input id="getName" readonly="readonly" /></span>
                
                <span class="menu_date">日期：<input type="date" id="date" min="<%=DateTime.Now.ToString("yyyy-MM-dd")%>"/>
                    <br /> 公司就餐：<input type="checkbox" id="isEat"/>
                </span>
                
                <div>                   
                    <ul id="group">
                        <li id="cjyz">车检一组</li>
                        <li id="cjez">车检二组</li>
                        <li id="cjsz">车检三组</li>
                        <li id="hbz">环保组</li>
                        <li id="zhz">综合组</li>
                        <li id="jkz">驾考组</li>
                        <li id="zgywz">车管业务组</li>
                        <li id="jszcz">技术支持组</li>
                    </ul>
                    <div id="nameList"></div>
                </div>
            </div>
        </script>
    <script id="word" type="text/html">
            <div class="word">         
            <table border="1" >
                <tr>
                    <td rowspan="4">星期六</td>
                    <td>一组</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>二组</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>三组</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>环保组</td>
                    <td>&nbsp;</td>
                </tr>
                
                <tr>
                    <td rowspan="4">星期天</td>
                    <td>一组</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>

                    <td>二组</td>
                    <td>&nbsp;</td>
                </tr>
                <tr >
                    <td>三组</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>环保组</td>
                    <td>&nbsp;</td>
                </tr>               
                <tr><td colspan="3"></td></tr>
            </table>
                
                <div style="text-align:right;font-size:13px;margin-bottom:-15px">tips:推荐使用Ctrl+Shift+A截取表格！</div>
            </div>
        </script>
</head>
<body >
    <h2 style="text-align: center"></h2>
    <form id="form1" runat="server">
        <div id="content-header" class="clearfix">
            <div class="pull-left">
                <ol class="breadcrumb">
                    <li><a id="refresh" href="javascript:window.parent.location.reload()">主页</a></li>
                    <li class="active"><span>值班管理</span></li>
                </ol>
            </div>
        </div>
        <div>

            <div class="hy-title">
                <span><i class="fa fa-cube"></i><span>值班管理</span></></span>
            </div>
            <div style="float: right">
            </div>
            <div>
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
                <div class="demoTable"> <%--值班检索--%>
                </div>

                <table id="dutyTable" lay-filter="test"></table>

            </div>
        </div>
        
        
        
    </form>
</body>
</html>
       