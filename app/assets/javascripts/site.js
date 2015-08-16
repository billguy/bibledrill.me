//= require wow_book
//= require nouislider
//= require jquery.timer.js

$(document).ready(function() {

    var max = $('#slider').data('slider-max');
    var slider = document.getElementById('slider');
    var randomVersePath = $('.timer-container').data('path');
    var timer = $.timer(function(){}).stop();
    var incrementTime = 70;
    var currentTime = 0;
    var currentPage = 0;
    var found = false;

    noUiSlider.create(slider, {
        start: 1,
        orientation: 'vertical',
        step: 1,
        range: {
            'min': 1,
            'max': max
        }
    });

    var bible = $('#bible').wowBook({
      height : 780,
      width  : 1050,
      turnPageDuration: 10,
      hardcovers: true,
      flipSound: false,
      scaleToFit: "#jacket",
      updateBrowserURL: false,
      onShowPage: function(book, page, pageIndex) {
        currentPage = pageIndex;
        slider.noUiSlider.set(pageIndex);

        loadPagesForPageNumber(pageIndex, book);

        if (pageIndex > 0 && pageIndex <= max){
            startDrill();
        } else if (pageIndex < 1 || pageIndex > max + 1){
            stopDrill()
        }
      }
    });

    function startDrill(){
        if ($('#slider-container').hasClass('hidden')){
            $('#slider-container').fadeIn().removeClass('hidden');
            startTimer();
        }
    }

    function stopDrill(){
        $('#slider-container').fadeOut().addClass('hidden');
        stopTimer();
    }

    function loadPagesForPageNumber(pageIndex, book){
        pages = [pageIndex-3, pageIndex-2, pageIndex-1, pageIndex, pageIndex+1, pageIndex+2, pageIndex+3];
        for (index = 0; index < pages.length; index++) {
            number = pages[index];
            p = book.pages[number];
            if (p && !p.attr('data-page')){
                p.attr('data-page', number - 1);
                $.getScript('/pages/' + (number - 1));
            }
        }
    }

    slider.noUiSlider.on('change', function(values, handle) {
        page = Math.floor(values[handle]);
        bible.wowBook('gotoPage', page);
    });

    $('#bible').on('click', 'a.verse', function(){
        var random_verse_id = $('#random-verse').data('verse-id');
        var verse_id = $(this).data('verse-id');
        if (verse_id == random_verse_id){
            found = true;
            stopTimer();
            var timeTaken = $('#timer').html();
            alert("You found it in " + timeTaken);
        }
    });

    $('.timer-container').on('click', 'a.refresh', function(e){
        e.stopImmediatePropagation();
        e.preventDefault();
        bible.wowBook('gotoPage', 1);
        found = false;
        restartTimer();
    });

    $('#bible').fadeIn(function(){
        $('.loader').addClass('hidden');
    });

    function startTimer(){
        $('.timer-container').fadeTo(1000, 1);
        if (currentTime == 0) {
            $.getScript(randomVersePath).success(function () {
                timer = $.timer(updateTimer, incrementTime, true);
            });
        } else if (!found){
            timer.play();
        }
    }

    function restartTimer(){
        currentTime = 0;
        startTimer();
    }

    function stopTimer(){
        if (!found)
            $('.timer-container').fadeTo(1000, 0);
        timer.pause();
    }

    function pad(number, length) {
        var str = '' + number;
        while (str.length < length) {str = '0' + str;}
        return str;
    }

    function formatTime(time) {
        time = time / 10;
        var min = parseInt(time / 6000),
            sec = parseInt(time / 100) - (min * 60),
            hundredths = pad(time - (sec * 100) - (min * 6000), 2);
        return "• " + (min > 0 ? pad(min, 2) : "00") + ":" + pad(sec, 2) + ":" + hundredths;
    }

    function updateTimer() {
        var timeString = formatTime(currentTime);
        $('#timer').html(timeString);
        currentTime += incrementTime;
    }

});