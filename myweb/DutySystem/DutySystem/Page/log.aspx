<%@ Page Language="C#" AutoEventWireup="true" CodeFile="log.aspx.cs" Inherits="Page_log" %>

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

        h2 {
            margin: 30px;
            text-align: center;
            display: none;
        }

        .layui-timeline {
            margin-left: 30px;
        }

        #clear {
            position: fixed;
            bottom: 0px;
            right: 0px;
        }
    </style>
    <script>
        $(document).ready(function () {
            if ($("#log").val() != "") {

                var data = $("#log").val().split(/[\n]/).reverse();
                data.splice(0, 1);
                var timeArr = data[0].split(' ')[0].split(':')[1] + ",";
                for (i = 1; i < data.length; i++) {

                    var time = data[i].split(' ')[0].split(':')[1];
                    var time1 = data[i - 1].split(' ')[0].split(':')[1];
                    if (time != time1) {
                        timeArr += time + ",";
                    }
                }
                timeArr = timeArr.split(",");
                timeArr.splice(-1);             
                $(timeArr.reverse()).each(function () {
                    $(".layui-timeline").prepend($("#dom").html());
                    var $str = this.toString();
                    
                    $(".layui-timeline-title p").replaceWith($str);

                });
                $.each(data, function (index, value) {
                    var check = value.substring(value.indexOf(":") + 1, value.indexOf(" "));                              
                    $(".layui-timeline-title").each(function () {              
                        if (this.innerHTML.trim() == check.trim() ) {
                            $(this).next().append("<li>" + value.substring(value.indexOf(" ")) + "</li>");
                        }
                    });
                });

            } else {
                $("h2").show();
            }
          
        });
       

    </script>

    <script type="text/html" id="dom">
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis ">&#xe63f;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title"><p></p> </h3>
                <ul>
                </ul>
            </div>
        </li>
         <li class="layui-timeline-item">
                    <i class="layui-icon  layui-timeline-axis ">&#xe63f;</i>
                    <div class="layui-timeline-content layui-text">
                        <ul>
                        </ul>
                    </div>
                </li>
    </script>
</head>
<body>
    <h2 style="text-align: center"></h2>
    <form id="form1" runat="server">
        <div id="content-header" class="clearfix">
            <div class="pull-left">
                <ol class="breadcrumb">
                    <li><a id="refresh" href="javascript:window.parent.location.reload()">主页</a></li>
                    <li class="active"><span>操作日志</span></li>
                </ol>
            </div>
        </div>
        <div>

            <div class="hy-title">
                <span><i class="fa fa-cube"></i>操作日志</span>
            </div>
        </div>

        <div>

            <ul class="layui-timeline">
                
               
            </ul>
            <h2>当前无日志记录</h2>
        </div>
        <asp:HiddenField ID="HiddenField1" runat="server" />

        <asp:HiddenField runat="server" ID="log" />

    </form>
</body>
</html>
