<%@ page import="parser.ParseToCsv" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 2018/11/20
  Time: 下午6:32
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>

    <%--<meta charset="utf-8">--%>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>title</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/plugins/dropzone/basic.css" rel="stylesheet">
        <link href="css/plugins/dropzone/dropzone.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">


</head>
<body>

<div id="wrapper">

    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <span>
                            <img src="img/龙猫.png" class="img-circle" alt="img">
                        </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">青铜小姐姐</strong>
                             </span> <span class="text-muted text-xs block">管理员 <b class="caret"></b></span> </span> </a>
                        <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            <li><a href="index.jsp">登出</a></li>
                        </ul>
                    </div>
                    <div class="logo-element">
                        IN+
                    </div>
                </li>
                <li  class="active">
                    <a href="homepage.jsp"><i class="fa fa-th-large"></i> <span class="nav-label">主页</span></a>
                </li>
                <li>
                    <a href="datatable.jsp"><i class="fa fa-th-large"></i> <span class="nav-label">表格</span></a>
                </li>
                <li>
                    <a href="graph_flot.jsp"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">flot图表</span> </a>
                </li>
                <li>
                    <a href="answer.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">简单问答</span> </a>
                </li>
                <li>
                    <a href="d3.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">d3</span> </a>
                </li>
                <li >

                    <a href="gragh_label.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">graghLabel</span> </a>

                </li>
            </ul>

        </div>
    </nav>

    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li>
                        <a href="index.jsp">
                            <i class="fa fa-sign-out"></i> 退出
                        </a>
                    </li>
                </ul>

            </nav>
        </div>
        <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
                <div class="col-lg-12">
                    <div class="text-center m-t-lg">
                        <h1>
                            欢迎来到小姐姐的项目
                        </h1>
                        <small>
                            没错，ta很可爱
                        </small>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox">
                    <div class="ibox-title">
                        <h5>文件上传</h5>
                    </div>
                    <form  action="${pageContext.request.contextPath}/servlet/UploadHandleServlet"
                           class="dropzone" id="dropzoneForm" enctype="multipart/form-data" method="post">
                        <div class="ibox-content col-lg-12">
                            <div class="fallback">
                                <input name="file" type="file" multiple />
                            </div>
                        </div>
                        <%--<input class="btn btn-primary col-lg-2" type="submit" value="上传">--%>
                    </form>
                </div>

            </div>
        </div>
        <button id ="btn1" class="btn btn-primary " type="button" value="分析数据">分析数据</button>

    </div>


        <%--<div class="container-fluid">--%>
            <%--<form id="form" action="upload/insert" method="post" enctype="multipart/form-data">--%>
                <%--<div class="row form-group">--%>
                    <%--<label class="col-md-4">图片上传:</label>--%>
                    <%--<div class="col-sm-12">--%>
                        <%--<input id="input-id" name="file" multiple type="file" data-show-caption="true">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</form>--%>
        <%--</div>--%>
        <div id="page-wrapper" class="gray-bg">

        </div>


</div>

<!-- Mainly scripts -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="js/inspinia.js"></script>
<script src="js/plugins/pace/pace.min.js"></script>
<script src="js/plugins/dropzone/dropzone.js"></script>
<script>
    function uploadmass() {

       // String s=txt;
        <%--<%// ParseToCsv.parseToCsv(request.getParameter("editor"), "web_table.json");%>--%>
        <%--<%System.out.println("------");--%>
        <%--String s=request.getParameter("editor");--%>
        <%--if(s==null)--%>
            <%--System.out.println("null");--%>
        <%--else--%>
            <%--System.out.println(request.getParameter("editor"));%>--%>
       // var txt=document.getElementById("editor").value;
        //alert(txt)
    }
    <%--$("#btn1").click(function(){--%>
        <%--$.ajax({--%>
            <%--type:'POST',--%>
            <%--url:'',--%>
            <%--success:function(){--%>
                <%--var txt=document.getElementById("editor1").value;--%>
               <%--// request.setAttrubite(txt);--%>
                <%--alert(txt);--%>

                <%--<%System.out.println("--11--");--%>
                    <%--System.out.println(request.getParameter("editor"));--%>
                    <%--System.out.println(request.getParameter("editor1"));--%>
                   <%--%>--%>

            <%--}--%>
        <%--});--%>
    <%--});--%>
    $("#btn1").click(function(){
       <%ParseToCsv.parseToCsv("web/WEB-INF/upload/","web/WEB-INF/upload/csv/","upload"+new Date().getTime());%>
        alert("分析完毕");
    });


    $("#dropzoneForm").dropzone({
        paramName: "file", // The name that will be used to transfer the file
        //  maxFilesize: 2000, // MB
        <%--//url:"<%=request.getContextPath() %>/",--%>
        dictRemoveFile: "removedfile",
        addRemoveLinks:true,
        // url:"systemController.action?saveFile",
        uploadMultiple:true,
        acceptedFiles: ".doc,.txt,.docx",
        dictResponseError: '文件上传失败!',
        dictDefaultMessage: "<strong>在这里删除文件或点击上传。</strong></br>请将要上传的文件放在此处"

    });

    $("#btn1").click(function(){
        <%ParseToCsv.parseToCsv("WEB-INF/upload/","WEB-INF/upload/csv","upload"+new Date().getTime());%>
        alert("分析完毕");
    });




</script>
</body>

</html>
