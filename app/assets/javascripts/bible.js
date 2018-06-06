//= require bootstrap/tab
//= require bootstrap/modal
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require jquery.sticky
//= require spin
//= require jquery.spin
//= require search
//= require js.cookie

if (history && history.pushState){
  $(function(){
   $(document).on('click', 'a[data-remote="true"]', function(e){
        if (!$(this).hasClass('x'))
            history.pushState(null, '', this.href);
    });
    $(window).bind("popstate", function(){
        $.getScript(location.href);
    });
  });
}

$(".sticky").sticky();

$(document).on('ajaxComplete', function() {
    $(".sticky").sticky();
});

$('body').on('click', 'ol.verses li span.verse', function(){
    var verse_id = $(this).data('verse-id');
    var highlight_path = $(this).data('highlight-path');
    $.ajax({
      type: "POST",
      url: highlight_path,
      data: { _method:'PUT', id: verse_id }
    });
});

var verses = [];
$('body').on('click', 'ul.verses li:not(.read) a', function(e){
    e.stopImmediatePropagation();
    e.preventDefault();

    var $read_link = $(this).closest('ul').find('li.read a');
    var verse_number = $(this).data('number');

    if ($(this).hasClass('selected')){
        $(this).removeClass('selected');
        var index = $.inArray(verse_number, verses);
        verses.splice(index, 1);
        if (verses.length > 0){
            $read_link.addClass('glow');
            verse_path = $read_link.data('verse-path');
            $read_link.attr('href', verse_path + '/' + verses.join(','));
        } else {
            $read_link.removeClass('glow');
            var chapter_path = $read_link.data('chapter-path');
            $read_link.attr('href', chapter_path);
        }
    } else {
        $(this).addClass('selected');
        $read_link.addClass('glow');
        verses.push(verse_number);
        verse_path = $read_link.data('verse-path');
        $read_link.attr('href', verse_path + '/' + verses.join(','));
    }
});

$('body').on('click', 'ul.verses li.read a', function(e){
    verses = [];
});

$('body').on('click', 'a.x', function(){
    $(this).hide();
    var opts = { lines: 15, length: 10, width: 3, radius: 1, scale: 0.5, corners: 1, color: '#000', opacity: 0.25, rotate: 0, direction: 1, speed: 1, trail: 60, fps: 20, zIndex: 2e9, className: 'spinner', top: '50%', left: '50%', shadow: false, hwaccel: false, position: 'absolute'};
    $(this).next('span.s').spin(opts);
});

$('#new-bible-tab a').click(function(e){
    e.preventDefault();

    var new_tab_id = 'tab-' + Math.floor(Math.random()*10000);
    Cookies.set('current_tab_id', new_tab_id);
    var $tab = $('.tab-blueprint').clone();  // Create tab
    $tab.removeClass('tab-blueprint hidden');
    $tab.attr('data-tab-id', new_tab_id);
    $tab.find('a.tab-title').attr('aria-controls', new_tab_id);
    $tab.find('a.tab-title').attr('href', '#' + new_tab_id);
    $tab.find('a.delete-tab').attr('data-tab-id', new_tab_id);
    $('#bible-tabs .tab').removeClass('active');
    $tab.addClass('active');
    $('#new-bible-tab').before($tab);

    var $tab_content = $('.tab-pane-blueprint').clone();  // Create tab content
    $tab_content.removeClass('tab-pane-blueprint');
    $tab_content.attr('id', new_tab_id);
    $tab_content.find('form.search').attr('id', 'search-' + new_tab_id);
    $tab_content.find('li.tab.old a').attr('href', '#old-' + new_tab_id);
    $tab_content.find('li.tab.new a').attr('href', '#new-' + new_tab_id);
    $tab_content.find('.tab-pane.old').attr('id', 'old-' + new_tab_id);
    $tab_content.find('.tab-pane.new').attr('id', 'new-' + new_tab_id);
    $('#bible-tab-content .bible-tab-pane').removeClass('active');
    $tab_content.addClass('active');
    $('#bible-tab-content').append($tab_content);

});

$('body').on('click', 'a.delete-tab', function(e){
    e.preventDefault();
    var tab_id = $(this).attr('data-tab-id');
    var $tab = $('.bible-tab[data-tab-id="'+tab_id+'"]');
    var $prev_tab = $tab.prev('.bible-tab:not(.tab-blueprint)');
    var $next_tab = $tab.next();
    $tab.remove();
    $('#'+tab_id).remove();
    if ( $prev_tab.length)
        $prev_tab.find('a').first().click();
    else
        $next_tab.find('a').first().click();
});

$('body').on('click', 'a.tab-link,a.tab-title', function(e){
    var tab_id = $(this).closest('.bible-tab-pane').attr('id');
    Cookies.set('current_tab_id', tab_id);
});

$('a.highlights-tab[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    var loaded = $(this).data('loaded');
    if (!loaded){
        $(this).data('loaded', true);
        var url = $(this).data('url');
        $.getScript(url);
    }
});

$('body').on('click', 'a.highlight', function(e){
    e.preventDefault();
    $('#new-bible-tab a').click();
    var title = $(this).html();
    $('li.bible-tab.active a.tab-title').text(title);
});