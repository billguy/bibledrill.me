//= require_tree ../../../vendor/assets/javascripts/wow_book

$(document).ready(function() {
    $('#bible').wowBook({
      height : 850,
      width  : 950,
      turnPageDuration: 10,
      hardcovers: true,
      flipSound: false,
      updateBrowserURL: false,
      onShowPage: function(book, page, pageIndex) {
        var page_number = pageIndex - 1;
        page.attr('data-page', page_number);
        $.getScript('/pages/' + page_number)
            .success(function(){
                book.insertPage($('<div class="page"><div class="content"></div></div>'));
        });
      }
    });

    $('#bible').fadeIn();

});