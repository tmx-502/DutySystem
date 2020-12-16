/// <reference path="jquery-3.5.1.js" />
/// <reference path="../Scripts/layer.js" />

/**
  * 弹出提示框
  * @method Alert
  * @param { String } content 提示文本
  * @param { int } ico 显示图标 ico:1 √ ico:2 X ico:3 ? ico:4 锁 ico:5 哭脸 ico:6 笑脸 ico:7 !
  * @param { Boolean } isParent 是否在父级显示
*/
function Alert(content, ico, isParent, callback) {
    if (ico == null || ico == "")
        ico = 1;
    if (isParent) {
        parent.layer.alert(content, {
            title: '提示',
            icon: ico,
            skin: 'layer-ext-moon'
        }, function (index) {
            if (typeof (callback) == 'function') {
                callback();
            }

            parent.layer.close(index);
        });
    } else {
        layer.alert(content, {
            title: '提示',
            icon: ico,
            skin: 'layer-ext-moon'
        }, function (index) {
            if (typeof (callback) == 'function') {
                callback();
            }

            layer.close(index);
        });
    }
}

/**
  * 弹出消息框
  * @method Msg
  * @param { String } content 提示文本
  * @param { Boolean } isParent 是否在父级显示
*/
function Msg(content, isParent) {
    if (isParent) {
        parent.layer.msg(content);
    } else {
        layer.msg(content);
    }
}

/**
  * 弹出消息框并跳转页面
  * @method AlertAndGo
  * @param { String } content 提示文本
  * @param { String } url 跳转URL
*/
function AlertAndGo(content, url) {
    layer.msg(content, function () {
        window.location.href = url;
    });
}

/**
  * 弹出确认框
  * @method ConfirmWindow
  * @param { String } content 提示文本
  * @param { function } callback 回调函数
*/
function ConfirmWindow(msg, callback) {
    layer.confirm(msg, {
        btn: ['确定', '取消'],
        icon: 3
    }, function (index) {
        if (typeof (callback) == "function")
            callback();
        layer.close(index);
    });
}

/**
  * 弹出窗口
  * @method createWindw
  * @param { Object } options 参数对象
  * @returns {int} 窗口索引
*/
function createWindw(userOptions) {
    /// <summary>创建弹出窗口</summary>
    /// <param name="options" type="Object">参数对象</param>
    /// <returns type="Number">窗口索引</returns>
    var defaultOptions = {
        type: 1, //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: "操作窗口",
        content: "",
        scrollbar: false,
        closeBtn: 1,
        maxmin: false,
        fix: true,
        area: 'auto',
        success: null
    }
    $.extend(defaultOptions, userOptions);

    var index = layer.open(defaultOptions);
    return index;
}

function loading(userOptions) {
    var defaults = {
        msg: "正在加载...",        
        area: '120px',
        shadeOpacity: 0.3,
        bgColor: '#000000'
    };

    $.extend(defaults, userOptions);

    var index = layer.msg(defaults.msg, {
        shade: [defaults.shadeOpacity, defaults.bgColor],
        time: 0,
        area: defaults.area,
    });

    return index;
}

function loaded(index) {
    layer.close(index);
}