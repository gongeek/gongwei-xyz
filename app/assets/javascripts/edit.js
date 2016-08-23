//= require uploader
//= require markdown
//= require_self

(function () {
    function ready() {
        marked.setOptions({
            highlight: function (code) {
                function htmlEncode(value){
                    return $('<div/>').text(value).html();
                }
                return htmlEncode(hljs.highlightAuto(code).value);
            },
            breaks: true
        });
        $('#preview-btn').on('click', function (e) {
            var $form = $(this).parents('form').clone(),
                contentMd = $form.find('[name="article[content_md]"]').val();
            $form.append('<textarea style="display: none" name="article[content]">' + marked(contentMd) + '</textarea>');
            $form.find('[name="_method"]').remove();

            $.post('/articles/preview_post', $form.serialize(), function (data) {
                if (data.ok) {
                    $('#preview-click-btn').click();//防止被浏览器屏蔽
                }
            })

        });

        $('#preview-click-btn').on('click', function (e) {
            window.open('/articles/preview', '预览');
        });

        $('#submit-btn').on('click', function (e) {
            var $form = $(this).parents('form'),
                contentMd = $form.find('[name="article[content_md]"]').val();
            $form.append('<textarea style="display: none" name="article[content]">' + marked(contentMd) + '</textarea>');
            $form.submit();
        });

        $('#file-up-btn').AjaxFileUpload({
            action: '/file_up.json',
            onSubmit: function () {
                return {authenticity_token: AUTH_TOKEN}
            },
            onComplete: function (filename, response) {
                if (response.ok) {
                    $('.upload-result').append('<li><i class="icon" data-clipboard-text="http://' + location.host + '/file/' + response.data.filename + '">&#xe605;</i><a href="/file/' + response.data.filename + '" target="_blank">' + response.data.filename + '</a></li>')
                } else {
                    $('.upload-result').append('<li>error!</li>>')
                }
            }
        });
        new Clipboard('.upload-result i');
    }

    function init() {
        $(document).ready(ready);
        $(document).on('page:load', ready);//fix turbolinks
    }

    init();
}());
