//= require bible
//= require jquery.clearsearch

var Bible = {
    init: function(){
        $('.clearable').clearSearch({
            callback: function() {
                $('#search-results').addClass('hidden');
                $('.bible').removeClass('hidden');

            }
        });
    }
};

$(document).on('ajaxComplete', function() {
    Bible.init();
});

Bible.init();