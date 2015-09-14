//= require bible
//= require jquery.clearsearch

var Bible = {
    init: function(){
        $('.clearable').clearSearch({
            callback: function() {
                Bible.showBible();
            }
        });
        $('#search-form').on('submit', function(){
            $("#q").blur();
            Bible.showSearch();
        });
    },
    showSearch: function(){
        $('.bible').addClass('hidden');
        $('#search-results').removeClass('hidden');
    },
    showBible: function(){
        $('.bible').removeClass('hidden');
        $('#search-results').addClass('hidden');
    }
};

$(document).on('ajaxComplete', function() {
    Bible.init();
});

Bible.init();