// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require modal
//= require_self

(function () {
    var timer;

    function ready() {
        $('#login-btn').leanModal({
            modalId: '#login-modal'
        });
        $('.search-input').on('keyup', function (e) {
            var code = e.which;
            if (code == 13 && $(this).val().length > 0) {
                window.location.href = '/?search=' + $(this).val()
            }
        });
        $(document).on('scroll', function (e) {
            if (typeof timer === 'number') {
                clearTimeout(timer);
            }
            timer = setTimeout(function () {
                var $toTopBtn = $('.to-top-btn'),
                    $footer = $('.footer');
                if ($(window).scrollTop() > 200) {
                    $toTopBtn.show();
                } else {
                    $toTopBtn.hide();
                }
                if ($footer.length > 0) {
                    if ($(window).scrollTop() >= ($(document).height() - $footer.height() - $(window).height())) {
                        $toTopBtn.css({
                            'position': 'absolute',
                            'bottom': '',
                            'top': ($(document).height() - $footer.height() - 190) + 'px'
                        });
                    } else {
                        $toTopBtn.css({
                            'position': 'fixed',
                            'top': '',
                            'bottom': '100px'
                        });
                    }
                }
            }, 100);
        });

        $('.to-top-btn').on('click', function () {
            $('html,body').stop().animate({scrollTop: 0}, '500', 'swing');
        });

        setTimeout(function () {
            $('.flash-notice').fadeOut(1000)
        }, 500);
    }

    function init() {
        $(document).ready(ready);

        $(document).on('page:load', ready);//fix turbolinks

        $(document).on('page:fetch', function () {
            NProgress.start();
        });
        $(document).on('page:change', function () {
            NProgress.done();
        });
        $(document).on('page:restore', function () {
            NProgress.remove();
        });
    }

    init();
}());

