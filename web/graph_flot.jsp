<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hibernate_test.PrisonerManager" %>
<%@ page import="java.util.Map" %>
<%@ page import="hibernate_test.DrugManager" %>
<%@ page import="hibernate_test.CrimeManager" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>title</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
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
                <li >
                    <a href="homepage.jsp"><i class="fa fa-th-large"></i> <span class="nav-label">主页</span></a>
                </li>
                <li>
                    <a href="datatable.jsp"><i class="fa fa-th-large"></i> <span class="nav-label">表格</span></a>
                </li>
                <li class="active">
                    <a href="graph_flot.jsp"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">flot图表</span> </a>
                </li>
                <li>
                    <a href="answer.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">简单问答</span> </a>
                </li>
                <li>
                    <a href="d3.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">d3</span> </a>
                </li>
                <li >
                    <a href="gragh_label.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">label图表</span> </a>
                </li>
            </ul>

        </div>
    </nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li>
                        <span class="m-r-sm text-muted welcome-message">小姐姐的世界</span>
                    </li>
                    <li>
                        <a href="index.jsp">
                            <i class="fa fa-sign-out"></i> 退出
                        </a>
                    </li>
                </ul>

            </nav>
        </div>
        <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-lg-10">
                <h2>图表</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="index.html">主页</a>
                    </li>
                    <!--<li>-->
                    <!--<a>图表</a>-->
                    <!--</li>-->
                    <li class="active">
                        <strong>Chart</strong>
                    </li>
                </ol>
            </div>
        </div>
        <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
                <div class="col-lg-6">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>2018年案件数量分布</h5>
                        </div>
                        <div class="ibox-content">
                            <div>
                                <canvas id="lineChart" height="140"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>2018年犯罪年龄分布条形图</h5>
                        </div>
                        <div class="ibox-content">
                            <div>
                                <canvas id="barChart" height="140"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>2018年毒品分布图</h5>

                        </div>
                        <div class="ibox-content">
                            <div>
                                <canvas id="doughnutChart" height="140"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>


</div>


<!-- 主要的脚本 -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- 自定义和插件javascript -->
<script src="js/inspinia.js"></script>
<script src="js/plugins/pace/pace.min.js"></script>
<!-- ChartJS-->
<script src="js/plugins/chartJs/Chart.min.js"></script>
<script >

    $(function () {
        var lineData = {
            labels: ["1月", "2月", "3月", "4月", "5月", "6月", "7月","8月", "9月", "10月", "11月", "12月"],
            datasets: [
                {
                    label: "案件数量",
                    backgroundColor: 'rgba(26,179,148,0.5)',
                    borderColor: "rgba(26,179,148,0.7)",
                    pointBackgroundColor: "rgba(26,179,148,1)",
                    pointBorderColor: "#fff",
                    <%Map<Integer,Integer> map2=CrimeManager.loadMouthCrime();%>
                    data: [<%=map2.get(1)%>,<%=map2.get(2)%>, <%=map2.get(3)%>,
                        <%=map2.get(4)%>,<%=map2.get(5)%>,<%=map2.get(6)%>,
                        <%=map2.get(7)%>,<%=map2.get(8)%>,<%=map2.get(9)%>,
                        <%=map2.get(10)%>, <%=map2.get(11)%>,<%=map2.get(12)%>]
                }
            ]
        };
        var lineOptions = {
            responsive: true
        };


        var ctx = document.getElementById("lineChart").getContext("2d");
        new Chart(ctx, {type: 'line', data: lineData, options:lineOptions});

        var barData = {
            labels: ["20岁以下", "20~30岁", "30~40岁", "40~50岁","50~60岁","60岁以上"],
            datasets: [
                {
                    label: "数量",
                    backgroundColor: 'rgba(26,179,148,0.5)',
                    borderColor: "rgba(26,179,148,0.7)",
                    pointBackgroundColor: "rgba(26,179,148,1)",
                    pointBorderColor: "#fff",
                    <%PrisonerManager prisonerManager=new PrisonerManager();
                    Map<String,Integer>  map=prisonerManager.loadPrisonersAge();
                    %>
                    data: [<%=map.get("20岁以下")%>,<%=map.get("20~30岁")%>,<%=map.get("30~40岁")%>,
                        <%=map.get("40~50岁")%>, <%=map.get("50~60岁")%>,<%=map.get("60岁以上")%>]
                }
            ]
        };

        var barOptions = {
            responsive: true
        };


        var ctx2 = document.getElementById("barChart").getContext("2d");
        new Chart(ctx2, {type: 'bar', data: barData, options:barOptions});


        var doughnutData = {
            labels: ["甲基苯丙胺(g)","冰毒(g)","海洛因(g)"],
            datasets: [{
                <%Map<String,Float> map1=DrugManager.loadAllDrugWeigh();
                %>
                data: [<%=map1.get("甲基苯丙胺")%>,<%=map1.get("冰毒")%>,<%=map1.get("海洛因")%>],
                backgroundColor: ["#a3e1d4","#dedede","#b5b8cf"]
            }]
        } ;
        var doughnutOptions = {
            responsive: true
        };


        var ctx4 = document.getElementById("doughnutChart").getContext("2d");
        new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});
    });
</script>

</body>

</html>
