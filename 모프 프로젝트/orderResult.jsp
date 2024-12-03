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
    <link rel="stylesheet" href="./css/orderResult.css">
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

<%
   
    request.setCharacterEncoding("UTF-8");	
    String proNo = request.getParameter("proNo");
    String proQty = request.getParameter("proQty");

   
    if (proNo == null || proQty == null || id == null || proNo.isEmpty() || proQty.isEmpty()) {
        out.println("<p>유효성 검사 실패</p>");
        if (proNo == null || proNo.isEmpty()) {
            out.println("<p>proNo 값이 유효하지 않습니다.</p>");
        }
        if (proQty == null || proQty.isEmpty()) {
            out.println("<p>proQty 값이 유효하지 않습니다.</p>");
        }
        if (id == null || id.isEmpty()) {
            out.println("<p>userId 값이 유효하지 않습니다.</p>");
        }
        return;
    }
  Connection conn = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    String proName = null;
	String userName = null;

    try {
      
        String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
        String DB_ID = "run";
        String DB_PASSWORD = "1234";
        Class.forName("org.gjt.mm.mysql.Driver");

      
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

     
        String sqlSelect = "SELECT proName FROM product WHERE proNo = ?";
        pstmt2 = conn.prepareStatement(sqlSelect);
        pstmt2.setString(1, proNo);
        rs = pstmt2.executeQuery();

        if (rs.next()) {
            proName = rs.getString("proName");
        } else {
            out.println("<p>해당 상품 번호에 대한 상품을 찾을 수 없습니다.</p>");
            return;
        }

		String sql = "SELECT name FROM member WHERE id = ?";
           pstmt2 = conn.prepareStatement(sql);
            pstmt2.setString(1, id);
             rs = pstmt2.executeQuery();
            if (rs.next()) {
                userName = rs.getString("name");
            }
				else {
            out.println("<p>해당 이름 찾기 불가.</p>");
            return;
        }

        String sqlInsert = "INSERT INTO `order` (id, proNo, proQty) VALUES (?, ?, ?)";
        pstmt2 = conn.prepareStatement(sqlInsert);
        pstmt2.setString(1, id);  
        pstmt2.setString(2, proNo);  
        pstmt2.setString(3, proQty);

     
        int rowsInserted = pstmt2.executeUpdate();
        if (rowsInserted <= 0) {
            out.println("<p>주문 삽입 실패</p>");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>데이터베이스 처리 중 오류가 발생했습니다.</p>");
        return;
    } finally {
       
        try {
            if (rs != null) rs.close();
            if (pstmt2 != null) pstmt2.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

<section>
<div class="orderResult_wrap">
<i class="xi-check-circle-o"></i>
<p><span><%= userName %></span>님의 상품이 장바구니에 담겼습니다.</p>
<p><b><%= proName %> / 수량:<%= proQty %>개</b></p>
</div>
</section>

       
</body>
</html>