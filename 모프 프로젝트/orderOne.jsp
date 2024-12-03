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
    <link rel="stylesheet" href="./css/pay.css">

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
    <h1>Run into History<span>구매하기</span></h1>
    <div class="line"></div>
</section>
<section>
  
  <form action="payOkay1.jsp" method="post">
    <div class="pay_wrap">
      <h2>주문정보</h2>
      <div class="cart">
        <ul class="cart_name">
            <li>상품 번호</li>
            <li>상품 이름</li>
            <li>상품 이미지</li>
            <li>상품 가격</li>
            <li>상품 갯수</li>
            <li>가격</li>
        </ul>
<%
    String proNo = request.getParameter("proNo");  // 상품 번호를 받아옵니다.
    String name = "";
    String phoneNum = "";

    // 로그인 여부 체크
    if (id == null || id.isEmpty()) {
        out.println("<p>로그인이 필요합니다.</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement productStmt = null;
    PreparedStatement orderStmt = null;
    ResultSet productRs = null;
    int grandTotal = 0;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
        String DB_ID = "run";
        String DB_PASSWORD = "1234";
        Class.forName("org.gjt.mm.mysql.Driver");

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 사용자의 정보 가져오기
        String memberSql = "SELECT name, phoneNum FROM member WHERE id = ?";
        PreparedStatement memberStmt = conn.prepareStatement(memberSql);
        memberStmt.setString(1, id);
        ResultSet memberRs = memberStmt.executeQuery();
        if (memberRs.next()) {
            name = memberRs.getString("name");
            phoneNum = memberRs.getString("phoneNum");
        }

        // 개별 상품 정보 가져오기
        String productSql = "SELECT proNo, proName, proImage, proPrice FROM product WHERE proNo = ?";
        productStmt = conn.prepareStatement(productSql);
        productStmt.setString(1, proNo);
        productRs = productStmt.executeQuery();

        if (productRs.next()) {
            String proName = productRs.getString("proName");
            String proImage = productRs.getString("proImage");
            int proPrice = productRs.getInt("proPrice");

            // 넘어온 수량(proQty) 값 받기
            String proQtyStr = request.getParameter("proQty");
            int proQty = 1; // 기본 값은 1
            if (proQtyStr != null && !proQtyStr.isEmpty()) {
                proQty = Integer.parseInt(proQtyStr); // 수량을 숫자로 변환
            }

            // 총 가격 계산
            int totalPrice = proPrice * proQty;
            grandTotal = totalPrice; // 총 가격은 상품 가격 * 수량

%>


  <ul class="cart_content">
            <li><%= proNo %></li>
            <li><%= proName %></li>
            <li><img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>"></li>
            <li><%= proPrice %></li>
            <li><%= proQty %></li>
            <li><%= totalPrice %></li>
        </ul>


<% 
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>상품 정보를 불러오는 중 오류가 발생했습니다.</p>");
    } finally {
        try {
            if (productRs != null) productRs.close();
            if (productStmt != null) productStmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

  </div>

      <input type="hidden" name="name" value="<%= name %>">
      <input type="hidden" name="phoneNum" value="<%= phoneNum %>">
 <input type="hidden" name="grandTotal" value="<%= grandTotal %>">
<div class="pay">
  <h2>주문자 정보</h2>
    <div class="pay_content">
        <ul>
            <li>이름</li>
            <li><%= name%></li>
        </ul>
        <ul>
            <li>휴대폰 번호</li>
            <li><%= phoneNum%></li>
        </ul>
    </div>
    <h2>수령인 정보</h2>
    <div class="pay_content2">
        <ul>
            <li>이름</li>
            <li><input type="text" placeholder="수령인 이름을 입력하세요" name="rName"></li>
        </ul>
        <ul>
            <li>휴대폰 번호</li>
            <li><input type="text" placeholder="수령인 휴대폰 번호를 입력하세요" name="rPhone"></li>
        </ul>
        <ul >
            <li>주소</li>
            <li><input type="text" placeholder="수령인 주소를 입력하세요" name="rAddress"></li>
        </ul>
</div>
        <h2>결제 정보</h2>
        <div class="pay_content3">
            <ul>
                <li>신용카드</li>
                <li><input type="text" placeholder="카드 번호을 입력하세요" name="cardNo"></li>
            </ul>
            <ul>
                <li>비밀번호</li>
                <li><input type="password" placeholder="카드 비밀번호를 입력하세요"  name="cardPwd"></li>
            </ul>
          
    </div>
    <div class="pay_card">
        <ul>
            <li>무통장 입금</li>
            <li><select name="bank">
                <option value="카드결제로 진행" selected>다음 중 선택</option>
                <option value="우리은행">우리은행 ( 324-01-123400 / (주)남서울멀티쇼핑몰)</option>
                <option value="국민은행">국민은행 ( 011-02-300481 / (주)남서울멀티쇼핑몰)</option>
                <option value="외환은행">외환은행 ( 327-56-333002 / (주)남서울멀티쇼핑몰)</option>
                <option value="신한은행">신한은행 ( 987-25-202099 / (주)남서울멀티쇼핑몰)</option>
                <option value="하나은행">하나은행 ( 698-00-222176 / (주)남서울멀티쇼핑몰)</option>
            </select></li>
        </ul>
      </div>
      <input type="submit" value="결제하기">
</div>
</div>
    </div>
  </form>
 
</body>

</html>
