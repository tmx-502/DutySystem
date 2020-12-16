<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userUpdate.aspx.cs" Inherits="userUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
        <meta name="renderer" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="../Scripts/layui/css/layui.css" rel="stylesheet" />
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: helvetica,arial,微软雅黑,华文黑体;
        }

        .tb_tips {
            margin-top: 20px;
        }

        .tips {
            width: 50px;
            padding-left: 20px;
            font-size:16px;
        }

        table td {
            padding: 4px;
        }

        #UName, #USex, #UPhone, #URole,#UGroup {
            color: #555;
            font-size: 18px;
            line-height: 22px;
            border: 1px solid;
            border-radius: 2px;
            width: 160px;
        }

        .input_tips {
            cursor: text;
        }

        .control2 {
            font-size: 10px;
            width: 80px;
            line-height: 22px;
        }

        h2 {
            text-align: center;
            padding: 20px 0 0px 10px;
        }
        tr td:nth-child(3){
           color:#FF5722;
       }
    </style>
    <script src="../Scripts/jquery-3.5.1.js"></script>


    <script>
        $(function () {
            var fileID = window.parent.parent.location.search.replace('?id=', '');
            
            $("#UName,#USex,#UPhone,#URole,#UPwd1,#UPwd2").hover(function () {
                $(this).addClass("input_tips");
            }, function () { $(this).removeClass("input_tips"); });


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

            $("#Button1").click(function () {   
                $("#UName,#UPhone").keyup();
                if ($("tr:nth-child(1) td:nth-child(3)").html() == $("tr:nth-child(3) td:nth-child(3)").html()) {
                    $.post("../handler/userUpdate.ashx", { upNumber: window.location.search.replace('?id=', ''), upName: $("#UName").val(), upPhone: $("#UPhone").val(), upSex: $("#USex").val(), upRole: $("#URole").val(), upGroup: $("#UGroup").val(), upIsPwd: $("#checkbox").prop('checked'), fileID: fileID }
                        , function (result) {
                            parent.returnResult(result);
                        });
                }
            });


        })


    </script>
    <script runat="server"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <h2>更改用户</h2>
                <table class="tb_tips">
                    <tr>
                        <td class="tips">姓名：</td>
                        <td>
                            <asp:TextBox ID="UName" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="tips">性别：</td>
                        
                        <td>
                            <asp:DropDownList ID="USex" runat="server">
                                <asp:ListItem Value="男">男</asp:ListItem>
                                <asp:ListItem Value="女">女</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>


                    <tr>
                        <td class="tips">手机：</td>
                        <td>
                            <asp:TextBox ID="UPhone" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="tips">角色：</td>
                        <td>
                            <asp:DropDownList ID="URole" runat="server">
                                <asp:ListItem Value="员工">员工</asp:ListItem>
                                <asp:ListItem Value="管理员">管理员</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                    <td class="tips">部门：</td>
                    <td>
                        <asp:DropDownList ID="UGroup" runat="server" >
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
                        <td class="tips" colspan="2" style="white-space: nowrap;">重置密码：<input type="checkbox" id="checkbox" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            
                        </td>
                        <td>                           
                            <button type="button"  class="layui-btn" id="Button1">保存</button> 
                            <button class="layui-btn" id="btn_close">取消</button>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
    </form>
</body>

</html>
