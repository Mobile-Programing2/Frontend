<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://fonts.cdnfonts.com/css/harry-potter" rel="stylesheet">
    <!--구글폰트 cdn-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <!--slick cdn-->
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <link rel="stylesheet" type="text/css" href="slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <link rel="stylesheet" type="text/css"
        href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
    <!--xicon cdn-->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
   <link rel="stylesheet" href="./css/all.css">
  <link rel="stylesheet" href="./css/index.css">
  <link rel="stylesheet" href="./css/shop_easy.css">
  <!--이게 nav-->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"
  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="./nav.js"></script>
</head>
<body>
    
         <%
   
    String id = (String) session.getAttribute("sid");

    if (id != null) {
     
        String DB_URL = "jdbc:mysql://localhost:3306/run";
        String DB_ID = "run";
        String DB_PASSWORD = "1234";
        String userName = null;
  int money =0;
        try {
          
            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
            
        
            String sql = "SELECT name FROM member WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

           

           
            if (rs.next()) {
                userName = rs.getString("name");
            }
  
            rs.close();
            pstmt.close();
            con.close();
             
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (userName != null) {
  %>
	   

           <article class="topFix">
    <div>
        <ul>
        <li class="hi">안녕하세요, <span class="name"><%= userName %></span>님</li>
           <a href="mypage.jsp"> <li>마이페이지</li></a>
            <a href="cart.jsp"> <li>장바구니</li></a>
            <a href="index.jsp?logout=true"><li>로그아웃</li></a>
        </ul>
    </div>
    </article>
  <%
        }
    } else {
  %>
              <article class="topFix">
    <div>
        <ul>
          <a href="mypage.jsp"> <li>마이페이지</li></a>
           <a href="cart.jsp"> <li>장바구니</li></a>
            <a href="login.jsp"><li>로그인</li></a>
        </ul>
    </div>
    </article>
  <%
    }
  %>



  <!-- 로그아웃 처리 -->
  <%
    if ("true".equals(request.getParameter("logout"))) {
        if (session != null) {
            session.invalidate(); 
        }
        response.sendRedirect("index.jsp"); 
    }
  %>
        <header>
        <nav>
            <ul>
                <li><a href="index.jsp" class="menu_logo"><img src="./image/그림1.png"
                            class="logo">Run into History</a>
                </li>
                <li><a href="intro_company.jsp" class="menu-item" data-submenu="#homeSubmenu">Introduce</a>

                </li>
                <li><a href="shop_easy.jsp" class="menu-item" data-submenu="#servicesSubmenu">How to play</a>

                </li>
                <li><a href="shop_ganre.jsp" class="menu-item" data-submenu="#aboutSubmenu">Shop</a>

                </li>
                <li><a href="#" class="menu-item" data-submenu="#contactSubmenu">Notice</a>

                </li>
            </ul>
        </nav>
    </header>

    <div class="submenu" id="homeSubmenu">
        <a href="intro_company.jsp">- 회사소개</a><br>
        <a href="member.jsp">- 운영진</a><br>
       
    </div>

    <div class="submenu" id="servicesSubmenu">
        <a href="./shop_easy.jsp">- 초심자</a><br>
        <a href="./shop_middle.jsp">- 중급자</a><br>
        <a href="./shop_high.jsp">- 고급자</a><br>
        <a href="./shop_all.jsp">- 한번에 알아보기</a><br>
    </div>

    <div class="submenu" id="aboutSubmenu">
        <a href="./shop_ganre.jsp">- 장르별</a><br>
        <a href="./shop_time.jsp">- 시대별</a><br>
        <a href="./shop_person.jsp">- 레벨별</a><br>
       
    </div>

    <div class="submenu" id="contactSubmenu">
        <a href="#">- 공지사항</a><br>
        <a href="#">- 이벤트</a><br>
    </div>

<section class="section1">
    <h1>Run into History<span>가 추천하는 장르별 콘텐츠</span></h1>
    <div class="line"></div>
    <em>*역사적 상황들을 장르별로 모아보았습니다</em>
   
</section>
<section class="content">

 <h4>스릴러<span>역동감있는 콘텐츠를 제공합니다.</span></h4>
<% 
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  try {
    String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
    String DB_ID = "run";
    String DB_PASSWORD = "1234";
    Class.forName("org.gjt.mm.mysql.Driver");

    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // 첫 번째 쿼리: 스릴러
    String sql1 = "SELECT proNo, proName, proIntro, proImage, proPrice, proGangre, proTime, proLevel FROM product WHERE proTime LIKE '스릴%';";
    pstmt = conn.prepareStatement(sql1);
    rs = pstmt.executeQuery();

    while (rs.next()) {
      String proNo = rs.getString("proNo");
      String proName = rs.getString("proName");
      String proIntro = rs.getString("proIntro");
      String proPrice = rs.getString("proPrice");
      String proImage = rs.getString("proImage");
      String proLevel = rs.getString("proLevel");
      String proGangre = rs.getString("proGangre");
      String proTime = rs.getString("proTime");
%>
     <div class="product">
       <a href="order.jsp?proNo=<%= proNo %>" class="detail-link">
    <div class="image">
       <img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>" width="250px" height="200px">
    </div>
    <p class="proName"><%= proName %></p>
    <em class="proPrice"><%= proPrice %>원</em></a>
</div>
 <%  
 }
 %>
</section>


<section class="content">

 <h4>드라마<span>한 사람의 삶을 들여다 봅니다.</span></h4>
 <%  
    // 두 번째 쿼리: 드라마
    pstmt.close();  // 첫 번째 pstmt를 닫고
    rs.close();    

    
   String sql2 = "SELECT proNo, proName, proIntro, proImage, proPrice, proGangre, proTime, proLevel FROM product WHERE proTime LIKE '드라%';";
    pstmt = conn.prepareStatement(sql2);
    rs = pstmt.executeQuery();

    while (rs.next()) {
      String proNo = rs.getString("proNo");
      String proName = rs.getString("proName");
      String proIntro = rs.getString("proIntro");
      String proPrice = rs.getString("proPrice");
      String proImage = rs.getString("proImage");
      String proLevel = rs.getString("proLevel");
      String proGangre = rs.getString("proGangre");
      String proTime = rs.getString("proTime");
%>
       <div class="product">
         <a href="order.jsp?proNo=<%= proNo %>" class="detail-link">
    <div class="image">
       <img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>" width="250px" height="200px">
    </div>
    <p class="proName"><%= proName %></p>
    <em class="proPrice"><%= proPrice %>원</em></a>
</div>
 <%  
 }
 %>
</section>
<section class="content">

 <h4>로맨스<span> 절절한 사랑이야기를 느껴보세요.</span></h4>
 <%  
    // 세 번째 쿼리: 로로 시작하는 데이터
    pstmt.close();  // 두 번째 pstmt를 닫고
    rs.close();     // 두 번째 rs를 닫고

    String sql3 = "SELECT proNo, proName, proIntro, proImage, proPrice, proGangre, proTime, proLevel FROM product WHERE proTime LIKE '로%';";
    pstmt = conn.prepareStatement(sql3);
    rs = pstmt.executeQuery();

    while (rs.next()) {
      String proNo = rs.getString("proNo");
      String proName = rs.getString("proName");
      String proIntro = rs.getString("proIntro");
      String proPrice = rs.getString("proPrice");
      String proImage = rs.getString("proImage");
      String proLevel = rs.getString("proLevel");
      String proGangre = rs.getString("proGangre");
      String proTime = rs.getString("proTime");
%>
      <div class="product">
        <a href="order.jsp?proNo=<%= proNo %>" class="detail-link">
        <div class="image">
          <img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>" width="250px" height="200px">
        </div>
        <p class="proName"><%= proName %></p>
        <em class="proPrice"><%= proPrice %>원</em>
        </a>
      </div>
<%

    }
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    try {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
%>

</section>
       
</body>
</html>