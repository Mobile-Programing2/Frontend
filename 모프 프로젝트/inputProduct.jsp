<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="./css/inputProduct.css">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<body>
<script>
    function removeItem(proNo) {
        if (confirm('이 상품을 삭제하시겠습니까?')) {
            fetch('inputProduct.jsp?remove=true&proNo=' + proNo, { method: 'GET' })
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
<div class="wrap">
    <form action="inputProduct.jsp" method="post">
        <h1>관리자 페이지</h1>
        <h2>상품 SQL에 넣기</h2>
        <ul>
            <li>상품 번호: <input type="text" name="proNo" required></li>
            <li>상품 이름: <input type="text" name="proName" required></li>
            <li>상품 소개: <input type="text" name="proIntro"></li>
           
             <li>상품 가격: <input type="text" name="proPrice"></li>
            <li>상품 이미지 (파일 이름만 입력): <input type="text" name="proImage" required></li>
            <li>상품 장르: <input type="text" name="proGangre" required></li>
            <li>상품 시대: <input type="text" name="proTime" required></li>
            <li>상품 레벨: <input type="text" name="proLevel" required></li>
        </ul>
        <input type="submit" value="SQL문에 저장">
    </form>
</div>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        request.setCharacterEncoding("UTF-8");
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
            String DB_ID = "run";
            String DB_PASSWORD = "1234";
            Class.forName("org.gjt.mm.mysql.Driver");

            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            String proNo = request.getParameter("proNo");
            String proName = request.getParameter("proName");
            String proIntro = request.getParameter("proIntro");
          
            String proImage = request.getParameter("proImage");
            String proPrice = request.getParameter("proPrice");
            String proGangre = request.getParameter("proGangre");
            String proTime = request.getParameter("proTime");
            String proLevel = request.getParameter("proLevel");

            String sql = "INSERT INTO Product (proNo, proName, proIntro, proImage, proPrice, proGangre, proTime, proLevel) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, proNo);
            pstmt.setString(2, proName);
            pstmt.setString(3, proIntro);
          
            pstmt.setString(4, proImage);
            pstmt.setString(5, proPrice);
             pstmt.setString(6, proLevel);
            pstmt.setString(7, proGangre);
            pstmt.setString(8, proTime);
           

            int result = pstmt.executeUpdate();
            if (result > 0) {
                out.println("<p>상품이 성공적으로 저장되었습니다!</p>");
            } else {
                out.println("<p>상품 저장에 실패했습니다.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>오류 발생: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>

<hr>

<h2>저장된 상품 목록</h2>


<table border="1">
    <thead>
        <tr>
            <th>상품 번호</th>
            <th>상품 이름</th>
            <th>상품 소개</th>
            <th>상품 가격</th>
            <th>상품 이미지</th>
            <th>상품 레벨</th>
            <th>상품 장르</th>
            <th>상품 타임</th>
            <th>삭제</th>
        </tr>
    </thead>
    <tbody>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
                String DB_ID = "run";
                String DB_PASSWORD = "1234";
                Class.forName("org.gjt.mm.mysql.Driver");

                con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String sql = "SELECT * FROM product";
                stmt = con.createStatement();
                rs = stmt.executeQuery(sql);


					  if ("true".equals(request.getParameter("remove"))) {
            String proNoToRemove = request.getParameter("proNo");

           
            String deleteSql = "DELETE FROM `product` WHERE proNo = ? ";
            try (PreparedStatement deleteStmt = con.prepareStatement(deleteSql)) {
                deleteStmt.setString(1, proNoToRemove);
              
                deleteStmt.executeUpdate();
                out.println("<script>alert('상품이 삭제되었습니다.');</script>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('삭제에 실패했습니다.');</script>");
            }}

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
        <tr>
            <td><%= proNo %></td>
            <td><%= proName %></td>
            <td><%= proIntro %></td>
            <td><%= proPrice %> 원</td>
            <td><img src="./image/상품/<%= proImage %>.jpeg" alt="<%= proName %>" width="100"></td>
           <td><%= proLevel %> </td>
           <td><%= proGangre %> </td>
           <td><%= proTime %> </td>
            <td><button onclick="removeItem('<%= proNo %>')"><i class="xi-close-circle-o"></i></button></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>오류 발생: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (con != null) try { con.close(); } catch (SQLException ignored) {}
            }
        %>
    </tbody>
</table>



</body>
</html>
