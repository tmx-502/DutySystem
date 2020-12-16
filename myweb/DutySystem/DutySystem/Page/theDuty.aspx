<%@ Page Language="C#" AutoEventWireup="true" CodeFile="theDuty.aspx.cs" Inherits="Page_theDuty" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link href="../plugins/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Style/theme_styles.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.5.1.js"></script>
    <script src="../Scripts/layui/layui.js"></script>
    <link href="../Scripts/layui/css/layui.css" rel="stylesheet" />

    <style>
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

        #date, #isEat {
            margin-top: 8px;
        }
    </style>
    <script>

        var fileID = window.parent.location.search.replace('?id=', '');
        
        function dutyTable() {
            var dutyData;
            layui.use('table', function () {
                var table = layui.table;
                table.render({
                    elem: '#dutyTable'
                    , height: 'full-149'
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
                        , { field: 'UNumber', title: '工号', width: 80, align: 'center' }
                        , { field: 'UName', title: '姓名', width: 90, align: 'center' }
                        , { field: 'DutyTime', title: '值班时间', width: 120, sort: true, align: 'center', templet: "<div>{{layui.util.toDateString(d.DutyTime, 'yyyy-MM-dd')}}</div> " }
                        , { field: 'IsWeekend', title: '出勤类型', width: 100, align: 'center' }
                        , { field: 'UGroup', title: '部门', width: 120, align: 'center' }
                        , { field: 'IsEat', title: '公司就餐', width: 100, align: 'center', templet: function (d) { if (d.IsEat.trim() === "True") { return "是"; } else { return "否"; } } }
                    ]]
                    , id: 'dutys'
                    , text: {
                        none: '未查询到记录'
                    }
                    , toolbar: 'default'
                    , defaultToolbar: ['', '', '']
                    , done: function (res, curr, count) {
                        var data = res.data;
                        dutyData = res.data;
                        for (var i = 0; i < data.length; i++) {
                            if (parseInt(data[i].UNumber) != parseInt(fileID)) {
                                $(".layui-table-header").find("input[name = 'layTableCheckbox'][lay-filter='layTableAllChoose']").each(function () {

                                    $(this).attr("disabled", 'disabled').next().removeClass("layui-form-checked");
                                    $(this).parent().click(function () {
                                        layer.tips("当前不可选全选", this);
                                    })
                                    layui.form.render('checkbox');

                                });
                            }
                        }
                        var i = 0;

                        $(".layui-table-body.layui-table-main").find("input[name='layTableCheckbox']").each(function () {
                            if (parseInt(data[i].UNumber) != parseInt(fileID)) {
                                $(this).attr({ disabled: 'disabled' });
                                $(this).parent().click(function () {
                                    layer.tips("仅可操作本人值班信息", this);
                                })
                                layui.form.render('checkbox');
                            }
                            i++;
                        });
                        $("div[lay-event='update']").remove();
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
                                    btn: ['确定', '取消']
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
                    };
                });
            });


        }

        function readTable() {
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
                value +=year + "-" + mouth + "-" + date;
                console.log(value);
                $.post("../Handler/manageDutyshow.ashx", { QueryData: value, Querygroup: "-软件工程部-", fileID: fileID });
                dutyTable();
            });

        };
        readTable();

        var on_off;
        function nameShow() {
            layer.open({
                title: '值班添加'
                , content: '<span>工号：<p></p><input type="number" id="id" value=' + parseInt(window.parent.location.search.replace('?id=', '')) + ' readonly="readonly" /></span><br/><span>日期：<input type="date" id="date" min="' + new Date().toISOString().substring(0, 10) + '" /></span><br/><span>公司就餐：<input type="checkbox" id="isEat"/></span>'
                , btn: ['提交']
                , offset: '120px'
                , yes: function () {
                    var setID = $("#id").val();
                    var setDate = $("#date").val();
                    var setEat = $("#isEat").prop('checked');
                    if (setDate == null || setDate == "") {
                        tips = "请输入日期";
                        on_off = 6;
                        nameShow();

                    } else {
                        $.post("../Handler/managedutyshow.ashx", { setID: setID, setDate: setDate, setEat: setEat, fileID: fileID },
                            function (addResult) {

                                if (addResult == "添加成功") {
                                    readTable();
                                    layer.msg(addResult, { icon: 1 });
                                }
                                else { layer.msg(addResult, { icon: 5 }); }
                            });
                    }
                }
                , anim: on_off
            });
            on_off = 0;
            tips = "";
            var checkID = $("#id").val();
            $.post("../Handler/manageDutyshow.ashx", { checkID: checkID },
                function (getName) {
                    $("span p").text(getName);
                });
        }

    </script>

</head>
<body>
    <h2 style="text-align: center"></h2>
    <form id="form1" runat="server">
        <div id="content-header" class="clearfix">
            <div class="pull-left">
                <ol class="breadcrumb">
                    <li><a id="refresh" href="javascript:window.parent.location.reload()">主页</a></li>
                    <li class="active"><span>值班查看</span></li>
                </ol>
            </div>
        </div>
        <div>

            <div class="hy-title">
                <span><i class="fa fa-cube"></i>本周值班</span>
            </div>
            <div style="float: right">
            </div>
            <div>
                <table id="dutyTable" lay-filter="test"></table>
            </div>
        </div>

    </form>
</body>

</html>
