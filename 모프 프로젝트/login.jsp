<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="./css/login.css">
	 <link rel="stylesheet" href="./css/main.css">
	 <link rel="stylesheet" href="./css/all.css">
    
</head>
<body>
    <%
        String message = null; 
        boolean isLoggedIn = false;
        String redirectPage = "login.jsp";

     
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");

        if (id != null && pass != null) {
         
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            

         
              
                String DB_URL = "jdbc:mysql://localhost:3306/run";
                String DB_ID = "run";
                String DB_PASSWORD = "1234";
                Class.forName("org.gjt.mm.mysql.Driver");
               Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            
                String sql = "SELECT * FROM member WHERE id = ?";  
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, id);
                rs = pstmt.executeQuery();

                if (rs.next()) { 
                   
                    if (pass.equals(rs.getString("pwd"))) { 
                       
					   redirectPage="index.jsp";
					   isLoggedIn=true;

                    } else {
                      
                        message = "비밀번호가 일치하지 않습니다.";
                    }
                } else {
                   
                    message = "존재하지 않는 ID입니다.";
                }
            } 
        
    %>

    <% if (isLoggedIn) { %>
     
		
       <%   session.setAttribute("sid", id); 
		   response.sendRedirect("index.jsp"); %>" />
    <% } else { %>
      
        <div id="wrap">
           <a href="index.jsp" class=""><img src="./image/그림1.png"
                            class=""><span class="logotext">Run into History</span></a>
            <form action="login.jsp" method="post">
                <ul class="input">
                    <li>
                        <input type="text" name="id" placeholder="아이디를 입력하세요" required>
                    </li>
                    <li>
                        <input type="password" name="pass" placeholder="비밀번호를 입력하세요" required>
                    </li>
                    <li>
                        <input type="submit" value="로그인">
                    </li>
                </ul>
				 <ul class="find">
            <li><a href="join.jsp">회원가입</a></li>|
            <li><a href="#">아이디 찾기</a></li>|
            <li><a href="#">비밀번호 찾기</a></li>
        </ul>
            </form>
            <% if (message != null) { %>
                <p style="color:red;"><%= message %></p>
            <% } %>
        </div>
    <% } %>
</body>
</html>
