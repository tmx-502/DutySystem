var PAGESIZE = 10;
var PAGELIST = [10, 20, 50, 100, 200]
$(function () {
    try {
        $.extend($.fn.datagrid.methods, {
            doCellTip: function (jq, params) {
                function showTip(data, td, e) {
                    if ($(td).text() == "")
                        return;
                    data.tooltip.text($(td).text()).css({
                        top: (e.pageY + 10) + 'px',
                        left: (e.pageX + 20) + 'px',
                        'z-index': $.fn.window.defaults.zIndex,
                        display: 'block'
                    });
                };
                return jq.each(function () {
                    var grid = $(this);
                    var options = $(this).data('datagrid');
                    if (!options.tooltip) {
                        var panel = grid.datagrid('getPanel').panel('panel');
                        var defaultCls = {
                            'border': '1px solid black',
                            'padding': '5px',
                            'color': 'black',
                            'background': '#f7f5d1',
                            'position': 'absolute',
                            'max-width': '350px',
                            'border-radius': '4px',
                            '-moz-border-radius': '4px',
                            '-webkit-border-radius': '4px',
                            'letter-spacing': '1px',
                            'display': 'none'
                        }
                        var tooltip = $("<div id='celltip'></div>").appendTo('body');
                        tooltip.css($.extend({}, defaultCls, params.cls));
                        options.tooltip = tooltip;
                        panel.find('.datagrid-body').each(function () {
                            var delegateEle = $(this).find('> div.datagrid-body-inner').length
                                    ? $(this).find('> div.datagrid-body-inner')[0]
                                    : this;
                            $(delegateEle).undelegate('td', 'mouseover').undelegate(
                                    'td', 'mouseout').undelegate('td', 'mousemove')
                                    .delegate('td', {
                                        'mouseover': function (e) {
                                            if (params.delay) {
                                                if (options.tipDelayTime)
                                                    clearTimeout(options.tipDelayTime);
                                                var that = this;
                                                options.tipDelayTime = setTimeout(
                                                        function () {
                                                            showTip(options, that, e);
                                                        }, params.delay);
                                            } else {
                                                showTip(options, this, e);
                                            }

                                        },
                                        'mouseout': function (e) {
                                            if (options.tipDelayTime)
                                                clearTimeout(options.tipDelayTime);
                                            options.tooltip.css({
                                                'display': 'none'
                                            });
                                        },
                                        'mousemove': function (e) {
                                            var that = this;
                                            if (options.tipDelayTime) {
                                                clearTimeout(options.tipDelayTime);
                                                options.tipDelayTime = setTimeout(
                                                        function () {
                                                            showTip(options, that, e);
                                                        }, params.delay);
                                            } else {
                                                showTip(options, that, e);
                                            }
                                        }
                                    });
                        });
                    }
                });
            }
        });
        /*-------------easy ui datagrid  -------------------------------------*/
        $(".hy-table").each(function () {
            var id = $(this).attr("id");
           $('#' + id).datagrid('doCellTip', { cls: { 'background-color': '#f5f5f5' }, delay: 500 });
          
        })
     
        //单击搜索按钮时,重新加载提示信息
        $(".hy-search-searchbutton").click(function () {
            $(".hy-table").each(function () {
                var id = $(this).attr("id");
                $('#tt').datagrid({
                    onLoadSuccess: function (data) {
                        $('#' + id).datagrid('doCellTip', { cls: { 'background-color': '#f5f5f5' }, delay: 500 });
                    }
                });


            })
        })
        $(window).resize(function () {
            $(".hy-table").each(function () {
                var id = $(this).attr("id");
                var width = $(this).width();
                //收缩引起window resize,重新计算值，并调用resize方法。 
                $('#' + id).datagrid('resize', { width: width });
                var p = $('#' + id).datagrid('getPager');
                if (p) {
                    $(p).pagination({
                        pageSize: PAGESIZE, //每页显示的记录条数，默认为15          
                        pageList: PAGELIST, //可以设置每页记录条数的列表
                        beforePageText: '第', //页数文本框前显示的汉字           
                        afterPageText: '页  共 {pages} 页',
                        displayMsg: '   共 {total} 记录',
                        onBeforeRefresh: function (pageNumer, pageSize) {
                            $(this).pagination('loading');
                            $(this).pagination('loaded');
                        }
                    });
                }
            });
        });
    } catch (e) { }
})
/**--------------------------------- 华燕扩展方法-----------------------------------------------------**/
$.fn.extend({
    /*
       序列化成json串
     * 日期:2016-07-21
     * 作者:lianhailong
     * 用法 $("#form1").HY_SerializeJsonStr();
    */
    "HY_SerializeJsonStr": function (options) {
        ////自己写的序列化
        var json = new Array();
        var $input = $(this).find("input");
        var $select = $(this).find("select");
        var $textarea = $(this).find("textarea");
        json.push("{");
        //配置参数
        options = $.extend({
            data: "",//追加的json数据
            chb_nocheckd_value: "0",//复选框未选中时初始值 默认为"0"
            select: 0//真对select获取内容 默认0获取value内容; 1:获取文本内容
        }, options);
        //返回json串
        function JsonStr(name, value) {
            try {
                var val = value + "".replace(/\"/g, '\\"');
                val = value + "".replace(/\\/g, '\\\\');
                var str = '"' + name + '"' + ':"' + val + '"';
                json.push(str);
                json.push(",");
            } catch (ex) { console.log(ex) }
        }
        function Flag(name) {
            if (name == undefined || name == "__VIEWSTATE" || name == "__VIEWSTATEGENERATOR" || name == "__EVENTVALIDATION")
                return false;
            else
                return true;
        }
        $input.each(function () {
            var type = $(this).attr("type");//获取input控件的类型
            var name = $(this).attr("name");//获取name属性
            var value = $(this).val();//获取value值
            if (Flag(name)) {
                //--------复选框------//
                if (type == "checkbox") {
                    var chk_value = "0";
                    //选中获取value中的文本,否则默认为0
                    if (this.checked) {
                        chk_value = 1;
                    } else {
                        chk_value = options.chb_nocheckd_value + "";
                    }
                    JsonStr(name, chk_value);
                }
                    //单选按钮
                else if (type == "radio") {
                    if (this.checked) {
                        JsonStr(name, value);
                    }
                }
                    //--------其他------//
                else {
                    JsonStr(name, value);
                }
            }
        });
        $select.each(function () {
            var name = $(this).attr("name");
            var value = "";
            //1获取text值
            if (options.select == 1)
                value = $(this).find("option:selected").text();
            else {
                value = $(this).val();//默认获取value值
            }
            if (Flag(name)) {
                JsonStr(name, value);
            }
        });
        $textarea.each(function () {
            var name = $(this).attr("name");
            var value = $(this).val();
            if (Flag(name)) {
                JsonStr(name, value);
            }
        });
        if (options.data != undefined && options.data != null && options.data != "") {
            //追加新数据
            for (var json_i in options.data) {
                JsonStr(json_i, options.data[json_i]);
            }
        }
        //移除最后一位
        if (json.length > 0)
            json.pop();

        //拼接最后一个括号
        if (json.length > 0)
            json.push("}");


        return json.join("");

        ////表单序列化
        //var o = {};
        //var a = this.serializeArray();
        //$.each(a, function () {
        //    if (o[this.name]) {
        //        if (!o[this.name].push) {
        //            o[this.name] = [o[this.name]];
        //        }
        //        o[this.name].push(this.value || '');
        //    } else {
        //        o[this.name] = this.value || '';
        //    }
        //});
        //return JSON.stringify(o);
    },
    /*
    通过json绑定页面上的数据
   */
    "HY_BindDataByJson": function (json) {
        var $this = $(this);
        //获取name属性值
        var nameArray = new Array();
        var $input = $this.find("input");
        $input.each(function () {
            var name = $(this).attr("name");
            if (name != undefined && name != null) {
                nameArray.push(name);
            }
        })
        var $select = $this.find("select");
        $select.each(function () {
            var name = $(this).attr("name");
            if (name != undefined && name != null) {
                nameArray.push(name);
            }
        })
        var $textarea = $this.find("textarea");
        $textarea.each(function () {
            var name = $(this).attr("name");
            if (name != undefined && name != null) {
                nameArray.push(name);
            }
        })
        //----扩展方法----
        Array.prototype.indexOf = function (val) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] == val) return i;
            }
            return -1;
        };
        Array.prototype.remove = function (val) {
            var index = this.indexOf(val);
            if (index > -1) {
                this.splice(index, 1);
            }
        };
        function IsExists(name) {
            name = name.toUpperCase();//全转换成大写
            for (var i = 0; i < nameArray.length; i++) {
                var n = nameArray[i].toUpperCase();
                if (n == name) {
                    var p = nameArray[i];
                    nameArray.remove(p);
                    return p;
                }
            }
            return null;
        }
        for (var obj in json) {
            //name为表单中的name,不区分大小写获取到
            var name = IsExists(obj);
            if (name != null) {
                Bind(name, json[obj]);
            }
        }
        //根据已知的name获取表单元素
        function Bind(key, value) {
            var $input = $this.find("input[name=" + key + "]");
            var $select = $this.find("select[name=" + key + "]");
            var $textarea = $this.find("textarea[name=" + key + "]");
            //input控件
            if ($input.length > 0) {
                if ($input.attr("type") == "checkbox") {
                    if (value != 0)
                        $input[0].checked = true;
                } else if ($input.attr("type") == "radio") {
                    $input.each(function () {
                        if ($(this).val() == value)
                            this.checked = true;
                    })
                }
                else {
                    $input.val(value);
                }
            } else if ($select.length > 0) {
                if (value != null) {
                    $select.find("option").each(function () {
                        var v = $(this).val();
                        var t = $(this).text();
                        if (v == value || t == value)
                            this.checked = true;
                    })

                }
            } else if ($textarea.length > 0) {
                $textarea.val(value);
            }
        }
    },
    /*
    /* 更改布局列数
    * 日期:2016-07-26
    * 作者:lianhailong
    * 用法 $("#edit").HY_Edit({column:2});显示两列
   */
    "HY_Edit": function (options) {
        //配置参数
        options = $.extend({
            column: 1
        }, options);
        //获取要布局的列数
        var column = options.column;
        if (column > 4)
            column = 4;
        var col1 = 0;
        var col2 = 0;
        col1 = 12 / column;
        col2 = 12 - (12 / column)
        $(this).addClass("row");
        //
        $(this).find(".hy-edit-group").each(function () {
            $(this).addClass("col-md-" + col1);
            $(this).addClass("col-sm-" + col2);
        })
    },
    /*
    清空文本框,默认选中下拉列表第一行
   */
    "HY_ClearData": function () {
        var $input = $(this).find("input");
        //清空所有文本框
        $input.each(function () {
            if ($(this).attr("type") != "button") {
                $(this).val("");
            }
        })
        //--------------select下拉列表-----------------------//
        var $select = $(this).find("select");
        //默认选中第一项
        $select.find("option:eq(0)").attr("selected", true);
        //默认选中请选择
        $select.find("option").each(function () {
            if ($(this).text().indexOf("请选择") > -1) {
                $(this).attr("selected", true);
            }
        });
        //移除验证控件的提示信息
        $(this).find(".Validform_checktip").text("");
        $(this).find(".Validform_checktip").removeClass("Validform_wrong");
        $(this).find(".Validform_checktip").removeClass("Validform_right");
    },
    /*
     通过字典绑定下拉框
    */
    "HY_BindSelectByDic": function (options) {
        var $this = $(this);
        //配置参数
        options = $.extend({
            type: "A",//A B C D
            parentId: "",//type="A"一级字典无父级 parentId=""
            selected: "",//选中项
        }, options);
        $.post("../../../Dictionary/Handler/GetDictionaryInfo.ashx", { type: options.type, parentId: options.parentId }, function (data) {
            if (data != null) {
                $.each(data.rows, function (index, item) {
                    var op = new Option();
                    op.text = item[options.type + "_Content"];
                    op.value = item[options.type + "_Id"];
                    if (op.text == options.selected || op.value == options.selected) {
                        op.selected = true;
                    }
                    $this.get(0).options.add(op)
                })
            }

        }, "json")
    },
})
/*
是否为空,True为空
*/
function IsNullOrEmpty(string) {
    if (string == undefined || string == null || string == "")
        return true;
    else
        return false;
}