<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>index</title>

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
</head>

<body>
    <!--header-->
  
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

    <!--main-->

    <img src="./image/그림1.png" alt="" class="logo_video">
    <main id="main">
        <iframe width="1380" height="920" 
        src="https://www.youtube.com/embed/PHXb_VAVpgY?start=60&controls=0&autoplay=1&mute=1&modestbranding=1&rel=0&showinfo=0" 
        title="Virtual Running Videos For Treadmill With Music | 30 Minute Virtual Run" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
        referrerpolicy="strict-origin-when-cross-origin" 
        allowfullscreen>
</iframe>




    </main>

    <!--section1-->
    <section id="section1">
        <div class="top1">
            <ul>
                <li>지금, Run into History에서는</li>
                <li></li>
            </ul>
        </div>
        <div class="news">
            <ul>
                <li>
                    <div class="news_title">도심 속 러닝</div>
                    <div class="img1"></div>
                    <p>호그와트, ms세계마법학교평가 1위</p>
                    <em>러닝이 대세인 지금, 당신의 기록을 소개하세요.
                    </em>
                </li>
                <li>
                    <div class="news_title">신규 콘텐츠 출시</div>
                    <div class="img2"></div>
                    <p>구석기 시대의 신규 콘텐츠가 추가되었습니다!</p>
                    <em>
                      러닝이 지루하신가요? 맘모스에 쫒기며, 스릴있는 사냥을 떠나보는 것은 어떨까요? 이 신기한
                      경험을 러닝인투와 함께하세요!
                    </em>
                </li>
                <li>
                    <div class="news_title">이 달의 인기 콘텐츠 1위</div>
                    <div class="img3"></div>
                    <p>'비밀 조직 결성 그 이면의 이야기'가 이 달의 인기 콘텐츠 1위에 올랐습니다.</p>
                    <em>
                        일제 시대를 배경으로 한 '비밀 조직 결성 그 이면의 이야기'가 판매수 36,845 로 이 달의 콘텐츠 1위에 올랐습니다.
                        이 스릴넘치는 러닝을 도전해보시는 건 어떨까요?
                    </em>
                </li>
                <li>
                    <div class="news_title">축하해주세요!</div>
                    <div class="img4"></div>
                    <p>러닝인투, 2024년 건강 앱 부문 1위 수상</p>
                    <em>
                      러닝 인투가 2024 대한민국이 선정한 건강 앱 부문 1위를 수상하였습니다! 이를 맞이하여 특별한 이벤트를
                       기획 중에 있으니 모두 기대해주세요!
                    </em>
                </li>
            </ul>
        </div>
    </section>

    <!--section2-->
    <section id="section2">
        <div class="slide">
            <div class="autoplay">
                <div class="slide1">
                    <div class="hide">
                        <p>내 벗과 함께라면</p>
                        <em>일제 시대를 배경으로 한 학생 독립군의 뜨겁고도 처절한 그 이야기</br> '내 벗과 함께라면'
                        </em>
                    </div>
                </div>
                <div class="slide2">
                    <div class="hide">
                        <p>이순신 장군님과 함께</p>
                        <em>이순신 장군님과 함께한 처절한 전쟁의 기록, 거기에 녹아든 수많은 고뇌 그 이면에 대하여
                        </em>
                    </div>
                </div>
                <div class="slide3">
                    <div class="hide">
                        <p>세종 그 뒤에 숨겨진 '이도'</p>
                        <em>세종대왕이라는 찬란한 이름뒤에 가려졌던 인간 '이도'의 삶을 그려내 보았습니다.
                        </em>
                    </div>
                </div>
                <div class="slide4">
                    <div class="hide">
                        <p>김대감의 돈은 내가 안훔쳤어!</p>
                        <em>억울하게 누명을 쓴 당신, 과연 김대감의 돈은 누가 훔쳤는가
                        </em>
                    </div>
                </div>
                <div class="slide5">
                    <div class="hide">
                        <p>우가! 우가! 우가!</p>
                        <em>신규 출시된 구석기 시대! 그 역동감 넘치는 러닝을 당신에게 소개합니다.
                        </em>
                    </div>
                </div>
                <div class="slide6">
                    <div class="hide">
                        <p>당신을 위하여</p>
                        <em>줄리엣을 사랑하는 평민인 당신이 줄리엣의 사랑을 얻기 위해선 어떻게 해야 할까? 중세시대를 배경으로 펼쳐지는 로맨스이야기</em>
                    </div>
                </div>
                <div class="slide7">
                    <div class="hide">
                        <p>고담시의 부자는 진정 누구인가?</p>
                        <em>산업혁명시대를 배경으로 펼쳐지는 스릴러물! 당신은 당신의 사업을 지켜낼 수 있을것인가?</em>
                    </div>
                </div>
            </div>
        </div>
        <div class="event">
            <div class="event_img">

            </div>
            <div class="event_font">
                <p>2024년의 베스트 러너는 누구?</p>
                <em>숨가쁘게 달려온 당신! 러닝인투에서 당신에게 상을 드립니다.</em>
            </div>
        </div>
    </section>

    <section id="section3">
        <div class="top1">
            <ul>
                <li>러닝인투 캘린더</li>
                <li></li>
            </ul>
        </div>
        <div class="news">
            <ul>
                <li>

                    <div class="img1"></div>
                    <div class="section3_text">
                        <p>2024년 러닝인투 마라톤 개최</p>
                        <em>
                            2024.07.24(월)<br><br>
                           2024년 러닝인투에서 마라톤 대회를 개최합니다. 1등에게는 소나타 신형을 상품으로 드립니다! 
                           당신의 러닝 실력을 뽐내보세요!
                        </em>
                    </div>
                </li>
                <li>

                    <div class="img2"></div>
                    <div class="section3_text">
                        <p>2024 상반기 베스트 러너 선정</p>
                        <em>
                            2024.06.26(수)<br><br>
                            2024 베스트 러너인 최원철씨의 이야기를 들어보았다.
                        </em>
                    </div>
                </li>
                <li>

                    <div class="img3"></div>
                    <div class="section3_text">
                        <p>2024 러닝인투 단거리 달리기 대회</p>
                        <em>
                            2024.11.29(금)<br><br>
                            러닝인투에서 단거리 베스트 러너를 가리는 대회를 개최합니다. 이 추운 날씨를 뚫고 뜨거운 러닝을 보여줄
                             분들을 모십니다.
                        </em>
                    </div>
                </li>
                <li>

                    <div class="img4"></div>
                    <div class="section3_text">
                        <p>러닝인투 대규모 업데이트 예정</p>
                        <em>
                            2024.12.05(목)<br><br>
                           러닝 인투에서 러너들을 위한 대규모 업데이트가 예정되어있습니다. 많은 기대 부탁드립니다!
                        </em>
                    </div>
                </li>
            </ul>
        </div>
        <a href="#" class="plus"><i class="xi-long-arrow-right"></i>캘린더 더보기</a>
    </section>
    <footer>
        <ul class="footer_one">
            <li>정보공시</li>
            <li>전화번호/사이트 안내</li>
            <li>호그와트포털</li>
            <li>클린행정센터</li>
            <li><b>개인정보방침</b></li>
            <li>이메일무단수집거부</li>
            <li>사이트맵</li>
        </ul>
        <ul class="footer_two">
            <li>000777 딱총나무시 위저드구 호그로 호그와트마법학교</li>
            <li>TEL.(77) 880-7777</li>
            <li>FAX.(77) 887-7542</li>
        </ul>
        <p>Copyright 2024 Hogwarts school All Rights Reserved.</p>
    </footer>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var video = document.getElementById('myVideo');

            function playVideo() {
                video.play().catch(function (error) {
                    console.log('Autoplay was prevented:', error);
                });
            }
            video.addEventListener('ended', playVideo);
            playVideo();
        });
       
    

    </script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <!-- Slick JS CDN -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script type="text/javascript">

        $('.autoplay').slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 1000,
        });
    </script>
    <script>
        $(document).ready(function () {
            $('.menu-item').on('click', function (e) {
                var submenu = $(this).data('submenu');
                if (submenu) {
                    e.preventDefault();
                    $('.submenu').hide();
                    $(submenu).show();


                    var href = $(this).attr('href');
                    if (href && href !== "#") {
                        setTimeout(function () {
                            window.location.href = href;
                        }, 100);
                    }
                }
            });
        });
        $(document).ready(function () {
            $(".menu-item").click(function (e) {
                e.preventDefault();
                var submenuId = $(this).data("submenu");
                $(".submenu").not(submenuId).hide();
                $(submenuId).toggle();
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $(".menu-item").mouseenter(function () {
                var submenuId = $(this).data("submenu");
                $(".submenu").hide();
                $(submenuId).show();
            });

            $(".vertical-nav, .submenu").mouseleave(function () {
                $(".submenu").hide();
            });

            $(".submenu").mouseenter(function () {
                $(this).show();
            });

            $(".submenu").mouseleave(function () {
                $(this).hide();
            });
        });
        $(document).ready(function () {
            $('.autoplay .slide1').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide2').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide3').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide4').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide5').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide6').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide7').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });
        $(document).ready(function () {
            $('.autoplay .slide8').hover(
                function () {
                    $(this).find('.hide').stop(true, true).fadeIn();
                },
                function () {
                    $(this).find('.hide').stop(true, true).fadeOut();
                }
            );
        });






    </script>

</body>

</html>