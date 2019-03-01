
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
 <nav class="navbar navbar-default" style="border-bottom-style: solid;
    border-bottom-width: 2px;
    border-bottom-color: rgba(124, 200, 252, 0.932);">
        <div class="container-fluid">
           
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                    aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
               
            </div>

           
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                <li>
                 <a class="logolink" style="height:50px" class="navbar-brand" href="#">
                  <!--   <img class="toplogo"  style="height: 50px;"src="img/site/logo1.png" alt=""> -->
                </a>
                </li>
                    <li>
                        <a href="foreintro">平台介绍
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li>
                        <a href="forebought">我的众筹</a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">热门分类
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
						<c:forEach items="${cs}" var="c">

		                        <li>
                                 <a href="forecategory?cid=${c.id}">
		                            ${c.name}
		                        </a>
                            </li>
						</c:forEach>                     
                        
                        
                            
                            
                            

                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-right" action="foresearch" method="post">
                    <div class="form-group">
        
                        <input value="${param.keyword}" name="keyword" type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
            </div>
       
        </div>
 
    </nav>
