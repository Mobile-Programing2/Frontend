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
  <link rel="stylesheet" href="./css/member.css">
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
    <h1>Run into History<span class="com">의 운영진을 소개합니다.</span></h1>
   <div class="line"></div>
</section>
<section class="section1">
   <article class="intro_box">
    <div class="intro_title">- 최원철</div>
   남서울대를 우수한 성적으로 졸업하고 하버드 교수를 역임</br>
   SamSung으로 들어가 우수 개발진으로 스마트폰 개발 - s55</br>
   엄청난 돈을 벌며 재벌가가 되어 트럼프 대신 미국 대통령 당선</br>
</article>

<article class="intro_box2">
    <div class="intro_title">오승찬</div>
  남서울대 자퇴 후 스탠포드 대학교로 편입</br>
  아마존 CEO가 되어 전 세계 배달을 관리함</br>
  배달일을 직접 뛰어다니다가 Run into History 아이디어 제공</br>

</article>
<article class="intro_box2">
    <div class="intro_title">김다원</div>
카카오로 들어가 사장자리에 까지 오름</br>
배달의 민족 사장자리 같이 오름</br>
만수르와 같이 산책하며 이 프로젝트에 참여하게 되었음</br>
  
</article>
<article class="intro_box2">
    <div class="intro_title">이용주</div>
이런 좋은 친구를 잘 둔 덕분에 갑자기 재벌 등극</br>
삼성가 일가에서 양자로 들일려고 했으나 성주 이씨 28대손을 포기못하여 포기</br>
트럼프도 양자 제안을 했지만 원철이가 대통령이 되었기에 거절함</br>
  
</article>

</section>

</body>
</html>