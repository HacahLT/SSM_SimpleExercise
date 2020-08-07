<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <%-- 不以斜杠开头的是相对路径，以当前资源位基准
         以/开头的一服务器作为基准，即是http://aaaaa.com/,加上项目路径request.getContextPath()。
    --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%-- 引入样式 --%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 添加员工的模态框Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="EmpName" class="form-control" id="empName_add_input"
                                   placeholder="EmpName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_input1" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_input2" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改员工的模态框Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static">xxxx</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input1" value="男" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input2" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<%-- 搭建显示页面 --%>
<div class="container">
    <%-- 标题 --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>

    </div>

    <%-- 功能按钮 --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="empAddModal_button">新增</button>
            <button type="button" class="btn btn-danger" id="empDeleteAll_button">删除</button>
        </div>
    </div>

    <%-- 表格 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>id</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%-- 页面按钮 --%>
    <div class="row">
        <%-- 分页信息 --%>
        <div class="col-md-6" id="pages_info">

        </div>
        <%-- 分页条 --%>
        <div class="col-md-6" id="pages_nav">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                </ul>
            </nav>
        </div>
    </div>


</div>

<script type="text/javascript">
    //页面加载完成之后，直接发送AJAX请求
    $(function () {
        ajax_req(1);
    });

    //解析员工数据的方法
    function bulid_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //alert(item.empName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            //按钮
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑");
            //为按钮添加edit-id属性
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button class='btn btn-danger btn-sm del_btn'></button>")
                .append("<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>删除");
            //为删除按钮添加属性
            delBtn.attr("del-id", item.empId);
            var Btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(Btn)
                .appendTo("#emps_table tbody");
        })
    }

    //解析分页数据的方法

    var currentPageNum;

    //信息
    function build_pages_info(result) {
        $("#pages_info").empty();
        var pageInfo = result.extend.pageInfo
        $("#pages_info").append("当前是第" + pageInfo.pageNum + "页,总共有" + pageInfo.pages + "页,总共有" + pageInfo.total + "记录。")
        currentPageNum = pageInfo.pageNum;
    }

    //分页条
    function bulid_pages_nav(result) {
        //先清空原来数据
        $("#pages_nav > nav > ul").empty();

        var pageInfo = result.extend.pageInfo;
        //首页
        $("#pages_nav > nav > ul").append("<li><a href='javascript:ajax_req(1)'>首页</a></li>");

        //上一页
        var pageNum = pageInfo.pageNum;
        var preNum = pageNum - 1
        if (pageInfo.hasPreviousPage) {
            var pre = '<li>\n' +
                '                        <a href="javascript:ajax_req(' + preNum + ')“ aria-label="Previous">\n' +
                '                            <span aria-hidden="true">&laquo;</span>\n' +
                '                        </a>\n' +
                '                    </li>'
            $("#pages_nav > nav > ul").append(pre);
        } else {
            var pre = '<li class="disabled">\n' +
                '                        <a href="#“ aria-label="Previous">\n' +
                '                            <span aria-hidden="true">&laquo;</span>\n' +
                '                        </a>\n' +
                '                    </li>'
            $("#pages_nav > nav > ul").append(pre);
        }

        //每一页
        $.each(pageInfo.navigatepageNums, function (n, v) {
            if (pageNum == v) {
                var li = $("#pages_nav > nav > ul").append(' <li class="active"><a href="javascript:ajax_req(' + v + ')">' + v + '</a></li>');
            } else {
                var li = $("#pages_nav > nav > ul").append(' <li><a href="javascript:ajax_req(' + v + ')">' + v + '</a></li>');
            }
        })

        //下一页
        var nextNum = pageNum + 1
        if (pageInfo.hasNextPage) {
            var next = '<li>\n' +
                '                        <a href="javascript:ajax_req(' + nextNum + ')" aria-label="Next">\n' +
                '                            <span aria-hidden="true">&raquo;</span>\n' +
                '                        </a>\n' +
                '                    </li>'
            var next_e = $("#pages_nav > nav > ul").append(next);
        } else {
            var next = '<li class="disabled">\n' +
                '                        <a href="#" aria-label="Next">\n' +
                '                            <span aria-hidden="true">&raquo;</span>\n' +
                '                        </a>\n' +
                '                    </li>'
            var next_e = $("#pages_nav > nav > ul").append(next);
        }

        //尾页
        $("#pages_nav > nav > ul").append("        <li><a href=\"javascript:ajax_req(" + pageInfo.pages + ")\">尾页</a></li>");
    }

    //发送ajax请求
    function ajax_req(pageNum) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pageNum,
            type: "get",
            success: function (result) {
                //console.log(result);

                //1.解析员工数据
                bulid_emps_table(result);
                //2.解析分页数据
                build_pages_info(result);
                bulid_pages_nav(result);

                //刷新总复选框的状态
                $("#check_all").prop("checked", false);
            }
        })
    };


    //点击新增
    $("#empAddModal_button").click(function () {
        //发送ajax，查出部门信息，显示部门信息。
        getDept("#empAddModal select");
        var empName = $("#empName_add_input").val();
        NameUsed(empName);
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        })
    });

    //查询所有部门,显示。
    function getDept(ele) {
        //清空,避免遗留
        $(ele).empty();
        $.get("${APP_PATH}/depts", function (data) {
                //console.log(data);
                var optionEle;
                $.each(data.extend.depts, function (i, v) {
                    optionEle = "<option value='" + v.deptId + "'>" + v.deptName + "</option>" + optionEle;
                })
                $(ele).html(optionEle);
            }
        )
    }


    //校验表单
    //记录检测是否通过变量
    var empNameBol;
    //1.empName的检验，失去焦点检测用户名是否存在
    $("#empName_add_input").blur(function () {
        var empName = this.value;
        NameUsed(empName);
    });

    function NameUsed(empName) {
        if (empName == "" || empName == null) {
            return false;
        }
        $.get(
            "${APP_PATH}/checkUserName",
            "empName=" + empName,
            function (data) {
                if (data.stat) {
                    //可用
                    view_cha_inp($("#empName_add_input"), "success");
                    empNameBol = true;
                    $("#emp_save_btn").attr("ajax-val", "success")
                } else {
                    //不可用
                    view_cha_inp($("#empName_add_input"), "fail", data.extend.val_msg);
                    empNameBol = false;
                    $("#emp_save_btn").attr("ajax-val", "error")
                }
            }
        );
    }


    function vaildata_add_form() {
        //校验empName
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("请输入6-16英文或者2-5个中文");
            view_cha_inp($("#empName_add_input"), "fail", "请输入6-16英文或者2-5个中文");
            return false;
        } else {
            view_cha_inp($("#empName_add_input"), "success");
        }

        //校验邮箱
        var empMail = $("#email_add_input").val();
        var regMail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!regMail.test(empMail)) {
            //alert("邮箱格式错误，请修改格式。");
            view_cha_inp($("#email_add_input"), "fail", "邮箱格式错误，请修改格式。");
            return false;
        } else {
            view_cha_inp($("#email_add_input"), "success",);
        }
        return true;

    }

    //检验处理方法,显示信息
    function view_cha_inp(ele, stat, msg) {
        ele.parent().removeClass("has-error has-success");
        //成功的操作
        if ("success" == stat) {
            ele.parent().children("span").empty();
            ele.parent().addClass("has-success");
        }
        //不成功的操作
        if ("fail" == stat) {
            ele.parent().children("span").empty();
            ele.parent().addClass("has-error");
            ele.parent().append("<span id=\"helpBlock2\" class=\"help-block\">" +
                "" + msg + "" +
                "</span>")
        }
    }

    //给模态框的保存按钮绑定单击事件
    $("#emp_save_btn").click(function () {
        //0.验证数据
        if (!vaildata_add_form() || !empNameBol) {
            //除去样式
            $("#empName_add_input").parent().removeClass("has-error has-success");
            return false;
        }
        /*if ($(this).attr("ajax-val")=="error") {
            return false;
        }*/
        //1.模态框的数据提交
        $.post("${APP_PATH}/emp", $("#empAddModal form").serialize(), function (data) {
            //alert(data.msg);
            //判断员工信息保存是否成功
            if (data.stat) {
                //保存成功
                //1.关闭模态框
                $('#empAddModal').modal('hide');
                //2.跳转到最后页
                ajax_req(999999999);//超过的数据会跳到最后一页。
                //3.弹出成功页面
                $("body").prepend("<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                    "    <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                    "    <strong>保存成功!</strong> 请查看下面表格数据\n" +
                    "</div>");
            } else {
                //显示失败信息
                //console.log(data);
                if (undefined != data.extend.errorfields.empName) {
                    //显示名称错误信息
                    view_cha_inp($("#empName_add_input"), "fail", data.extend.errorfields.empName);
                }
                if (undefined != data.extend.errorfields.email) {
                    //显示邮箱错误信息
                    view_cha_inp($("#email_add_input"), "fail", data.extend.errorfields.email);
                }
            }

        })
    });

    //删除按钮
    $(document).on("click", ".del_btn", function () {
        //1.弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if (confirm("确认删除【" + empName + "】吗？")) {
            //确认，发送ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (data) {
                    alert(data.msg);
                    //跳转页面
                    ajax_req(currentPageNum);
                }
            })
        }

    });


    //更新按钮，因为进行绑定按钮还在加载，所以不能直接click绑定单击事件。可使用on
    $(document).on("click", ".edit_btn", function () {
        //1.查出员工和部门信息
        getDept('#empUpdateModal select')
        getEmp($(this).attr("edit-id"));
        //2.把员工id传递到更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //3.弹出模态框展示数据
        $('#empUpdateModal').modal({
            backdrop: 'static'
        })

    });

    //查询员工信息
    function getEmp(id) {
        $.get(
            "${APP_PATH}/emp/" + id,
            function (data) {
                var empl = data.extend.emp;
                //显示名字
                $("#empName_update_static").html(empl.empName)
                //显示邮箱
                $("#email_update_input").val(empl.email)
                //展示性别
                if ("男" == empl.gender) {
                    $("#gender_update_input2")[0].removeAttribute("checked");
                    $("#gender_update_input1").attr("checked", "checked");
                } else if ("女" == empl.gender) {
                    $("#gender_update_input1")[0].removeAttribute("checked");
                    $("#gender_update_input2").attr("checked", "checked");
                }
                //选择员工所属部门
                $("#empUpdateModal select").val([empl.department.deptId]);
            }
        )
    }

    //点击更新按钮，更新员工信息。
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var empMail = $("#email_update_input").val();
        var regMail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!regMail.test(empMail)) {
            //alert("邮箱格式错误，请修改格式。");
            view_cha_inp($("#email_update_input"), "fail", "邮箱格式错误，请修改格式。");
            return false;
        } else {
            view_cha_inp($("#email_update_input"), "success",);
        }

        //发送ajax请求
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "POST",
            data: $("#empUpdateModal form").serialize() + "&_method=PUT",
            success: function (data) {
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.回到页面
                ajax_req(currentPageNum);
            }
        });
    });


    //全选和全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //全部选完，总按钮也选。
    $(document).on("click", ".check_item", function () {
        //判断当前选择的数量是否为一页的数量
        if ($(".check_item").length == $(".check_item:checked").length)
            $("#check_all").prop("checked", true);
        else
            $("#check_all").prop("checked", false);
    });

    //点击删除按钮，批量删除
    $("#empDeleteAll_button").click(function () {
        var empNames = "";
        var ids = "";
        $.each($(".check_item:checked"),function (index,value) {
            //empName字符串
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //id字符串
            ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的逗号
        empNames = empNames.substring(0,empNames.length-1);
        //去除多的”-“符号
        var del_ids = ids.substring(0,ids.length-1);
        if (confirm("确认删除【"+empNames+"】吗")) {
            //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+del_ids,
                type:"DELETE",
                success:function (data) {
                    alert(data.msg);
                    //跳转到当前页面
                    ajax_req(currentPageNum);
                }
            });
        }
    });




</script>

</body>
</html>
