//= require jquery.clearsearch
//= require jquery.infinitescroll

var Search = {
    init: function(){
        $('.clearable').clearSearch({
            callback: function() {
                $("#q").blur();
                Search.hideSearch();
            }
        });
        $('#search-form').on('submit', function(){
            $("#q").blur();
            $('#search-results').html('<i>Please wait...</i>');
            Search.showSearch();
        });
    },
    showSearch: function(){
        $('.contents').addClass('hidden');
        $('#search-results').removeClass('hidden');
    },
    hideSearch: function(){
        $('.contents').removeClass('hidden');
        $('#search-results').addClass('hidden');
    },
    initInfiniteScroll: function(){
        $("#search-results").infinitescroll({
            navSelector: "ul.pagination",
            nextSelector: "ul.pagination a[rel=next]",
            itemSelector: "#search-results div.search-result",
            loading: {
              finishedMsg: "",
              msgText: "<em>Loading...</em>"
            }
        });
    },
    destroyInfiniteScroll: function(){
        $('#search-results').infinitescroll('destroy').data('infinitescroll', null);
    }

};

$(document).on('ajaxComplete', function() {
    Search.init();
});

Search.init();