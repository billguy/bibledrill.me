//= require wow_book
//= require nouislider

$(document).ready(function() {

    var bible = $('#bible').wowBook({
      height : 870,
      width  : 980,
      turnPageDuration: 10,
      hardcovers: true,
      flipSound: false,
      scaleToFit: "#jacket",
      updateBrowserURL: false,
      onShowPage: function(book, page, pageIndex) {
        var page_number = pageIndex - 1;
        if (!page.attr('data-page')){
            page.attr('data-page', page_number);
            $.getScript('/pages/' + page_number);
        }

        if (page_number >= 0){
            if ($('#slider-container').hasClass('hidden'))
                $('#slider-container').fadeIn().removeClass('hidden');
        } else {
            $('#slider-container').fadeOut().addClass('hidden');
        }
      }
    });

    $('#bible').fadeIn();

    var max = $('#slider').data('slider-max');
    var slider = document.getElementById('slider');
    noUiSlider.create(slider, {
        start: 0,
        orientation: 'vertical',
        step: 1,
        range: {
            'min': 0,
            'max': max + 1
        }
    });

    slider.noUiSlider.on('change', function(values, handle) {
        page = Math.floor(values[handle]);
        bible.wowBook('gotoPage', page);
    });

    $(document).on('click', 'a.verse', function(){
        alert("you clicked on verse id " + $(this).data('verse-id'));
    });

});