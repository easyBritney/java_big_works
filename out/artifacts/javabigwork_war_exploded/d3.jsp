<%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 2018/12/3
  Time: 下午12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<style>

    .link {
        fill: none;
        stroke: #666;
        stroke-width: 1.5px;
    }

    #licensing {
        fill: green;
    }

    .link.licensing {
        stroke: green;
    }

    .link.resolved {
        stroke-dasharray: 0, 2;
    }

    /*circle {*/
    /*fill: #ccc;*/
    /*stroke: #333;*/
    /*stroke-width: 1.5px;*/
    /*}*/

    text {
        font: 12px Microsoft YaHei;
        pointer-events: none;
        text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, 0 -1px 0 #fff, -1px 0 0 #fff;
    }

    .linetext {
        font-size: 12px;
    }

    .links line {
        stroke: #999;
        stroke-opacity: 0.6;
    }

    .nodes circle {
        stroke: #fff;
        stroke-width: 1.5px;
    }
    div.tooltip {
        position: fixed;
        /*text-align: center;*/
        /*width: 150px;*/
        /*height: 200px;*/
        padding: 2px;
        background: lightsteelblue;
        border: 0px;
        border-radius: 8px;
        pointer-events: none;
        display:inline-block;

    }


</style>
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
                             </span> <span class="text-muted text-xs block">管理员<b class="caret"></b></span> </span> </a>
                        <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            <li><a href="#">注销</a></li>
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
                <li>
                    <a href="graph_flot.jsp"><i class="fa fa-bar-chart-o"></i> <span class="nav-label">flot图表</span> </a>
                </li>
                <li>
                    <a href="answer.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">简单问答</span> </a>
                </li>
                <li class="active">
                    <a href="d3.jsp"><i class="fa fa-diamond"></i> <span class="nav-label">d3</span> </a>
                </li>
                <li>
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
                        <a href="#">
                            <i class="fa fa-sign-out"></i> 退出
                        </a>
                    </li>
                </ul>

            </nav>
        </div>
        <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
                <div class="col-lg-2">
                    <select class="selectpicker show-tick form-control col-lg-2" id="select_picker" data-live-search="true">
                        <option>人物</option>
                        <option>案件</option>
                    </select>
                </div>
                <div class="col-lg-3">
                    <div  class="input-group">
                        <input type="text" class="form-control" id="editor" placeholder="请输入">
                        <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" id="myButton" onclick="massage()">
                                确认
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <div id="svg">

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
<script src="https://d3js.org/d3.v4.min.js"></script>


<script>
    function render(select, text) {
        d3.json("data/force.json", function (error, graph) {
            if (error) throw error;

            let local_links = [];
            let local_nodes = [];

            if(select === "" && text === ""){
                for (let i = 0; i < graph.links.length; ++i){
                    local_index = find(local_links, graph.links[i]);

                    if (local_index !== -1) {
                        if (local_links[local_index].relation.indexOf(graph.links[i].relation) === -1)
                            local_links[local_index].relation = local_links[local_index].relation + "," + graph.links[i].relation;
                    }
                    else
                        local_links.push(graph.links[i]);

                }
                local_nodes = graph.nodes;
            }
            else if(select !== "" && text === ""){
                if(select === "人物"){
                    for (let i = 0; i < graph.nodes.length; ++i){
                        if(graph.nodes[i].group === 1){
                            local_nodes.push(graph.nodes[i])
                        }
                    }
                    for (let j = 0; j < graph.links.length; ++j){
                        if(graph.links[j].relation !== "案号"){
                            local_index = find(local_links, graph.links[j]);

                            if (local_index !== -1) {
                                if (local_links[local_index].relation.indexOf(graph.links[j].relation) === -1)
                                    local_links[local_index].relation = local_links[local_index].relation + "," + graph.links[j].relation;
                            }
                            else
                                local_links.push(graph.links[j]);
                        }
                    }
                }
                else {
                    if(select === "案件"){
                        for (let i = 0; i < graph.nodes.length; ++i){
                            if(graph.nodes[i].group === 30){
                                local_nodes.push(graph.nodes[i])
                            }
                        }
                    }
                }
            }
            else if(select !== "" && text !== ""){
                if(select === "人物"){
                    for (let i = 0; i < graph.nodes.length; ++i){
                        if(graph.nodes[i].group === 1){
                            if(graph.nodes[i].id.indexOf(text) !== -1 || graph.nodes[i].crimeType.indexOf(text) !== -1 || graph.nodes[i].birth.indexOf(text) !== -1
                            || graph.nodes[i].nation.indexOf(text) !== -1 || graph.nodes[i].penalty.indexOf(text) !== -1 || graph.nodes[i].prisonType.indexOf(text) !== -1
                            || graph.nodes[i].address.indexOf(text) !== -1 || graph.nodes[i].level.indexOf(text) !== -1 || graph.nodes[i].sex.indexOf(text) !== -1)
                                local_nodes.push(graph.nodes[i])
                        }
                    }

                }

                else{
                    if(select === "案件"){
                        for (let i = 0; i < graph.nodes.length; ++i){
                            if(graph.nodes[i].group === 30){
                                if(graph.nodes[i].id.indexOf(text) !== -1 || graph.nodes[i].area.indexOf(text) !== -1 || graph.nodes[i].criminalProcura.indexOf(text) !== -1
                                || graph.nodes[i].criminalCaseTime.indexOf(text) !== -1)
                                    local_nodes.push(graph.nodes[i])
                            }
                        }
                    }
                }
            }
            else {
                local_nodes.push({
                    "id": "周莘淼",
                    "group": 1,
                    "crimeType": "犯容留他人吸毒罪",
                    "birth": "1989年03月07日",
                    "penalty": "罚金",
                    "penaltySum": "1000.0",
                    "prisonType": "拘役",
                    "prisonTime": "三个月",
                    "address": "居民",
                    "level": "初中文化",
                    "sex": "null",
                    "nation": "汉族",
                    "idCard": "null"
                },
                    {
                        "id": "（2017）浙1121刑初386号",
                        "group": 30,
                        "area": "浙江省青田县",
                        "criminalProcura": "公诉机关浙江省青田县人民检察院",
                        "criminalCaseTime": "2018年03月06日"
                    });
            }




            let link = svg.append("g")
                .attr("class", "links")
                .selectAll("line")
                .data(local_links)
                .enter().append("line")
                .style("stroke", function (d) {
                    // let lineColor;
                    // //根据关系的不同设置线条颜色
                    // if(d.rela === "上位产品" || d.rela === "上游" || d.rela ==="下位产品"){
                    //     lineColor="#A254A2";
                    // }else if(d.rela === "主营产品"){
                    //     lineColor="#B43232";
                    // }
                    return "#A254A2";
                })
                .style("pointer-events", "none")
                .style("stroke-width", 0.5)//线条粗细
                .attr("stroke-width", function (d) {
                    return Math.sqrt(d.value);
                });

            let edge_text = svg.append("g").selectAll("text")
                .data(local_links)
                //返回缺失元素的占位对象（placeholder），指向绑定的数据中比选定元素集多出的一部分元素。
                .enter()
                .append("text")
                .attr("dy", ".50em")
                .attr("text-anchor", "middle")//在圆圈中加上数据
                .style('fill', function (node) {
                    // let color;//文字颜色
                    // let link=links[node.index];
                    // if(node.name === link.source.name && link.rela === "主营产品"){
                    //     color="#B43232";
                    // }else{
                    //     color="#A254A2";
                    // }
                    return "#A254A2";
                })
                .text(function (d) {
                    return d.relation;
                });


            let node = svg.append("g")
                .attr("class", "nodes")
                .selectAll("circle")
                .data(local_nodes)
                .enter().append("circle")
                .attr("r", 50)
                .attr("fill", function (d) {
                    return color(d.group);
                })
                .style("fill", function (node) {
                    return "#F9EBF9";   //圆圈内部
                })
                .style('stroke', function (node) {
                    return "#A254A2";   //圆圈线条
                })
                .call(d3.drag()
                    .on("start", dragstarted)
                    .on("drag", dragged)
                    .on("end", dragended))
                .on("dblclick", add_data);


            function find_local(data, x) {
                for (let i = 0; i < data.length; ++i) {
                    // console.log(data[i].source.id);
                    if ((data[i].source.id === x.source && data[i].target.id === x.target) || (data[i].source.id === x.target && data[i].target.id === x.source))
                        return i;
                }
                return -1;
            }

            function find(data, x) {
                for (let i = 0; i < data.length; ++i) {
                    // console.log(data[i].source.id);
                    if ((data[i].source === x.source && data[i].target === x.target) || (data[i].source === x.target && data[i].target === x.source))
                        return i;
                }
                return -1;
            }

            function add_data(d) {
                let links = [];
                let nodes = [];
                for (let i = 0; i < graph.links.length; ++i) {
                    // console.log(graph.links[i])
                    if (graph.links[i].source === d.id || graph.links[i].target === d.id) {
                        local_index = find_local(local_links, graph.links[i]);
                        index = find(links, graph.links[i]);
                        // console.log(local_index);
                        // console.log(index);
                        if (local_index !== -1) {
                            if (local_links[local_index].relation.indexOf(graph.links[i].relation) === -1)
                                local_links[local_index].relation = local_links[local_index].relation + "," + graph.links[i].relation;
                        } else if (index !== -1) {
                            if (links[index].relation.indexOf(graph.links[i].relation) === -1)
                                links[index].relation = links[index].relation + "," + graph.links[i].relation;
                        } else
                            links.push(graph.links[i]);
                    }
                }

                for (let j = 0; j < graph.nodes.length; ++j) {
                    for (let k = 0; k < links.length; ++k) {
                        if (links[k].target === graph.nodes[j].id || links[k].source === graph.nodes[j].id) {
                            if (!local_nodes.find(function (x) {
                                return x.id === graph.nodes[j].id;
                            }))
                                nodes.push(graph.nodes[j]);
                            // console.log(graph.nodes[j])
                        }
                    }
                }

                // console.log(local_nodes);
                // console.log(nodes);

                local_links = local_links.concat(links);
                local_nodes = local_nodes.concat(nodes);

                restart();

                d3.selectAll("circle")
                    .on("mouseenter", showTip)
                    .on("mousemove", showTip)
                    .on("mouseout", hideTip);
            }


            let div = d3.select("body").append("div")
                .attr("class", "tooltip")
                .style("opacity", 0);

            d3.selectAll("circle")
                .on("mouseenter", showTip)
                .on("mousemove", showTip)
                .on("mouseout", hideTip);

            function showTip(d) {
                //定义悬浮框的位置
                div.html(setTip(d))
                    .style("left", (d3.event.pageX) + "px")
                    .style("top", (d3.event.pageY - 28) + "px");

                div.transition()
                    .duration(300)
                    .style("opacity", 0.9)
            }

            function setTip(d) {
                if(d.group === 1){
                    return "姓名:" + d.id + "<br/>" +
                            "出生日期:" + d.birth + "<br/>" +
                            "身份证:" + d.idCard + "<br/>" +
                            "性别:" + d.sex + "<br/>" +
                            "工作:" + d.address + "<br/>" +
                            "文化水平:" + d.level + "<br/>" +
                            "民族:" + d.nation + "<br/>" +
                            "罪名:" + d.crimeType + "" +
                            "刑法:" + d.prisonType + "<br/>" +
                            "受刑时间:" + d.prisonTime + "<br/>" +
                            "财产刑:" + d.penalty + "<br/>" +
                            "刑法金额:" + d.penaltySum + "<br/>"
                }else {
                    return "型号:" + d.id + "<br/>" +
                            "地区:" + d.area + "<br/>" +
                            "公诉机关:" + d.criminalProcura + "<br/>" +
                            "公诉时间:" + d.criminalCaseTime + "<br/>"
                }
            }

            function hideTip() {
                div.transition()
                    .duration(100)
                    .style("opacity", 0)
            }

            let node_text = svg.append("g").selectAll("text")
                .data(local_nodes)
                //返回缺失元素的占位对象（placeholder），指向绑定的数据中比选定元素集多出的一部分元素。
                .enter()
                .append("text")
                .attr("dy", ".50em")
                .attr("text-anchor", "middle")//在圆圈中加上数据
                .style('fill', function (node) {
                    // let color;//文字颜色
                    // let link=links[node.index];
                    // if(node.name === link.source.name && link.rela === "主营产品"){
                    //     color="#B43232";
                    // }else{
                    //     color="#A254A2";
                    // }
                    return "#A254A2";
                })
                .text(function (d) {
                    return d.id;
                });


            // node.append("title")
            //     .text(function(d) { return d.id;});

            simulation
                .nodes(local_nodes)
                .on("tick", ticked);

            simulation
                .force("link")
                .links(local_links);

            function ticked() {
                link
                    .attr("x1", function (d) {
                        return d.source.x;
                    })
                    .attr("y1", function (d) {
                        return d.source.y;
                    })
                    .attr("x2", function (d) {
                        return d.target.x;
                    })
                    .attr("y2", function (d) {
                        return d.target.y;
                    });

                node
                    .attr("cx", function (d) {
                        return d.x;
                    })
                    .attr("cy", function (d) {
                        return d.y;
                    });

                node_text
                    .attr("x", function (d) {
                        return d.x;
                    })
                    .attr("y", function (d) {
                        return d.y;
                    });

                edge_text
                    .attr("x", function (d) {
                        return (d.source.x + d.target.x) / 2;
                    })
                    .attr("y", function (d) {
                        return (d.source.y + d.target.y) / 2;
                    })
            }

            function restart() {
                link = link
                    .data(local_links)
                    .enter()
                    .append("line")
                    .style("stroke", function (d) {
                        // let lineColor;
                        // //根据关系的不同设置线条颜色
                        // if(d.rela === "上位产品" || d.rela === "上游" || d.rela ==="下位产品"){
                        //     lineColor="#A254A2";
                        // }else if(d.rela === "主营产品"){
                        //     lineColor="#B43232";
                        // }
                        return "#A254A2";
                    })
                    .style("pointer-events", "none")
                    .style("stroke-width", 0.5)//线条粗细
                    .attr("stroke-width", function (d) {
                        return Math.sqrt(d.value);
                    })
                    .merge(link);

                node = node
                    .data(local_nodes)
                    .enter()
                    .append("circle")
                    .attr("r", 50)
                    .attr("fill", function (d) {
                        return color(d.group);
                    })
                    .style("fill", function (node) {
                        return "#F9EBF9";   //圆圈内部
                    })
                    .style('stroke', function (node) {
                        return "#A254A2";   //圆圈线条
                    })
                    .merge(node).call(d3.drag()
                        .on("start", dragstarted)
                        .on("drag", dragged)
                        .on("end", dragended))
                    .on("dblclick", add_data);

                //节点描述
                node_text = node_text
                    .data(local_nodes)
                    .enter()
                    .append("text")
                    .attr("dy", ".50em")
                    .attr("text-anchor", "middle")//在圆圈中加上数据
                    .style('fill', function (node) {
                        // let color;//文字颜色
                        // let link=links[node.index];
                        // if(node.name === link.source.name && link.rela === "主营产品"){
                        //     color="#B43232";
                        // }else{
                        //     color="#A254A2";
                        // }
                        return "#A254A2";
                    })
                    .text(function (d) {
                        return d.id;
                    })
                    .merge(node_text);


                edge_text = edge_text
                    .data(local_links)
                    .enter()
                    .append("text")
                    .attr("dy", ".50em")
                    .attr("text-anchor", "middle")//在圆圈中加上数据
                    .style('fill', function (node) {
                        // let color;//文字颜色
                        // let link=links[node.index];
                        // if(node.name === link.source.name && link.rela === "主营产品"){
                        //     color="#B43232";
                        // }else{
                        //     color="#A254A2";
                        // }
                        return "#A254A2";
                    })
                    .text(function (d) {
                        return d.relation;
                    })
                    .merge(edge_text);

                edge_text = edge_text
                    .text(function (d) {
                        return d.relation;
                    });


                //加载节点
                // node.append("title")
                //     .text(function(d) { return d.id;});


                simulation
                    .nodes(local_nodes)
                    .on("tick", ticked);
                simulation
                    .force("link")
                    .links(local_links);
                simulation.alpha(0.5).restart();
            }

            svg.call(d3.zoom().scaleExtent([0.05, 8]).on('zoom', () => {
                // 保存当前缩放的属性值
                let transform = d3.event.transform;
            link.attr('transform', transform);
            node.attr("transform", transform);
            node_text.attr("transform", transform);
            edge_text.attr("transform", transform);
        })).on('dblclick.zoom', null);

            function dragstarted(d) {
                if (!d3.event.active) simulation.alphaTarget(0.3).restart();
                d.fx = d.x;
                d.fy = d.y;

            }

            function dragged(d) {
                d.fx = d3.event.x;
                d.fy = d3.event.y;
            }

            function dragended(d) {
                if (!d3.event.active) simulation.alphaTarget(0);
                d.fx = null;
                d.fy = null;
            }
        });
    }
</script>
<script>
    let width = 1650,
        height = 800;

    let svg = d3.select("body").select("#svg").append("svg")
        .attr("width", width)
        .attr("height", height);

    let color = d3.scaleOrdinal(d3.schemeCategory20);

    let simulation = d3.forceSimulation()
        .force("link", d3.forceLink().id(function (d) {
            return d.id;
        }).distance(250))
        .force("charge", d3.forceManyBody().strength(-100))
        .force("center", d3.forceCenter(width / 2, height / 2));

    render("", "")
</script>

<script>

    function massage(){
        var txt=document.getElementById("editor").value,
            select=document.getElementById("select_picker").value;
        // alert(txt+select);
        svg.selectAll("g").remove();
        render(select, txt)
        // simulation.restart()
    }
</script>
</body>
</html>
