<%@ page import="java.util.Map" %>
<%@ page import="hibernate_test.WebPassword" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="gray-bg">
<div class="middle-box text-center loginscreen animated fadeInDown">
    <div>
        <h3>登录</h3>
        <form class="m-t" role="form">
            <div class="form-group">
                <input type="text" class="form-control" id="login" placeholder="用户名" required="">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" placeholder="密码" required="">
            </div>
            <button type="submit" id="aaa" class="btn btn-primary block full-width m-b" onclick="pass()">登录</button>
        </form>
    </div>
</div>

<!-- Mainly scripts -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</body>

</html>
<script>
    function pass() {
        <%Map<String,String> map=WebPassword.judge();%>
        <%for(Map.Entry<String,String> entry:map.entrySet()){%>
        if(document.getElementById("login").value==<%=entry.getKey()%> &&
            document.getElementById("password").value==<%=entry.getValue()%>){
            window.open('homepage.jsp');
        }
        <%
       // String  s=(String)request.getAttribute("password");
        }
        %>


    }
    <%--$(function(){--%>

    <%--// test 的点击事件--%>
    <%--$("#aaa").click(function(){--%>
    <%--<%System.out.println("----");%>--%>

    <%--});--%>

    <%--})--%>
</script>
