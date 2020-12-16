<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workerUpdate.aspx.cs" Inherits="workerUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="renderer" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="../plugins/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../plugins/jquery-easyui-1.8.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="../plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Style/theme_styles.css" rel="stylesheet" />
    <link href="../Style/Master.css" rel="stylesheet" />
    <link href="../Style/jquery-labelauty.css" rel="stylesheet" />
    <style type="text/css">
        .form-control {
            height:40px!important;
        }
        .panel-body {
            
            overflow: hidden;
        }
        .hy-title {
            height: 30px;
            font-size: 16px;
            border-bottom: 1px solid #e7ebee;
            margin: 10px 0 20px 0;
            font-weight:bold;
        }

            .hy-title span {
                border-bottom: 4px solid #7fc8ba;
                line-height: 30px;
                padding-bottom: 3px;
                padding-right: 15px;
            }

                .hy-title span i {
                    color: #7fc8ba;
                    font-size: 24px;
                    margin: 0 5px;
                }   
                .btnSave1{
                    background-color: #56b09e;
                  
                    color: white; 
                    font-size: 14px; 
                    border-radius: 4px; 
                    text-decoration: none;
                    border:none;
                    width:70px;
                }
        .breadcrumb {
            margin-top:-10px;
            padding:-8px  15px 15px;
            font-size:16px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content-wrapper" style="margin: 0; background-color: white;">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-12">
                            <div id="content-header" class="clearfix">
                                <div class="pull-left">
                                    <ol class="breadcrumb">
                                        <li><a href="javascript:window.parent.location.reload()">主页</a></li>
                                        <li class="active"><span>修改密码</span></li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="hy-title">
                                <span><i class="fa fa-cube"></i>修改密码</span>
                            </div>
                            <div class="hy-edit-data">
                                <table>
                                    <tr>
                                        <td class="edit_main_td_title">当前密码
                                        </td>
                                        <td class="edit_main_td_width">
                                            <asp:TextBox ID="npwd" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="edit_main_td_title">新密码</td>
                                        <td class="edit_main_td_width" colspan="3" style="height: 24px!important; line-height: 24px;">                                            
                                            <asp:TextBox ID="pwd" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>

                                        </td>


                                    </tr>
                                    <tr>
                                        <td class="edit_main_td_title">确认密码</td>
                                        <td class="edit_main_td_width" colspan="3" style="height: 24px!important; line-height: 24px;">                                         
                                           <asp:TextBox ID="qpwd" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td class="edit-data-button" style="height: 50px!important" colspan="4">
                                            <button id="btnSave" class="btnSave1" type="button">保存</button>
                                            <asp:HiddenField ID="HiddenStr" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
<script src="../plugins/jquery-easyui-1.8.1/jquery.min.js"></script>
<script src="../plugins/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script src="../Script/common.js"></script>
<script src="../plugins/layer/layer.js"></script>
<script type="text/javascript">
    var url = window.parent.location.search;        
    document.getElementById("HiddenStr").value = url.replace('?id=', '');
    $("#btnSave").click(function () {
        var id = $("#HiddenStr").val();
        var npwd = $("#npwd").val();
        var pwd = $("#pwd").val();
        var qpwd = $("#qpwd").val();
        if (npwd == "" || npwd == null) {
            layer.msg("请输入旧密码");
            return false;
        }
        if (pwd == "" || pwd == null) {
            layer.msg("请输入新密码");
            return false;
        }
        if (qpwd == "" || qpwd == null) {
            layer.msg("请输入确认密码");
            return false;
           
        }
        if (pwd != qpwd) {
            layer.msg("两次密码输入不一致");
            return false;
        }
        $.post("/Handler/workerUpdate.ashx", { id: id, npwd: npwd,pwd,pwd }, function (result) {
           
                layer.msg(result);
            
        })
    })

</script>
<script type="text/javascript">
      var skincolor = "#" + localStorage.getItem('usedcolor');
      $(".hy-title span i").css("color", skincolor);
      $(".hy-title span").css("border-color", skincolor);
      $("#btnSave").css("background-color", skincolor);
      $("#skin-colors li a", parent.parent.document).on('click', function () {
          skincolor = $(this).attr("style").split(':')[1];
          skincolor = skincolor.split(';')[0];
          $(".hy-title span i").css("color", skincolor);
          $(".hy-title span").css("border-color", skincolor);
          $("#btnSave").css("background-color", skincolor);
      })
</script>
