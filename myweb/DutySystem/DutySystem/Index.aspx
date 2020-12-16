<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title>华燕值班管理系统</title>
        <meta name="renderer" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link rel="Shortcut Icon" href="Image/favicon.ico" type="image/x-icon" />
    <link href="Style/bootstrap.min.css" rel="stylesheet" />
    <link href="plugins/jquery-easyui-1.8.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="plugins/jquery-easyui-1.8.1/themes/icon.css" rel="stylesheet" />
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet" />
    <link href="Style/theme_styles.css" rel="stylesheet" />
    <script src="plugins/jquery-easyui-1.8.1/jquery.min.js"></script>
    <script src="plugins/jquery-easyui-1.8.1/jquery.easyui.min.js"></script>
    <script src="Script/bootstrap.js"></script>
    <script src="Script/demo.js"></script>
    <script src="Script/scripts.js"></script>
    <script src="Script/echarts.min.js"></script>
    <script src="plugins/layer/layer.js"></script>
    <script src="Script/common.js"></script>
    <style type="text/css">
        
        .tabs-panels {
            border: 0px;
        }
        html { font-size: 62.5%; }
body { font-size: 2rem; /* =20px */ 

       -webkit-font-smoothing: antialiased;
 -moz-osx-font-smoothing: grayscale; 
}

        .panel {
            border: 0px !important;
        }

        .panel-body {
            padding-left: 0px;
            overflow: hidden;
        }

        .tabs-header {
            border: 0px;
            background-color: #f3f5f6 !important;
            height: 0px;
        }

        .black {
            background: #2c3e50;
        }

        .blackred {
            background: #272d33;
        }

        .panel-footer {
            border: 0px;
        }

        a {
            cursor: pointer;
        }

        .panel window panel-htop {
            background-color: white !important;
            border: 1px solid red;
            padding: 0;
            margin: 0;
        }

        .panel-header panel-header-noborder window-header {
            border: 1px solid red !important;
            padding: 0;
            margin: 0;
        }

        @media screen and (min-width: 1801px) {
            #echart1 {
                width: 1000px;
                height: 650px;
                background-color: white;
                padding-top: 10px;
                margin: 0 0 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #echart2 {
                width: 500px;
                height: 650px;
                background-color: white;
                padding-top: 10px;
                margin: 0 10px 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #sidebar-nav {
                font-size: 16px;
            }

            #footer-copyright {
                color: #535252;
                font-size: 14px;
            }
        }

        @media screen and (max-width:1800px) {
            #echart1 {
                width: 950px;
                height: 600px;
                background-color: white;
                padding-top: 10px;
                margin: 0 0 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #echart2 {
                width: 450px;
                height: 600px;
                background-color: white;
                padding-top: 10px;
                margin: 0 10px 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #sidebar-nav {
                font-size: 16px;
            }
            
            #footer-copyright {
                color: #535252;
                font-size: 14px;
            }
        }
       
        @media screen and (max-width:1600px) {
            #echart1 {
                width: 800px;
                height: 550px;
                background-color: white;
                padding-top: 10px;
                margin: 0 0 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #echart2 {
                width: 400px;
                height: 550px;
                background-color: white;
                padding-top: 10px;
                margin: 0 10px 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #sidebar-nav {
                font-size: 16px;
            }

            #footer-copyright {
                color: #535252;
                font-size: 14px;
            }
        }

        @media screen and (max-width:1400px) {
            #echart1 {
                width: 700px;
                height: 450px;
                background-color: white;
                padding-top: 10px;
                margin: 0 0 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #echart2 {
                width: 350px;
                height: 450px;
                background-color: white;
                padding-top: 10px;
                margin: 0 10px 20px 10px;
                box-shadow: 5px 5px 5px #cbcbcb;
            }

            #sidebar-nav {
                font-size: 14px;
            }

            #footer-copyright {
                color: #535252;
                font-size: 12px;
            }
        }
        #config-tool{
            top:55px;
        }
       #content-header{
           height:75px;
       }
       .pull-left{
           padding-top:17px;
       }
        
    </style>
    <script>      
        if (sessionStorage.getItem('login') != "ok") {
            alert("登录信息已失效，请重新登录！");
            window.location.href = "login.aspx";
        }
        sessionStorage.removeItem('login');
    </script>

</head>
<body>
        <div class="easyui-layout" data-options="fit:true" style="border: 0px; margin: 0; padding: 0;">
        <!--顶部-->
        <div region="north" style="height: 50px;" class="navbar" id="header-navbar">
            <div class="container">
                <a id="logo" class="navbar-brand">
                    <img src="Image/blacklogo.png" style="width: 440px; height: 36px; margin: 0 0 0px 10px;" />
                </a>
                <div class="clearfix">
                    <div class="nav-no-collapse pull-right" id="header-nav">
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown profile-dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="Image/default.png" />

                                    <span class="hidden-xs">Admin</span>
                                </a>

                            </li>

                            <li class="dropdown hidden-xs">
                                <a class="btn dropdown-toggle" id="exit">
                                    <i class="fa fa-power-off" style="font-size: 18px; margin: 5px 0;"></i>
                                </a>
                            </li>


                        </ul>
                    </div>
                </div>
            </div>
        </div>

                    <!--左侧菜单start-->
        <div id="menuwest" region="west" split="true"  style="max-width: 220px;width:auto; padding: 0px; border: 0px; margin: 0px;overflow:auto;">
            <div id="page-wrapper" fit="true" style="overflow:auto;">
                <div id="user-left-box" class="clearfix  dropdown ">
                                    <img src="Image/default.png" />
                                    <div class="user-box">
                                        <div class="name">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" onclick="javascript:$('.dropdown-menu').show()">Admin
                                            <i class="fa fa-angle-down"></i>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li><a href="#"><i class="fa fa-user"></i>个人中心</a></li>
                                                <li><a href="#"><i class="fa fa-cog"></i>设置</a></li>
                                                <li><a href="#"><i class="fa fa-envelope-o"></i>消息</a></li>
                                                <li><a href="login.aspx"><i class="fa fa-power-off"></i>注销</a></li>
                                            </ul>
                                        </div>
                                        <span class="status">
                                            <i class="fa fa-circle"></i>Online
                                        </span>
                                    </div>
                                </div>
                                <div class=" navbar-collapse " id="sidebar-nav" style="overflow:auto;">
                                    <ul class="nav nav-pills nav-stacked">
                                        <li class="nav-header nav-header-first">菜单
                                        </li>
                                     
                                        <li class="no">
                                            <a class="dropdown-toggle" onclick="javascript:$('.no .submenu').toggle();$('.no').toggleClass('open')">
                                                <i class="fa fa-folder-open"></i>
                                                <span>值班管理</span>
                                                <i class="fa fa-angle-right drop-icon"></i>
                                            </a>
                                            <ul class="submenu" >        
                                                <li><a onclick="EasyUi_AddTab('Page/manageHome.aspx')">用户管理</a></li>
                                               
                                                <li><a onclick="EasyUi_AddTab('Page/manageDutyShow.aspx')">值班查看</a></li>
                                                <li><a onclick="EasyUi_AddTab('Page/log.aspx')">操作日志</a></li>
                                                
                                            </ul>
                                        </li>
                                        <li class="no1">
                                            <a class="dropdown-toggle" onclick="javascript:$('.no1 .submenu').toggle();$('.no1').toggleClass('open')">
                                                <i class="fa fa-reddit-alien"></i>
                                                <span>个人中心</span>
                                                <i class="fa fa-angle-right drop-icon"></i>
                                            </a>
                                            <ul class="submenu" >        
                                                <li><a onclick="EasyUi_AddTab('Page/workerUpdate.aspx')">更改密码</a></li>
         
                                            </ul>
                                        </li>
                                        
                                    </ul>
                                </div>
            </div>
        </div>
       
        
        <!--中间主要区域-->
        <div region="center" style="border-width: 0px; overflow: hidden;">
            <div id="mainTabs" fit="true" class="easyui-tabs" style="border-width: 0px; overflow: hidden; border-left: 2px solid #e7ebee;">
                <div>
                    <div id="content-header" class="clearfix">
                                        <div class="pull-left">
                                            <h1>首页</h1>
                                           
                                        </div>
                                    </div>

                </div>


            </div>
        </div>
        <!--页脚-->
        <div region="south" style="text-align: center; height: 34px; line-height: 30px; border-top: 1px solid #f2f2f2;">
            <p id="footer-copyright" class="col-xs-12">
                Copyright &copy; 2017-2019 HUAYAN.All Rights Reserved. 石家庄华燕交通科技有限公司 版权所有 1.0.1 build-20190606
            </p>
        </div>
    </div>

</body>
</html>
<script type="text/javascript">
    /*--网页初始化加载颜色--*/
    var storage, fail, uid, usedSkin, usedcolor; try {
        uid = new Date;
        (storage = window.localStorage).setItem(uid, uid);
        fail = storage.getItem(uid) != uid; storage.removeItem(uid);
        fail && (storage = false);
    } catch (e) { }
    if (storage) {
        try {
            usedcolor = localStorage.getItem('color');
            usedSkin = localStorage.getItem('config-skin');

            if (usedSkin != '' && usedSkin != null) { document.body.className = usedSkin; }
            else { document.body.className = 'theme-blue'; usedcolor = '7FC8BA'; }
            if (usedcolor != '' && usedcolor != null) {
                $("#skin-colors li a").each(function () {
                    if ($(this).attr("data-skin") == "theme-greenSea" && usedSkin == "theme-greenSea") {
                        $(this).css("background-color", usedcolor);
                        $("." + usedSkin + " #header-navbar").css("background-color", usedcolor);
                        $("." + usedSkin + " #header-navbar .navbar-brand ").css("background-color", usedcolor);
                        usedcolor = usedcolor.split('#')[1];

                    } else if ($(this).attr("data-skin") == usedSkin) {
                        usedcolor = $(this).attr("style").split('#')[1];
                        usedcolor = usedcolor.split(';')[0];

                    }
                });
            } else {
                $("#skin-colors li a").each(function () {
                    if ($(this).attr("data-skin") == usedSkin) {
                        usedcolor = $(this).attr("style").split('#')[1];
                        usedcolor = usedcolor.split(';')[0];
                    }
                });
            }

        }
        catch (e) { document.body.className = 'theme-blue'; usedcolor = '7FC8BA'; }
    }
    else { document.body.className = 'theme-blue'; usedcolor = '7FC8BA'; }
    localStorage.setItem("usedcolor", usedcolor);
    /*--网页初始化加载颜色end--*/
    var itemcolor = localStorage.getItem('color');
    if (itemcolor != '' && itemcolor != null) {
        $("#skin-colors li a").each(function () {
            if ($(this).attr("data-skin") == "theme-greenSea") {
                $(this).css("background-color", itemcolor);
            }
        })
    }
  

   
</script>
<script type="text/javascript">    
    $("#skin-colors li a").on('click', function () {
        usedSkin = $(this).attr("data-skin");
        usedcolor = $(this).attr("style").split(':')[1];
        if (usedSkin == "theme-greenSea") {
            var greencolor = localStorage.getItem('color');
            if (greencolor != "" && greencolor != null) {
                $("#header-navbar").css("background-color", "");
                $("#header-navbar").css("background-color", greencolor);
                usedcolor = greencolor.split('#')[1];
            } else {
                usedcolor = usedcolor.split('#')[1];
                usedcolor = usedcolor.split(';')[0];

            }
        } else if (usedSkin == "theme-navyBlue") {
            usedcolor = usedcolor.split('#')[1];
            usedcolor = usedcolor.split(';')[0];
            $("#header-navbar").css("background-color", "#fff");
            
        } else {
            usedcolor = usedcolor.split('#')[1];
            usedcolor = usedcolor.split(';')[0];
            
        }
        localStorage.setItem("usedcolor", usedcolor);
    })
   



    function EasyUi_AddTab(url) {
        var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '?r=' + Math.floor(Math.random()* 100000000)+'" style="width:100%;height:100%;padding:0;margin:0;"></iframe>';
        $('#mainTabs').tabs('add', {
            content: content,
            closable: true
        });
    }
    $("#exit").click(function () {
        layer.confirm('您是否要退出系统？', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            window.location.href = "login.aspx";
        });
    })
    $(document).ready(function () {
        // 在这里写你的代码...
        EasyUi_AddTab('Page/manageDutyShow.aspx');
    });
   
</script>
    

