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





