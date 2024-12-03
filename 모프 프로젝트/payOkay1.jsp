<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page session="true" %> 
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 처리</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8"); 
    String DB_URL = "jdbc:mysql://localhost:3306/run?useUnicode=true&characterEncoding=UTF-8";
    String DB_ID = "run";
    String DB_PASSWORD = "1234";

    String orName = request.getParameter("name"); 
    String orPhone = request.getParameter("phoneNum");
    String rName = request.getParameter("rName"); 
    String rPhone = request.getParameter("rPhone"); 
    String rAddress = request.getParameter("rAddress"); 
    String cardNo = request.getParameter("cardNo"); 
    String cardPwd = request.getParameter("cardPwd"); 
    String bank = request.getParameter("bank");
    String grandTotal = request.getParameter("grandTotal");

    String id = (String) session.getAttribute("sid"); 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String payNum = id;

        String getMaxOrNumSQL = "SELECT MAX(orNum) FROM paymember";
        pstmt = conn.prepareStatement(getMaxOrNumSQL);
        rs = pstmt.executeQuery();

        int newOrderNum = 1;
        if (rs.next() && rs.getInt(1) != 0) {
            newOrderNum = rs.getInt(1) + 1; 
        }
        rs.close();
        pstmt.close();

        String insertSQL = "INSERT INTO paymember (orNum, orName, orPhone, rName, rPhone, rAddress, cardNo, cardPwd, bank, orMoney, payNum, orDate) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        java.util.Date date = new java.util.Date();  
        String oDate = date.toLocaleString();       
        pstmt = conn.prepareStatement(insertSQL);
        pstmt.setInt(1, newOrderNum);
        pstmt.setString(2, orName);   
        pstmt.setString(3, orPhone);   
        pstmt.setString(4, rName);     
        pstmt.setString(5, rPhone);    
        pstmt.setString(6, rAddress);  
        pstmt.setString(7, cardNo);    
        pstmt.setString(8, cardPwd);   
        pstmt.setString(9, bank);     
        pstmt.setString(10, grandTotal); 
        pstmt.setString(11, payNum);   
        pstmt.setString(12, oDate);  
        int result = pstmt.executeUpdate();

        if (result > 0) {
         

          
%>
            <script>
                alert("결제가 완료되었습니다!");
                location.href = "index.jsp"; 
            </script>
<%
        } else {
%>
            <script>
                alert("결제 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                location.href = "pay.jsp"; 
            </script>
<%
        }
    } catch (SQLException e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw); 
        out.println("<h2>DB 오류 발생:</h2>");
        out.println("<pre>" + e.getMessage() + "</pre>");
        out.println("<h3>SQLException StackTrace:</h3>");
        out.println("<pre>" + sw.toString() + "</pre>"); 
    } catch (ClassNotFoundException e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);  
        out.println("<h2>JDBC 드라이버 오류 발생:</h2>");
        out.println("<pre>" + e.getMessage() + "</pre>");
        out.println("<h3>ClassNotFoundException StackTrace:</h3>");
        out.println("<pre>" + sw.toString() + "</pre>"); 
    } catch (Exception e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);  
        out.println("<h2>기타 오류 발생:</h2>");
        out.println("<pre>" + e.getMessage() + "</pre>");	
        out.println("<h3>Exception StackTrace:</h3>");
        out.println("<pre>" + sw.toString() + "</pre>"); 
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ex) {}
        try { if (conn != null) conn.close(); } catch (SQLException ex) {}
    }
%>
</body>
</html>
