//= require jquery.clearsearch
//= require jquery.infinitescroll

var Search = {
    init: function(){
        $('.bible-tab-pane.active .clearable').clearSearch({
            callback: function() {
                $(".bible-tab-pane.active .q").blur();
                Search.hideSearch();
            }
        });
        $('.bible-tab-pane.active .search-form').on('submit', function(){
            $(".bible-tab-pane.active .q").blur();
            $('.bible-tab-pane.active .search-results').html('<i>Please wait...</i>');
            Search.showSearch();
        });
    },
    showSearch: function(){
        $('.bible-tab-pane.active .contents').addClass('hidden');
        $('.bible-tab-pane.active .search-results').removeClass('hidden');
    },
    hideSearch: function(){
        $('.bible-tab-pane.active .contents').removeClass('hidden');
        $('.bible-tab-pane.active .search-results').addClass('hidden');
    },
    initInfiniteScroll: function(){
        $(".bible-tab-pane.active .search-results").infinitescroll({
            navSelector: ".bible-tab-pane.active ul.pagination",
            nextSelector: ".bible-tab-pane.active ul.pagination a[rel=next]",
            itemSelector: "div.search-result",
            loading: {
              finishedMsg: "",
              msgText: "<em>Loading...</em>"
            }
        });
        Search.showSearch();
    },
    destroyInfiniteScroll: function(){
        $('.bible-tab-pane.active .search-results').infinitescroll('destroy').data('infinitescroll', null);
        Search.hideSearch();
    }

};

$(document).on('ajaxComplete', function() {
    Search.init();
});

Search.init();