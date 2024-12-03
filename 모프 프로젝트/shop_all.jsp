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
  <link rel="stylesheet" href="./css/how.css">
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
    <h1>Run into History<span>를 이용하는 분들을 위한 tip 몰아보기</span></h1>
    <div class="line"></div>
</section>

<section class="how">
    <div class="title"><span class="box">s</span>속도에 대한 집착 버리기</div>
    <div class="howContent">
        3~5km 이상을 달려야 하는데,

        50m, 100m 달리기나 매체에서 
        
        극도로 연출된 달리기 모습을 떠올리다 보니 
        
        '10km를 어떻게 달려'라는 말이
        
        나오는 것도 어떻게 보면 
        
        자연스러운 일인 것 같습니다. 하지만 오래달리기를 시작하는 분들이라면 <span class="keyword">반드시 '속도'에 대한 집착을 버리는 것이
        
        달리기의 시작</span>이라고 할 수 있습니다.
      
    </div>
    <div class="title"><span class="box">s</span>달리기도 같은 달리기가 아닙니다.</div>
    <div class="howContent">
        보통 중, 고등학교 시절에

        체육이라는 과목에 조금이라도 관심이 있는
        
        사람들이라면 아마 '인터벌' 정도는
        
        떠올릴 수도 있을 것 같습니다.
        
        
        하지만 인터벌 외에도 달리기는
        
        페이스에 따라 그 훈련의 종류가 
        
        정말 다양합니다.
        보통 대회페이스를 100% 페이스라고

기준 잡을 때 70% 이하, 90% 이하 등으로

페이스 별로 달리기 훈련을 나눕니다.


저는 이런 여러 달리기 중에서도 

초심자분들께 <span class="keyword">'조깅'</span>을 추천드리고 싶습니다.


<span class="keyword">'조깅'</span>이란 본인의 70% 이하의 속도로

달리는 달리기를 말하는데요.

일반적으로는 회복을 목적으로

하는 달리기를 말합니다.
      
    </div>
    <div class="title"><span class="box">s</span>자신의 페이스 찾기</div>
    <div class="howContent">
중급자들은 <span class="keyword">자신의 최적 페이스를 찾는 것이 중요</span>합니다. 이를 위해 평소 훈련 중 다양한 속도로 달려보고, 가장 편안하게 느껴지는 속도를 파악해야합니다.
      
    </div>
    <div class="title"><span class="box">s</span>심박수 모니터링</div>
    <div class="howContent">
     <span class="keyword">심박수를 모니터링</span>하여 적절한 페이스를 유지할 수 있습니다. 일반적으로 최대 심박수의 70%~80% 수준에서 달리는 것이 좋습니다.
    </div>
    <div class="title"><span class="box">s</span>인터벌 훈련</div>
    <div class="howContent">
    <span class="keyword">인터벌 훈련</span>을 통해 다양한 속도로 달리는 경험을 쌓을 수 있습니다. 예를 들어, 400m를 빠르게 달린 후 200m를 천천히 달리는 훈련을 반복하면 페이스 조절 능력이 향상됩니다.
    </div>

<div class="title"><span class="box">s</span>템포 러닝</div>
<div class="howContent">
<span class="keyword">템포  러닝</span>은 일정한 속도로 장거리를 달리는 훈련입니다. 이는 페이스 유지 능력을 기르는 데 도움이 됩니다. 주당 1-2회 템포러닝을 실시해 보세요
</div>
<div class="howContent">
    장거리 달리기는 체력적인 지구력뿐만 아니라 부상을 예방하고 경기력을 최적화하기 위한 적절한 준비가 필요합니다.

이 준비의 중요한 구성 요소는 포장에 부딪히기 전에 워밍업 루틴입니다.

잘 설계된 워밍업은 근육으로의 혈류를 증가시키고 관절 유연성을 향상시키며 달리기 동안 전반적인 성능을 향상시킬 수 있습니다.

​

준비운동을 시작하려면 가벼운 조깅이나 5-10분 동안 활발한 산책으로 시작하세요.

이것은 점차 심박수를 증가시키고 근육을 따뜻하게 하여 다가올 더 격렬한 운동에 대비하게 할 것입니다.

심혈관 웜업 후에는 러닝에 사용되는 주요 근육군을 타깃으로 한 역동적인 스트레칭에 집중하는 것이 중요합니다.

이러한 스트레칭은 통제된 방식으로 수행되어야 하며 실행 중에 수행할 동작을 모방해야 합니다.

​

장거리 달리기 선수들에게 특히 도움이 되는 역동적인 스트레칭에는 다리 스윙, 엉덩이 서클, 걷기 런지, 높은 무릎 등이 있습니다. 

이러한 스트레칭은 운동 범위, 유연성 및 근육 조정을 개선하는 데 도움이 되며, 이 모든 것은 효율적인 달리기 역학에 필수적입니다.
</div>
<div class="title"><span class="box">s</span>정신적 준비</div>
<div class="howContent">
    성공적인 워밍업 루틴의 또 다른 중요한 측면은 정신적 준비입니다.

    달리기 전에 잠시 시간을 내어 호흡에 집중하고 강하고 쉽게 달리는 자신의 모습을 시각화하세요.
    
    이 정신적 리허설은 특히 어려운 순간 동안 달리기 내내 집중력과 동기를 유지하는 데 도움이 될 수 있습니다.
</div>
</section>
       
</body>
</html>