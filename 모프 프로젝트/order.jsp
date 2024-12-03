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
    <link rel="stylesheet" href="./css/opder.css">
</head>
<body>
    <%
    String id = (String) session.getAttribute("sid");
    if (id == null) {
%>
    <script>
        alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
        location.href = "login.jsp";
    </script>
<%
        return; 
    }
%>
         <%
   
  

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

 <% 
    String proNo = request.getParameter("proNo");

    if (proNo == null || proNo.isEmpty()) {
        out.println("<p>상품 번호가 올바르지 않습니다.</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
        String DB_ID = "run";
        String DB_PASSWORD = "1234";
        Class.forName("org.gjt.mm.mysql.Driver");

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
      String sql = "SELECT proNo, proName, proIntro, proImage, proPrice, proGangre, proTime, proLevel FROM product WHERE proNo = ? ;";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, proNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
         
      String proName = rs.getString("proName");
      String proIntro = rs.getString("proIntro");
      String proPrice = rs.getString("proPrice");
      String proImage = rs.getString("proImage");
      String proLevel = rs.getString("proLevel");
      String proGangre = rs.getString("proGangre");
      String proTime = rs.getString("proTime");
    %>

<article class="order_content">
  <div class="order_image">
    <img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>" style="width: 550px; height: 500px;">
  </div>
  <div class="order_text">
    <form method="post">
      <ul>
        <li><%= proName %></li>
      
        <li><%= proIntro %></li>
         <li>Level: <%= proGangre %></li>
          <li>장르: <%= proTime %></li>
            <li>시대: <%= proLevel %></li>
        <li>가격: <span id="price"><%= proPrice %></span>원</li>
        <li>상품 수량 <input type="number" name="proQty" id="proQty" min="1" value="1" required><span class="red">(숫자만 입력)</span></li>
        <li>
          <!-- 장바구니에 담기 버튼, order.result로 이동 -->
          <input type="submit" name="action" value="장바구니에 담기" formaction="orderResult.jsp"> 
          
          <!-- 구매하기 버튼, pay.jsp로 이동 -->
          <input type="submit" name="action" value="구매하기" formaction="orderOne.jsp"> 
        </li>
      </ul>
      <input type="hidden" name="proNo" value="<%= proNo %>">
      <input type="hidden" name="Proprice" id="hiddenPrice" value="<%= proPrice %>">
      <input type="hidden" name="totalPrice" id="hiddenTotalPrice" value="<%= proPrice %>">
    </form>
  </div>
</article>

<script>
    // 수량 변경시 가격 업데이트
    $('#proQty').on('input', function() {
        var qty = $(this).val();  // 입력된 수량
        var price = $('#hiddenPrice').val();  // 상품 가격
        var totalPrice = qty * price;  // 총 가격 계산
        $('#price').text(totalPrice);  // 화면에 표시
        $('#hiddenTotalPrice').val(totalPrice);  // 숨겨진 필드에 저장
    });
</script>

<%
        } else {
            out.println("<p>해당 상품을 찾을 수 없습니다.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>상품 정보를 로드하는 중 문제가 발생했습니다.</p>");
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

       
</body>
</html>