
if (typeof (Sys) != "undefined") {
    var prm = Sys.WebForms.PageRequestManager.getInstance();

    if (prm) {
        prm.add_endRequest(function (sender, args) {
            if (args._error != null) {
                if (args._error.name == "Sys.WebForms.PageRequestManagerParserErrorException") {
                    //alert("登陆超时,请重新登陆");
                    args._error.message = "Your session has expired";
                    args._errorHandled = true;
                    window.location.reload();
                    return false;
                }
            }
        });
    }
}

//去除首尾空格
function Trim(str) { //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
//判断的是否为空
/**
 * @return {boolean}
 */
function IsNullOrEmpty(string) {
    string = Trim(string);
    return !!(string == null || string == "");
}

/*----------------------------------hy-search 搜索 begin----------------------------------*/
function HY_SearchFunction() {
    //控件样式
    function ControlStyle() {
        //文本框提示
        $(".hy-search").addClass("input-group");
        $(".hy-search>span").addClass("input-group-addon");
        //文本框样式
        var $txt = $(".hy-search :text");
        $txt.addClass("form-control input-sm");
        text_words("请输入", $txt);
        //下拉列表框
        $(".hy-search select").addClass("form-control input-sm");
        //添加图标样式
        $(".select_info").addClass("glyphicon-th-list");
    }

    //给文本框填充提示
    function text_words(words, txt) {
        $(txt).each(function () {
            var title = $(this).closest(".hy-search").find("span").text();
            title = Trim(title.replace(":", ""));
            if (title.indexOf("至", 0) > 0) {
                var txtToolTip = "请选择" + title.substr(0, title.length - 1);
                $(this).attr("placeholder", txtToolTip);
            } else {
                var txtToolTip = words + title;
                $(this).attr("placeholder", txtToolTip);
            }
        });
    }

    ControlStyle();
    /*搜索更多*/
    $(document).on('click', ".hy-searchmoretxt", function () {
        if ($(this).text() == "隐藏条件") {
            $(".hy-searchmore").css("cssText", "overflow:hideen!important");
            $(this).text("更多条件");
        } else {
            $(".hy-searchmore").css("cssText", "overflow:visible!important");
            $(this).text("隐藏条件");
        }
    });
}

/*清空搜索功能条件*/
function HY_SearchClear() {
    $(".hy-search :text").val("");//清空文本框
    $select = $(".hy-search select");
    //获取所有下拉列表框第一项
    $option = ($select.find("option:first-child"));
    //第一项选中
    $option.each(function (i, date) {
        $(this).parent().val($(date).val());
    });
    $(".hy-search :checkbox").attr("checked", false);
}

$(function () {
    HY_SearchFunction();
});
/*---------------------------------hy-search 搜索 end-------------------------------------*/

/*----------------------------------hy-gridview 数据展示 begin----------------------------*/
//GridView的一些功能样式
function HY_GridViewFunction() {
    //找到所有tr不包括第一行标题
    var $tr = $(".hy-gridview table tr").not(":first");
    $(".hy-data-wrap .resizable").find("table").addClass("resizable");
    //使用$(document).on 解决.netAjax问题，银光棒效果
    $(document).on("mouseover", ".hy-gridview table tr:not(:first)", function () {
        $(this).addClass("hy-gridview-hover_background");
    }).on("mouseleave", ".hy-gridview table tr:not(:first)", function () {
        $(this).removeClass("hy-gridview-hover_background");
    });

    //拥有hy-gridview-click样式下的tr，高亮显示
    $(document).on("click", ".hy-gridview-click tr:not(:first)", function () {
        //如果tr下存在class为details则再次单击当前行不进行操作
        if ($(this).find(".details").length <= 0) {
            //单击的行高亮显示
            $(this).addClass("hy-gridview-click_background");
            //移除所有兄弟节点的样式
            $(this).siblings().removeClass("hy-gridview-click_background");
        }
    });

    //--------------阻止事件冒泡--------------
    //找到ID为hy-gridview下面的tr，不包含第一个
    $(document).on("mouseover", ".hy-gridview  tr:not(:first)", function () {
        //阻止事件冒泡，添加class来识别
        $(this).find("input[type=checkbox]").parent().addClass("inputtd");//阻止复选框所在的td冒泡
        //$(this).find("img").parent().addClass("inputtd");//阻止gridView图标所在的td冒泡
        $(this).find("input[type=radio]").parent().addClass("inputtd");//阻止gridView图标所在的td冒泡
    });
    // 取消事件冒泡
    $(document).on("click", ".inputtd", function (event) {
        event.stopPropagation();
    });
    //选中所有数据
    $(document).on("click", ".hy-gridview-checkedAll", function () {
        var control = document.getElementsByTagName("input");
        for (var i = 0; i < control.length; i++) {
            //当全选选中
            if (this.checked) {
                //查找复选框
                if (control[i].type == "checkbox") {
                    control[i].checked = true;
                }
            }
            else {
                if (control[i].type == "checkbox") {
                    control[i].checked = false;
                }
            }
        }
    });
}
//获取指定tr中,索引为index的td的文本值
function GetTrColumnTextByIndex(tr, index) {
    var getValue = $(tr).find("td:eq(" + index + ")").text();
    return Trim(getValue);
}

$(function () {
    HY_GridViewFunction();
});

/*---------------------------------bootstrap面板（Panels）（在bootstrap基础上修改) begin------------------------------*/
$(function () {
    //折叠面板内容
    function PanelHidden(panel) {
        $(panel).find(".panel-body").hide();
        $(panel).find(".hy-text").hide();
        $(panel).find("table").hide();
        //不存在标题，则显示数据
        $(panel).each(function () {
            var len = $(this).find(".panel-heading").length;
            if (len == 0) {
                PanelShow(this);
            }
        });
    }

    //显示面板内容
    function PanelShow(panel) {
        $(panel).find(".panel-body").fadeIn(200);
        $(panel).find(".hy-text").fadeIn(200);
        $(panel).find("table").fadeIn(200);
    }

    //面板里的内容是否显示；是返回true
    function PanelIsShow(panel) {
        var $body = $(panel).find(".panel-body");
        var $text = $(panel).find(".hy-text");
        var $table = $(panel).find("table");
        if ($body.is(":visible") || $text.is(":visible") || $table.is(":visible")) {
            return true;
        } else {
            return false;
        }
    }

    //初始化隐藏数据
    PanelHidden(".hy-panel-collapse .panel");
    var i = 0;
    $(document).on("click", ".hy-panel-collapse .panel-heading", function () {
        ////在页面上创建隐藏控件，单击记录面板的索引值
        //if ($("#hy-panel-clickIndex").length == 0)
        //    $("body").append("<input id='hy-panel-clickIndex' type='hidden' />");
        var $panels = $(this).closest(".panel");
        //切换可见状态
        if (PanelIsShow($panels)) {
            PanelHidden($panels);
        } else {
            PanelShow($panels);
        }
    });

    $(document).on("click", ".btn,.hy-nav-tabs li", function () {
        //btn一般是按钮的class,服务器按钮有回传；所以需要延迟
        window.setTimeout(HY_Text, 500);
    });

    function HY_Text() {
        $(".hy-text i").each(function (index, date) {
            var info = $(date).html() + ":";
            $(date).html(info);
        })
        //获取span标签
        $(".hy-text span").each(function (index, date) {
            var info = "";
            //查找是否有下来列表框
            var $select = $(this).find("select");
            if ($select.length > 0) {
                //获取选中的文本
                info = $select.find(" :selected").text();
            } else {
                info = $(date).text();
            }

            if (IsNullOrEmpty(info))
                $(date).text("无");
            else
                $(date).text(StrYesOrNo(info));
        })
        $(document).on("mouseover", ".hy-text span", function () {
            var txt = $(this).find("select option:selected").text();
            if ($(this).find("select").length > 0) {
                $(this).text(txt);
            }
            layer.tips($(this).text(), $(this), {
                tips: [3, '#000 '] //还可配置颜色
            });
        }).on("mouseleave", ".hy-text span", function () {
            layer.tips('', '', {});
        });
    }

    HY_Text();
});

/*----------------------------------标签页（Tab）仿Bootstrap（可使用服务器控件) begin------------------------------*/
function HY_Tabs() {
    $(document).on("click", ".hy-nav-tabs li ", function (e) {
        //单击li添加活动样式
        $(this).siblings().removeClass("nav-tabs-active");
        $(this).addClass("nav-tabs-active");
        //获取当前li的id
        var id = $(this).attr("id");
        id = Trim(id);
        //获取显示内容对应id的class
        $div = $(".hy-tab-panel ." + id);
        $div.fadeIn();
        $div.siblings().fadeOut();
    });
}
$(function () {
    HY_Tabs();
});
/*----------------------------------标签页（Tab）仿Bootstrap（可使用服务器控件) end------------------------------*/

/*------------------------------------------控件样式 begin----------------------------------------------*/
function Control_style() {
    $("form").attr("role", "form");
    var $hy_control_style = $(".hy-control-style");
    $hy_control_style.addClass("form-group");
    $hy_control_style.find(" :text").addClass("form-control");//文本框样式
    $hy_control_style.find(" :text").addClass("auto_width");//宽度自适应
    //按钮样式
    $hy_control_style.find("button").addClass("btn btn-default");
    //多行文本
    $hy_control_style.find("textarea").addClass("form-control");
    //下拉
    $hy_control_style.find("select").addClass("form-control");
    //密码
    var $password = $hy_control_style.find(":password");
    $password.addClass("form-control");
}
$(function () {
    //控件样式
    Control_style();
});
/*------------------------------------------控件样式 end----------------------------------------------*/

/*------------------------------------------hy-icoPanel 图标面板 begin----------------------------------------------*/
$(function () {
    function HY_IcoPanelInit() {
        //获取图标面板元素
        var $icopanel = $(".hy-icoPanel li>s").parent().closest(".hy-icoPanel");
        $icopanel.each(function () {
            var $this = $(this);
            //获取选中菜单的ID，如果不存在则将所有菜单设置为选中状态
            var checkedId = $this.find(".hy-icoPanel-initCheckedId").text().trim();
            //√，代表选中状态
            $this.find("li>s").hide();
            var idArray = checkedId.split("-");
            //遍历菜单,更改选中菜单的状态
            $(idArray).each(function () {
                //获取数组中的菜单id
                var value = this;
                $this.find("li>input:hidden").each(function () {
                    //遍历的数组中与菜单ID相同，显示√
                    if ($(this).val() == value) {
                        $(this).parent().find("s").show();
                    }
                });
            })
            //初始化选中的个数
            $this.find(".hy-icoPanel-checkedCount").text($this.find("ul li s:visible").length);
        });
    }

    HY_IcoPanelInit();
    $(document).on("mouseenter", ".hy-icoPanel li", function () {
        if ($(this).find("s").length > 0) {
            $(this).css("cursor", "pointer");
        }
    });
    /*-------------------单击切换选中状态-------------------*/
    $(document).on("click", ".hy-icoPanel li", function () {
        var $s = $(this).find("s");
        if ($s.is(":hidden"))
            $s.show();
        else
            $s.hide();
    });
    /**-----------单击全选选中所有菜单---------------------*/
    $(document).on("click", ".hy-icoPanel-checkedAll", function () {
        $(this).closest(".hy-icoPanel").find("ul li>s").show();
    });
    /**----------单击反选；反向选择菜单-------------------*/
    $(document).on("click", ".hy-icoPanel-checkedReverse", function () {
        $(this).closest(".hy-icoPanel").find("ul li>s").each(function () {
            if ($(this).is(":hidden"))
                $(this).show();
            else
                $(this).hide();
        });
    });
    /**----------获取选中的个数-------------------*/
    $(document).on("click", ".hy-icoPanel-checkedAll,.hy-icoPanel-checkedReverse,.hy-icoPanel li", function () {
        var $icoPanel = $(this).closest(".hy-icoPanel");
        $icoPanel.find(".hy-icoPanel-checkedCount").text($icoPanel.find("ul li>s:visible").length);
    });

    /*=======================================================================================
     hy-icoPanelAll图标面板
     说明：该功能是用户选择需要改换的图标如：菜单图标、按钮图标；将选择的信息保存下来；
     所有的图标主要来自于服务器上的存放图标的某个文件夹下
     更新日期:2015-4-3
     作者:lianhailong
     =======================================================================================*/
    $(".hy-icoPanelAll").hide();
    /**----------单击更改图片，显示指定文件下图标面板-------------------*/
    //单击更换图标
    $(document).on("click", ".hy-icoPanelAll-change", function () {
        //隐藏其他内容
        $wrap = $(this).closest(".hy-icoPanelAll-wrap");
        var $icoPanelAll = $wrap.find(".hy-icoPanelAll");
        $icoPanelAll.siblings().hide();
        $icoPanelAll.fadeIn();
    });
    //单击图标，更换图标
    $(document).on("click", ".hy-icoPanelAll li", function () {
        var $wrap = $(this).closest(".hy-icoPanelAll-wrap");
        var $icoPanelAll = $wrap.find(".hy-icoPanelAll");
        $icoPanelAll.siblings().fadeIn();
        $icoPanelAll.hide();
        //获取选中的图标路径
        var src = $(this).find("img").attr("src");
        //更改图标
        $wrap.find(".hy-icoPanelAll-changeImg").attr("src", src);
    });
    //单击取消
    $(document).on("click", ".hy-icoPanelAll-changeEsc", function () {
        var $wrap = $(this).closest(".hy-icoPanelAll-wrap");
        var $icoPanelAll = $wrap.find(".hy-icoPanelAll");
        $icoPanelAll.siblings().fadeIn();
        $icoPanelAll.hide();
    });
});
/*-------------------------
 获取选中菜单的id,返回值 如:1-2-3-4
 元素id,如:hy-icoPanel
 -------------------------*/
function HY_GetIcoPanelCheckedID(objId) {
    var menusId = "";
    //便利选中项
    $("#" + objId + " ul li s:visible").each(function () {
        //获取选中菜单的ID
        var value = $(this).parent().find(":hidden").val();
        menusId += value + "-";
    })
    if (menusId.length > 0)
        menusId = menusId.substr(0, menusId.length - 1);
    return menusId;
}
/*------------------------------------------hy-icoPanel 图标面板 end----------------------------------------------*/

/*-----------------------------------------以下代码未更改----------------------------------------------------*/
//获取网站更目录
function getRootPath() {
    var strFullPath = window.document.location.href;
    var strPath = window.document.location.pathname;
    var pos = strFullPath.indexOf(strPath);
    var prePath = strFullPath.substring(0, pos);
    var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
    return (prePath);
}

$(function () {
    //添加,修改页面
    Edit_style();

    //Ajax样式
    AjaxControl_style();

    //曲线
    //Curve_function();

    //权限管理面板
    RM_Function();
})

/*添加/修改页面控件效果*/
function Edit_style() {
    $("form").attr("role", "form");
    $group = $(".hy-edit-data tr");
    $group.addClass("form-group");
    //文本框
    var $txt = $group.find(":text");
    $txt.addClass("form-control edit-data-control");
    Edit_text_words("请输入", $txt);
    //密码
    var $password = $group.find(":password");
    $password.addClass("form-control edit-data-control");
    //多选
    $group.find("textarea").addClass("form-control edit-data-control");
    $group.find("select").addClass("form-control edit-data-control input-sm");
    function Edit_text_words(words, $txt) {
        $txt.each(function (index, element) {
            var title = $(element).parent().prev().text();
            title = Trim(title.replace(":", ""));
            title = title.replace("*", "")
            var txtToolTip = words + title;//文本框提示用户输入
            $(this).attr("placeholder", txtToolTip);
        });
    }
}

/**其他页面引用控件的样式*/

/*******************Ajax ComboBox控件的样式*********************/
function AjaxControl_style() {
    $button = $(".ajax__combobox_buttoncontainer button").addClass("glyphicon-th-list");
}


//日期控件
function myDatePicker() {
    $(document).on("focus", ".myDatePicker", function () {
        WdatePicker();
    });
}

$(function () {
    myDatePicker();
});

/********************************************
 权限管理功能及样式
 日期：2015-12-26
 *******************************************/
function RM_Function() {
    /***单击搜索按钮，隐藏**/
    $(".title>i").click(function () {
        //获取图标样式
        var myClass = Trim($(this).attr("class").replace("glyphicon", ""));

        //搜索图标
        if (myClass == "glyphicon-search") {
            //隐藏提示信息
            $(this).parent().find("span").hide();
            //显示文本输入框
            $(this).parent().find("input").show();
            $(this).parent().find("input").focus();
            $(this).removeClass("glyphicon-search");
            $(this).addClass("glyphicon-remove");
        } else {
            //回复初始状态
            $(this).parent().find("span").show();//文字显示
            $(this).parent().find("input").hide();//文本框隐藏
            $(this).parent().find("input").val("");//清空文本
            $(this).removeClass("glyphicon-remove");//更换图标样式
            $(this).addClass("glyphicon-search");
            //显示所有的信息
            $(this).parent().parent().find(".RolesPower_contents  ul li").show();
            $(this).parent().parent().find(".RolesPower_contents  ul").show();
            $(this).parent().parent().find(".RolesPower_contents  dl dd").show();
            $(this).parent().parent().find(".RolesPower_contents  dl").show();
        }
    });

    //搜索dd或li中的数据 
    $(document).on("keyup", ".title>input", function () {
        var txt = $(this).val();
        var txtReg = new RegExp(txt);
        $(this).parent().parent().find(".RolesPower_contents  ul li").each(function (i, data) {
            //获取li中的文本
            var liText = $(data).text();
            if (txtReg.test(liText))
                $(data).show();
            else
                $(data).hide();
        });
        /*******RolesPower_contents ul是否显示******/
        $(this).parent().parent().find(".RolesPower_contents  ul").each(function (i, data) {
            var $dd = $(data).find("li:visible");
            if ($dd.length == 0)
                $(data).hide();
            else
                $(data).show();
        });
        $(this).parent().parent().find(".RolesPower_contents  dl dd").each(function (i, data) {

            //获取li中的文本
            var liText = $(data).text();
            if (txtReg.test(liText))
                $(data).show();
            else
                $(data).hide();
        });
        /***RolesPower_contents  dl是否显示****/
        $(this).parent().parent().find(".RolesPower_contents  dl").each(function (i, data) {
            var $dd = $(data).find("dd:visible");
            if ($dd.length == 0)
                $(data).hide();
            else
                $(data).show();
        });
        if (IsNullOrEmpty(Trim(txt))) {
            //显示所有的信息
            $(this).parent().parent().find(".RolesPower_contents  ul li").show();
            $(this).parent().parent().find(".RolesPower_contents  ul").show();
            $(this).parent().parent().find(".RolesPower_contents  dl dd").show();
            $(this).parent().parent().find(".RolesPower_contents  dl").show();
        }
    });
    /***实现该面板复选框的全选功能***/
    $(".RM_CheckedAll").click(function () {
        //获取当前控件选中的状态
        var flag = this.checked;
        //获取dd下的复选框
        var $ddCheckBox = $(this).parent().parent().parent().find(".RolesPower_contents dd input[type=checkbox]");
        var $liCheckBox = $(this).parent().parent().parent().find(".RolesPower_contents li input[type=checkbox]");
        //统计当前选中的个数
        var checkedCount = 0;
        $ddCheckBox.each(function () {
            checkedCount++;
            this.checked = flag;
        });
        $liCheckBox.each(function () {
            checkedCount++;
            this.checked = flag;
        });
        //全选中的状态下
        if (flag) {
            $(this).parent().parent().find(".checkCount").text(checkedCount);
        }
        else
            $(this).parent().parent().find(".checkCount").text("0");
    });
    /********选中角色或用户面板ul中的li class= clickActive,***********/
    $(".RolesPower_contents .nav.clickActive li:eq(0)").addClass("active");
    $(".RolesPower_contents .nav.clickActive li").click(function () {
        //当前选中的li激活
        $(this).addClass("active");
        $(this).siblings().removeClass("active");
    });
    /*******在class=checkCount中显示 RolesPower_contents下li或dt选中的复选框个数********/
    $(".RolesPower_contents .nav  li").has("input:checkbox").click(function () {
        var count = $(this).parent().find(":checked").length;
        $(this).parent().parent().parent().find(".checkCount").text(count);
    });
    $(".RolesPower_contents  dd").has("input:checkbox").click(function () {
        var count = $(this).parent().parent().find(":checked").length;
        $(this).parent().parent().parent().parent().find(".checkCount").text(count);
    });
}

/*--------------------------------------------------------------------------------------
 常用的功能方法
 --------------------------------------------------------------------------------------*/

/*-------------------------------------
 弹出框 content:内容
 ico:1 √ ico:2 X ico 8 !
 isParent:是否在父层调用（可省略该参数）
 -------------------------------------*/
function AlertZC(content, ico, isParent, callback) {
    if (ico == null || ico == "")
        ico = 1;
    if (isParent) {
        parent.layer.alert(content, {
            title: '提示',
            icon: ico,
            skin: 'layer-ext-moon'
        }, function (index) {
            if (typeof (callback) == "function") {
                layer.close(index);
                callback();
            }
        });
    } else {
        layer.alert(content, {
            title: '提示',
            icon: ico,
            skin: 'layer-ext-moon'
        }, function (index) {
            if (typeof (callback) == "function") {
                layer.close(index);
                callback();
            }
        });
    }
}
function Alert(content, ico, isParent) {
    if (ico == null || ico == "")
        ico = 1;
    if (isParent) {
        parent.layer.alert(content, {
            title: '提示',
            icon: ico
        });
    } else {
        layer.alert(content, {
            title: '提示',
            icon: ico
        });
    }
}
/*-------------------------------------
 提示框 content:内容
 isParent:是否在父层调用（可省略该参数）
 -------------------------------------*/
function Msg(content, isParent) {
    if (isParent) {
        parent.layer.msg(content);
    } else {
        layer.msg(content);
    }
}
/*-------------------------------------
 弹出框，且跳转页面
 -------------------------------------*/
function AlertAndGo(content, url) {
    layer.msg(content, function () {
        window.location.href = url;
    });
}
/*-------------------------------------
 通过html内容，模态弹框
 --------------------------------------*/
function ShowDialogBy_HtmlMax(html, title, width, height, IsMaxMin) {
    width = width == null ? 700 : width;
    height = height == null ? 350 : height;
    layer.open({
        title: title,
        type: 1,
        area: [width + 'px', height + 'px'],
        fix: false, //不固定
        maxmin: IsMaxMin,
        content: html
    });
}
/*-------------------------------------
 通过路径，模态弹框
 --------------------------------------*/
function ShowDialogBy_UrlMax(url, title, width, height, IsScroll, IsMax) {
    width = width == null ? '100%' : width <= 1 ? (width * 100 + '%') : (width + 'px');
    height = height == null ? '100%' : height <= 1 ? (height * 100 + '%') : (height + 'px');
    if (IsScroll == null || IsScroll == false) {
        IsScroll = "no";
    } else {
        IsScroll = "yes";
    }
   var l= layer.open({
        title: title,
        type: 2,
        area: [width, height],
        fix: false, //不固定
        maxmin: IsMax,
        content: [url, IsScroll]
   });
   return l;
}

//True/Flase转换成是否
function StrYesOrNo(boolean) {
    //转换成小写
    bool = boolean.toLowerCase();
    if (bool == "false") {
        return "否";
    }
    else if (bool == "true") {
        return "是";
    }
    else
        return boolean;
}

//修改提示信息
function EditMsg() {
    Alert("请在一项修改的数据前打√<br/>", 8);
}

/*-------------------------------------------------
 选中数据的提示信息
 说明:该方法提示用户需要选择【一项】数据的操作
 适用于:无经过任何处理数据前
 -------------------------------------------------*/
function Msg_Checked() {
    /******************存在复选框的情况*************************/
    if ($(".hy-gridview tr td :checkbox").length > 0) {
        //复选框没有一个选中情况
        if ($(".hy-gridview tr td :checked").length == 0) {
            Alert("请<span style='color:#ff0000'>选择一项</span>操作的数据打√", 8);
            return false;
        }
        //复选框选中多个情况
        else if ($(".hy-gridview tr td :checked").length > 1) {
            Alert("<span style='color:#ff0000'>您选择了多项数据，只能选择一项</span>", 8);
            return false;
        }
    }
    /******************无复选框的情况*************************/
    else if ($(".hy-gridview tr td :checkbox").length == 0) {
        //无选中行
        if ($(".hy-gridview tr.hy-gridview-click_background").length == 0) {
            Alert("请单击<span style='color:#ff0000'>选择一项</span>操作的数据", 8);
            return false;
        }
    }
    return true;
}
//特殊情况的复选框选择情况
function Msg_Checked2() {
    //复选框没有一个选中情况
    if ($(".hy-gridview tr td :checked").length == 0) {
        Alert("请<span style='color:#ff0000'>选择一项</span>操作的数据打√", 8);
        return false;
    }
    //复选框选中多个情况
    else if ($('input[type="checkbox"]:checked').length > 1) {
        Alert("<span style='color:#ff0000'>您选择了多项数据，只能选择一项</span>", 8);
        return false;
    }
    return true;
}
$(function () {
    /********************工具栏提示********************************/
    //删除提示

    $(document).on("click", ".hy-data-wrap:not(.hy-none-event) .deleteMore", function () {
        try {
            var $this = $(this);
            var id = $(this).attr("id");
            var $tr = $("#detInfo").prev();//根据tr找到检测流水号
            var checkCount = $(".hy-gridview input:checked:not('.hy-gridview-checkedAll')[type=checkbox]").length;
            var checkcount2 = $(".hy-gridview input:checked[type=radio]").length;// lxl 20180529检测查询界面没有checkbox控件需要换一种判断方式
            if (checkCount <= 0 && checkcount2 <= 0) {
                Alert("请在要<span style='color:#ff0000'>删除的数据</span>前打√", 7);
                return false;
            }
            var isdelete = $(this).attr("data-isdelete");//是否删除
            if (isdelete != "true") {
                if (checkcount2 > 0) {// lxl 20180529检测查询界面没有checkbox控件需要换一种判断方式
                    if (confirm("您确定要删除该页面选中的数据吗？")) {
                        $this.attr("data-isdelete", "true");
                        var jclsh = GetTrColumnTextByIndex($tr, 0);//检测流水号
                        if (jclsh == undefined || jclsh == null)
                            jclsh = "";
                        __doPostBack("lbtnDelMore", "" + jclsh + "");
                        return false;
                        //return Delectex();//lxl 20180529 后台方法无效，调用检测查询页面js方法
                    } else {
                        $this.attr("data-isdelete", "false");
                        return false;
                    }
                } else {
                    //询问框
                    layer.confirm('<span style="color:#ff0000">您确定要删除该页面选中的数据吗？</span>', {
                        btn: ['确定', '取消'] //按钮
                    }, function () {
                        $this.attr("data-isdelete", "true");
                        var jclsh = GetTrColumnTextByIndex($tr, 0);//检测流水号
                        if (jclsh == undefined || jclsh == null)
                            jclsh = "";
                        __doPostBack("lbtnDelMore", "" + jclsh + "");
                        //document.getElementById("lbtnDelMore").click();
                    }, function () {
                        $this.attr("data-isdelete", "false");
                    });
                    return false;
                }
            }
        } catch (ex) {
            alert(ex.message)
        }

    });

});

/*******************************************************
 功能：所有引用css为.select_info的标签，加鼠标经过时透明度的变化
 author：SL
 date：2015-9-17
 *******************************************************/
function Select_info_Style() {
    $(".select_info").hover(function () {
        $(this).stop().animate({
            opacity: '0.5'
        }, 600);
    }, function () {
        $(this).stop().animate({
            opacity: '1'
        }, 1000);
    });
}

$(function () {
    Select_info_Style();
});

/********************************************
 扩展帮助类 2018
 *******************************************/
$.fn.extend({
    /*
     * 将数据绑定到下拉列表框中
     * @param {object} options:参数集合
     * @param callback:回调函数,当数据绑定完成之后触发
     */
    "HY_BindSelect": function (options, callback) {
        var $this = $(this);
        options = $.extend({
            textField: null, //文本值
            valueField: null, //value值
            formatterTextField: function () { },
            formatterValueField: function () { },
            url: null,
            data: null,
            jsonData: null
        },
            options);
        if (options.jsonData != null) {
            bind(options.jsonData);
        } else {
            $.ajax({
                url: options.url,
                type: "post",
                data: options.data,
                dataType: "json",
                success: function (resultdata) {
                    if (resultdata != null) {
                        bind(resultdata);
                        //绑定数据成功之后的回掉函数
                        if (typeof callback == 'function') {
                            callback(resultdata);
                        }
                    }
                }
            });
        }
        function bind(resultdata) {
            var html = '<option value="">-</option>';
            $.each(resultdata,
                function (index, item) {
                    var value = options.formatterValueField(item);
                    if (value != null)
                        html += '<option value="' + value + '">';
                    else
                        html += '<option value="' + item[options.valueField] + '">';

                    var text = options.formatterTextField(item);
                    if (text != null)
                        html += text + '</option>';
                    else
                        html += item[options.textField] + '</option>';
                });
            $this.html(html);
        }
    },
    /*
     * 将指定元素下的数据序列化成json字符串
     * @param {object} options:参数集合
     */
    "HY_SerializeJsonStr": function (options) {
        var jsonobj = $(this).HY_SerializeJsonObject(options);
        return JSON.stringify(jsonobj);
    },
    /*
     * 将指定元素下的数据序列化成json对象
     * @param {object} options:参数集合
     */
    "HY_SerializeJsonObject": function (options) {
        var $input = $(this).find(":input:not(:button)");
        //配置参数
        options = $.extend({
            data: null //追加的json数据
        },
            options);

        function flag(name) {
            if (name == undefined ||
                name === "__VIEWSTATE" ||
                name === "__VIEWSTATEGENERATOR" ||
                name === "__EVENTVALIDATION")
                return false;
            else
                return true;
        }

        var obj = {};
        $input.each(function () {
            var type = this.type; //获取input控件的类型
            var name = $(this).attr("name"); //获取name属性
            var value = $(this).val(); //获取value值
            if (flag(name)) {
                if (type === "checkbox") {
                    if (this.checked) {
                        //obj[name]初始化肯定为空，找相同的name,原选的值累加起来
                        if (obj[name] != null) {
                            var formatter = $(this).attr("data-checkbox-formatter");
                            formatter = formatter == null ? "" : formatter;
                            obj[name] = obj[name] + formatter + value;
                        } else {
                            obj[name] = value;
                        }
                    }
                } else if (type === "radio") {
                    if (this.checked) {
                        obj[name] = value;
                    }
                } else if (type === "select-one") {
                    obj[name] = value;
                } else {
                    obj[name] = value;
                }
            }
        });
        //两个对象相加
        var jsonobj = $.extend(obj, options.data);
        return jsonobj;

    },
    /*
     * 将json对象绑定到指定元素的下
     * @param {object} json:json对象
     isbindExitData 已存在的内容是否绑定 0：不绑定 1:覆盖绑定
     */
    "HY_BindDataByJson": function (json,isbindExitData) {

        var $this = $(this);
        if (json == null)
            return;
        if (isbindExitData == null)
            isbindExitData = 1;


        var myObject = getMyObject(json);
        var $input = $(this).find(":input:not(:button)");
        $input.each(function () {
            var name = $(this).attr("name");
            if (name != null) {
                var type = this.type;
                //根据元素name获取与其匹配的对象属性
                var obj = myObject[name.toLowerCase()];
                if (obj != null) {
                    if (type === "select-one" && isbindExitData=="1") {
                        bindSelect($(this), obj);
                    } else if (type === "checkbox" && isbindExitData == "1") {
                        bindCheckbox($(this), obj);
                    } else if (type === "radio" && isbindExitData == "1") {
                        bindRadio($(this), obj);
                    } else {
                        if( isbindExitData=="1"){
                            $(this).val(obj.value);
                        }
                       
                    }
                }

            }
        });

        function bindCheckbox(element, obj) {
            var val = element.val(); //获取复选框的值
            var value = obj.value; //获取json中的值
            if (value === true || value === false) {
                element.prop("checked", value);
            } else {
                var formatter = element.attr("data-checkbox-formatter");
                formatter = formatter == null ? "" : formatter;
                if (formatter.length > 1) {
                    var arrayValue = value.split(formatter); //根据复选框的格式将数据分隔
                    for (var i = 0; i < arrayValue.length; i++) {
                        if (arrayValue[i] === val) {
                            element.attr("checked", "checked");
                        }
                    }
                }
               
            }
          

        }

        function bindSelect(element, obj) {
            var value = obj.value;
            $(element)
                .find("option")
                .each(function () {
                    if ($(this).val() === value + "") {
                        this.selected = true;
                        return false;
                    }
                });
        }

        function bindRadio(element, obj) {
            var val = element.val();
            var value = obj.value;
            if (value === val) {
                element.attr("checked", "checked");
            }
        }

        function getMyObject(json) {
            //将json对象中的数据包装成Object对象;属性名为小写原对象的名称(后面绑定数数据不区分name的大小写)
            var obj = {};
            for (var key in json) {
                if (json.hasOwnProperty(key)) {
                    obj[key.toLowerCase()] = { name: key, value: json[key] };
                }
            }
            return obj;
        }
    }
});

/* 
 * 20181124 连海龙增加 hy-toolbar-auto 属性事件，当按钮工具栏引用该样式。如果系统中有多个会自动隐藏
 hy-toolbar-auto
 */
$(function () {
    $(".hy-toolbar-auto>a").each(function () {
        var css = $(this).attr("class");
        if ($("." + css).length >= 2) {
            $(this).hide();
        }
    });
});
