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
    }

  
    String DB_URL = "jdbc:mysql://localhost:3306/run";
    String DB_USER = "run";
    String DB_PASSWORD = "1234";

 
    String name = "", pwd = "", email = "", birth = "", sex = "", citizenship = "", phoneNum = "";

    
    String orNum = "", orName = "", orPhone = "", rName = "", rPhone = "", rAddress = "", cardNo = "", cardPwd = "", bank = "", orMoney = "", orDate = "";

   
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
       
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

      
        String memberSql = "SELECT * FROM member WHERE id = ?";
        pstmt = con.prepareStatement(memberSql);
        pstmt.setString(1, id);  
        rs = pstmt.executeQuery();

       
        if (rs.next()) {
            name = rs.getString("name");
            pwd = rs.getString("pwd");
            email = rs.getString("email");
            birth = rs.getString("birth");
            sex = rs.getString("sex");
            citizenship = rs.getString("citizenship");
            phoneNum = rs.getString("phoneNum");
        }

 

        String orderSql = "SELECT * FROM paymember WHERE payNum = ?";
        pstmt = con.prepareStatement(orderSql);
        pstmt.setString(1, id);  
        rs = pstmt.executeQuery();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
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
  <link rel="stylesheet" href="./css/mypage.css">
</head>
<body>
   
         <%
   
   

    if (id != null) {
     
 
        String userName = null;
  int money =0;
        try {
          
            Class.forName("org.gjt.mm.mysql.Driver");
            
        
            String sql2 = "SELECT name FROM member WHERE id = ?";
            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, id);
            ResultSet rss = pstmt2.executeQuery();

           

           
            if (rss.next()) {
                userName = rss.getString("name");
            }
  
            rss.close();
            pstmt2.close();
             
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
    <h1>Run into History<span>마이페이지</span></h1>
    <div class="line"></div>
</section>
<section>
 <div class="mypage_intro">
     <span class="color"><%=name%></span>님, 안녕하세요.
    </div>
  </section>
  <section class="mypage_content">
    <a href="#" class="edit"><span style="color: red;">*</span>회원정보 수정</a>
    <ul>
        <li><span class="leftSpan">성함</span><span class="in"><%=name%></span></li>
        <li><span class="leftSpan">아이디</span><span class="in"><%=id%></span></li>
        <li><span class="leftSpan">비밀번호</span><span class="in"><%=pwd%></span></li>
        <li><span class="leftSpan">email</span><span class="in"><%=email%></span></li>
        <li><span class="leftSpan">birth</span><span class="in"><%=birth%></span></li>
        <li><span class="leftSpan">sex</span><span class="in"><%=sex%></span></li>
        <li><span class="leftSpan">국적</span><span class="in"><%=citizenship%></span></li>
        <li><span class="leftSpan">휴대전화</span><span class="in"><%=phoneNum%></span></li>
    </ul>
    <h1 class="payReult">결제 정보</h1>
        <% 
        
          if (rs != null) {
            while (rs.next()) {
        %>
     <p class="date"><%= rs.getString("orDate") %></p>
		   <div class="mypage_pay">
      <ul>
        <li>  <div class="content_left"><span class="pay_title">총 결제 금액</span><spqn><%= rs.getString("orMoney") %></spqn></div>  <div class="content_left"><span class="pay_title">주문번호</span><spqn><%= rs.getString("orNum") %></spqn></div> </li>
        <li> <div class="content_left"><span class="pay_title">주문자 이름</span><spqn><%= rs.getString("orName") %></spqn></div>  <div class="content_left"><span class="pay_title">주문자 전화번호</span><spqn><%= rs.getString("orPhone") %></spqn></div> </li>
        <li> <div class="content_left"><span class="pay_title">수령자 이름</span><spqn><%= rs.getString("rName") %></spqn></div>  <div class="content_left"><span class="pay_title">수령자 전화번호</span><spqn><%= rs.getString("rPhone") %></spqn></div> </li>
        <li> <div class="content_left"><span class="pay_title">수령자 주소</span><spqn><%= rs.getString("rAddress") %></spqn></div>  <div class="content_left"><span class="pay_title">카드번호</span><spqn><%= rs.getString("cardNo") %></spqn></div> </li>
        <li> <div class="content_left"><span class="pay_title">카드비밀번호</span><spqn><%= rs.getString("cardPwd") %></spqn></div>  <div class="content_left"><span class="pay_title">은행</span><spqn><%= rs.getString("bank") %></spqn></div> </li>
        

      </ul>
     
    </div>
        <% 
            }
          }
        %>
        <% 
          if (rs == null || !rs.next()) { 
        %>
          
        <% 
          }
        %>
 </section>

       
</body>
</html>