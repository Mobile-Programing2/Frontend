<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<!DOCTYPE html>
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
    } %>
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
  <link rel="stylesheet" href="./css/cart.css">

  <script>
    function removeItem(proNo) {
        if (confirm('이 상품을 장바구니에서 삭제하시겠습니까?')) {
            fetch('cart.jsp?remove=true&proNo=' + proNo, { method: 'GET' })
                .then(response => {
                    if (response.ok) {
                        alert('상품이 삭제되었습니다.');
                        location.reload(); 
                    } else {
                        alert('삭제에 실패했습니다. 다시 시도해주세요.');
                    }
                })
                .catch(error => {
                    alert('삭제 요청 처리 중 오류가 발생했습니다.');
                    console.error(error);
                });
        }
    }
</script>
</head>
<body>
   
         <%
   

    if (id != null) {




        String DB_URL = "jdbc:mysql://localhost:3306/run";
        String DB_ID = "run";
        String DB_PASSWORD = "1234";
        String userName = null;
  int money =0;
     Connection conn = null;
    PreparedStatement productStmt = null;
    PreparedStatement orderStmt = null;
    ResultSet productRs = null;
    ResultSet orderRs = null;
    int grandTotal = 0; // 총합 변수
    boolean cartEmpty = true; 
        try {
          
            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
            
        
            String sql = "SELECT name FROM member WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

           
  String orderSql = "SELECT proNo, SUM(proQty) AS totalQty FROM `order` WHERE id = ? GROUP BY proNo";
        orderStmt = con.prepareStatement(orderSql);
        orderStmt.setString(1, id);
        orderRs = orderStmt.executeQuery();

       
        String productSql = "SELECT proNo, proName, proImage, proPrice FROM product WHERE proNo = ?";
        productStmt = con.prepareStatement(productSql);

        
        if ("true".equals(request.getParameter("remove"))) {
            String proNoToRemove = request.getParameter("proNo");

           
            String deleteSql = "DELETE FROM `order` WHERE proNo = ? AND id = ?";
            try (PreparedStatement deleteStmt = con.prepareStatement(deleteSql)) {
                deleteStmt.setString(1, proNoToRemove);
                deleteStmt.setString(2, id);
                deleteStmt.executeUpdate();
                out.println("<script>alert('상품이 삭제되었습니다.');</script>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('삭제에 실패했습니다.');</script>");
            }
        }
           
            if (rs.next()) {
                userName = rs.getString("name");
            }
  
            rs.close();
            pstmt.close();
           
             
       
        
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
     else {
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
    <h1>Run into History<span>장바구니</span></h1>
    <div class="line"></div>
</section>
<section>

<div class="cart">

<p class="cart_id">장바구니</p>
<ul class="cart_name">
    <li>상품 번호</li>
    <li>상품 이름</li>
    <li>상품 이미지</li>
    <li>상품 가격</li>
    <li>상품 갯수</li>
    <li>가격</li>
    <li>취소</li>
</ul>
<%
 while (orderRs.next()) {
            String proNo = orderRs.getString("proNo");
            int totalQty = orderRs.getInt("totalQty");

       
            productStmt.setString(1, proNo);
            productRs = productStmt.executeQuery();

            if (productRs.next()) {
                String proName = productRs.getString("proName");
                String proImage = productRs.getString("proImage");
                int proPrice = productRs.getInt("proPrice");
                int totalPrice = proPrice * totalQty; 

                grandTotal += totalPrice; 

                
                cartEmpty = false;
%>

<ul class="cart_content">
    <li><%= proNo %></li>
    <li><%= proName %></li>
    <li><img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>"></li>
    <li><%= proPrice %></li>
    <li><%= totalQty %></li>
    <li><%= totalPrice %></li>
    <li><button onclick="removeItem('<%= proNo %>')"><i class="xi-close-circle-o"></i></button></li>
</ul>
<%
            }
        }
        
       
        if (cartEmpty) {
            out.println("<p>장바구니가 비었습니다.</p>");
        }

        
        if (!cartEmpty) {
%>
 <p class="grand-total">총 가격:<span class="totalSpan"> <%= grandTotal %>원</span> </p>
<%
        
     }} catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>장바구니 데이터를 불러오는 중 오류가 발생했습니다.</p>");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제 또는 정리 작업
        try {
            if (productRs != null) productRs.close();
            if (orderRs != null) orderRs.close();
            if (productStmt != null) productStmt.close();
            if (orderStmt != null) orderStmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }}

     
    
%>


<a href="pay.jsp" class="go_pay">결제하기</a>
</div>
       </section>
</body>
</html>