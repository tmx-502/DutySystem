<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>华燕值班管理系统</title>
     <link rel="Shortcut Icon" href="Image/favicon.ico" type="image/x-icon" />
    <link href="Scripts/layui/css/layui.css" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
        }

       
        .box {
            width: 1142px;
            margin: -140px 0 0 -571px;
            position: absolute;
            top: 25%;
            left: 50%;
        }

        .head {
            padding-top: 30px;
            padding-left: 50px;
        }

        .content {
            border: 1px solid rgba(238, 212, 212, 0.62);
            width: 500px;
            height: 320px;
            margin: auto;
            margin-top:100px;
            background-color: rgba(255,255,255,0.9);
        }

        table {
            /* position:relative;
            left:110px;
            top:200px;*/
            margin: auto;
            margin-top: 60px;
            text-align: center;
            font-size: 18px;
            font-weight: 700;
            opacity: 0.9;
            border-spacing: 10px 20px;
        }

        #number, #pwd {
            height: 22px
        }

        #Button1, #Button2 {
            height: 25px;
            width: 75px;
            float: right;
            margin-right: 13px;
        }

        .btm {
            position: fixed;
            bottom: 30px;
            width:100%;
            text-align:center;
            background-color: #d2d2d2;
        }
        td{
            padding:10px 3px;
        }

        .txt {
            padding: 6px 30px 6px 30px;
            font-style: normal;
        }

        h1 {
            text-align: center;
            margin-top: 30px;
            color: rgb(20, 250, 250);
            text-shadow: rgb(0, 0, 0) 2px 2px;
            font-family: 华文行楷;
            font-size: 50px;
        }

        .avic {
            position: absolute;
            right: 50px;
            bottom: 80px;
        }
    </style>
    <script src="Scripts/jquery-3.5.1.js"></script>
    <script src="plugins/layer/layer.js"></script>

    <script>
        
        $(function () {
            
            $("#login").click(function () {
                var id = $("#number").val();
                var pwd = $("#pwd").val();
                if (id == "" || id == null) {
                    layer.msg("请输入用户名！",{time: 1000 });
                    return false;
                }
                if (pwd == "" || pwd == null) {
                    layer.msg("请输入密码！", { time: 1000 });
                    return false;
                }
                $.post("Handler/login.ashx", { id: id, pwd: pwd }, function (data) {
                    switch (parseInt(data)) {
                        case 0:
                            sessionStorage.setItem('login', 'ok');
                            window.location.href = "IndexUser.aspx?id=" + id;
                            break;
                        case 1:
                            layer.msg("工号或密码错误！", { icon: 5, time: 1000});
                            break;
                        case 2:
                            sessionStorage.setItem('login', 'ok');
                            window.location.href = "Index.aspx?id=" + id;
                            break;
                        case 3:
                            layer.msg("工号或密码错误！", { icon: 5, time: 1000 });
                            break;
                        case 4:
                            layer.msg("用户名不存在！",{ icon: 0, time: 1000 });
                            
                            break;
                    }
                    return false;
                });


            });
        })
        function keydown() {
            if (event.keyCode == 13) $("#login").click();
        }
    </script>
</head>
<body onkeydown="keydown();">
    <div id="web_bg" style="position:absolute; width:100%; height:100%; z-index:-3"/>
<img style="position:fixed; height:100%; width:100%;z-index:-1" src="../image/bg.jpg"  />
    <form id="form1" runat="server">
        <div class="boxs">
            <div class="head">
                <img src="http://rjbm.hyjtkj.com/Image/logo.png" />
            </div>
            <div class="content">
                <h1>华燕值班管理
                </h1>
                <table>
                    <tr>
                        <td>工号：</td>
                        <td>
                            <asp:TextBox ID="number" runat="server"  TextMode="Number"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="number" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>密码：</td>
                        <td>
                            <asp:TextBox ID="pwd" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="pwd" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <%--      <asp:Button ID="Button1" runat="server" Text="员工登录" />
                            <asp:Button ID="Button2" runat="server" Text="管理登录" />--%>
                            <button type="button" id="login" class="layui-btn">登&nbsp&nbsp&nbsp&nbsp 录</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="avic">
                <a href="http://www.avic.com.cn/">
                    <img src="http://www.hyjtkj.com/images/avic_logo.png" />
                </a>
                <a href="http://www.zemic.com.cn/">
                    <img src="http://www.hyjtkj.com/images/ZEMIC_logo.png" />
                </a>
            </div>
            <div class="btm">
                <p class="txt">Copyright © 2015 石家庄华燕交通科技有限公司 - 冀ICP备15001061号</p>
            </div>
        </div>
    </form>
</body>
</html>
