//= require jquery.clearsearch
//= require jquery.infinitescroll

var BibleSearch = {
    init: function(){
        $('.clearable').clearSearch({
            callback: function() {
                $("#q").blur();
                BibleSearch.showBible();
            }
        });
        $('#search-form').on('submit', function(){
            $("#q").blur();
            $('#search-results').html('<i>Please wait...</i>');
            BibleSearch.showSearch();
        });
    },
    showSearch: function(){
        $('.bible').addClass('hidden');
        $('#search-results').removeClass('hidden');
    },
    showBible: function(){
        $('.bible').removeClass('hidden');
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
    BibleSearch.init();
});

BibleSearch.init();