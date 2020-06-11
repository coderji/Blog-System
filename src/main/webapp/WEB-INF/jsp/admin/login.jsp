<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>博客管理</title>
    <link rel="shortcut icon" type="image/x-icon" href="/img/web-icon.png" media="screen"/>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery-3.2.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>

    <style>

        #login {
            float: left;
            height: 250px;
            width: 330px;
            margin-left: 6%;
            margin-top: 9%;
            display: inline;
            z-index: 999;
        }

        body {
            padding: 0;
            margin: 0;
        }
    </style>
    <script>
        $(function () {
            $('#myCarousel').carousel({
                interval: 2000
            })
        });
    </script>
</head>
<body>
<c:if test="${!empty error}">
    <script>
        alert("${error}");
        window.location.href = "login.html";
    </script>
</c:if>
<h2 style="text-align: center;font-family: 'Adobe 楷体 Std R';color: black">博客管理</h2>
<div style="float:right;" id="github_iframe"></div>
<div id="login">
    <div class="form-inline">

        <div class="input-group">
            <span class="input-group-addon">账号</span>
            <input type="text" class="form-control" name="id" id="adminId">
        </div>
        <br/><br/>
        <div class="input-group">
            <span class="input-group-addon">密码</span>
            <input type="password" class="form-control" name="passwd" id="passwd">
        </div>
        <br/>
        <p style="text-align: right;color: red;position: absolute" id="info"></p>

        <br/>
        <button id="loginButton" class="btn btn-primary">登陆
        </button>
    </div>
    <script>
        $("#adminId").keyup(
            function () {
                if (isNaN($("#adminId").val())) {
                    $("#info").text("提示:账号只能为数字");
                } else {
                    $("#info").text("");
                }
            }
        )
        $("#loginButton").click(function () {
            if ($("#adminId").val() === '' && $("#passwd").val() === '') {
                $("#info").text("提示:账号和密码不能为空");
            } else if ($("#adminId").val() === '') {
                $("#info").text("提示:账号不能为空");
            } else if ($("#passwd").val() === '') {
                $("#info").text("提示:密码不能为空");
            } else if (isNaN($("#adminId").val())) {
                $("#info").text("提示:账号必须为数字");
            } else {
                $.ajax({
                    type: "POST",
                    url: "/api/loginCheck",
                    data: {
                        id: $("#adminId").val(),
                        password: $("#passwd").val()
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.stateCode.trim() === "0") {
                            $("#info").text("提示:该用户不存在");
                        } else if (data.stateCode.trim() === "1") {
                            $("#info").text("提示:密码错误");
                        } else if (data.stateCode.trim() === "2") {
                            $("#info").text("提示:登陆成功，跳转中...");
                            window.location.href = "/admin/main";
                        }
                    }
                });
            }
        })
    </script>
</div>
</body>
</html>