//= require search
//= require bootstrap/tab
//= require social-share-button
//= require fitvids

$('[data-toggle="tabajax"]').click(function(e) {
    var $this = $(this),
        loadurl = $this.attr('href'),
        targ = $this.attr('data-target');
    $.getScript(loadurl);
    $this.tab('show');
    return false;
});

$(".embed-responsive-item").each(function(index, item){
    var $wrapper = $('<div class="embed-responsive embed-responsive-16by9"></div>');
    $wrapper.insertBefore(item);
    $(item).appendTo($wrapper);
    $wrapper.fitVids();
});