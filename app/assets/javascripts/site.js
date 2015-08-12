//= require_tree ../../../vendor/assets/javascripts/wow_book

$(document).ready(function() {
    $('#bible').wowBook({
      height : 765,
      width  : 910,
      turnPageDuration: 10,
      hardcovers: true,
      //updateBrowserURL: false,
      numberedPages: [2, -2],
      onShowPage: function(book, page, pageIndex) {
        if (!page.children().first().hasClass('skip')){
            page.attr('data-page', (pageIndex - 1));
            $.getScript('/pages/' + (pageIndex - 1));
        }
      }
    });
});