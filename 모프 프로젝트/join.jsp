<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        request.setCharacterEncoding("UTF-8"); 
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String birth = request.getParameter("birth");
        String sex = request.getParameter("sex");
        String citizenship = request.getParameter("citizenship");
        String phoneNum = request.getParameter("phoneNum");

        if (id != null && pwd != null && email != null && name != null &&
            birth != null && sex != null && citizenship != null && phoneNum != null &&
            !id.isEmpty() && !pwd.isEmpty() && !name.isEmpty() && !birth.isEmpty() && 
            !sex.isEmpty() && !citizenship.isEmpty() && !phoneNum.isEmpty()) {

             String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";  
            String DB_ID = "run";  
            String DB_PASSWORD = "1234";

            try {
                Class.forName("org.gjt.mm.mysql.Driver");

                try (Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD)) {
                    String query = "INSERT INTO member (id, pwd, email, name, birth, sex, citizenship, phoneNum) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    
                    try (PreparedStatement pstmt = con.prepareStatement(query)) {
                        pstmt.setString(1, id);
                        pstmt.setString(2, pwd);
                        pstmt.setString(3, email);
                        pstmt.setString(4, name);
                        pstmt.setString(5, birth);
                        pstmt.setString(6, sex);
                        pstmt.setString(7, citizenship);
                        pstmt.setString(8, phoneNum);

                        int result = pstmt.executeUpdate(); 
                        if (result > 0) {
                            out.println("<script>alert('회원가입 성공!'); location.href='login.jsp';</script>");
                        } else {
                            out.println("<script>alert('회원가입 실패. 다시 시도하세요.'); history.back();</script>");
                        }
                    }
                } catch (SQLException e) {
                    out.println("<script>alert('SQL 오류 발생: " + e.getMessage() + "'); history.back();</script>");
                }
            } catch (ClassNotFoundException e) {
                out.println("<script>alert('MySQL 드라이버 로드 오류: " + e.getMessage() + "'); history.back();</script>");
            }
        } else {
            out.println("<script>alert('모든 필드를 입력하세요.'); history.back();</script>");
        }
    }
%>

<head>
    <meta charset="utf-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="./css/join.css">
 <link rel="stylesheet" href="./css/all.css">
    <script src="https://kit.fontawesome.com/380516ad29.js" crossorigin="anonymous"></script>
</head>
<body>
    <div id="wrap">
        <form action="join.jsp" method="post">
          <a href="index.jsp"><img src="./image/그림1.png"></a>
            <div class="intro">
                <h2><span style="color: #2e228a;">Run into History</span>에 오신 여러분들을 환영합니다!</h2>
            </div>

            <ul class="section1">
                <li>
                    <i class="fa-regular fa-user icon"></i>
                    <input type="text" name="id" class="id base" placeholder="아이디" required>
                </li>
                <li>
                    <i class="fa-solid fa-lock icon"></i>
                    <input type="password" name="pwd" class="pwd base" placeholder="비밀번호" required>
                </li>
                <li>
                    <i class="fa-regular fa-envelope icon"></i>
                    <input type="text" name="email" class="mail base" placeholder="[선택] 이메일주소 (비밀번호 찾기 등 본인 확인용)">
                </li>
            </ul>
            <ul class="error"></ul>
            <ul class="section1 two">
                <li>
                    <i class="fa-regular fa-user icon"></i>
                    <input type="text" name="name" class="name base" placeholder="이름" required>
                </li>
                <li>
                    <i class="fa-solid fa-calendar-days icon"></i>
                    <input type="text" name="birth" class="birth base" placeholder="생년월일 8자리" required>
                </li>
                <li>
                    <div class="left">
                        <label class="ra le">
                            <input type="radio" name="sex" value="남자" required><span>남자</span>
                        </label>
                        <label class="ra">
                            <input type="radio" name="sex" value="여자" required><span>여자</span>
                        </label>
                    </div>
                    <div class="right">
                        <label class="ra">
                            <input type="radio" name="citizenship" value="내국인" required><span>내국인</span>
                        </label>
                        <label class="ra">
                            <input type="radio" name="citizenship" value="외국인" required><span>외국인</span>
                        </label>
                    </div>
                </li>
                <li>
                    <i class="fa-solid fa-mobile icon"></i>
                    <input type="text" name="phoneNum" class="phone base" placeholder="휴대전화번호" required>
                </li>
            </ul>
            <ul class="error2"></ul>
            <input type="submit" value="회원가입">
        </form>
    </div>
    <script src="./join.js"></script>
</body>
</html>
