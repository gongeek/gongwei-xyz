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
//= require modal
//= require turbolinks
//= require_tree .
//= require_self
//= require nprogress
//= require scrollTo
$(document).ready(function () {
    $('#login-btn').leanModal({
        modalId: '#login-modal'
    });
    $('.search-input').on('keyup', function (e) {
        var code = e.which;
        if (code == 13 && $(this).val().length > 0) {
            document.location = document.location + '?search=' + $(this).val();
        }
    });

    $(document).on('scroll', function (e) {
        
    });

});

$(document).on('page:fetch', function () {
    NProgress.start();
});
$(document).on('page:change', function () {
    NProgress.done();
});
$(document).on('page:restore', function () {
    NProgress.remove();
});
