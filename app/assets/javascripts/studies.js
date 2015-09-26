//= require search
//= require bootstrap/tab
//= require bootstrap/collapse

$('[data-toggle="tabajax"]').click(function(e) {
    var $this = $(this),
        loadurl = $this.attr('href'),
        targ = $this.attr('data-target');
    $.getScript(loadurl);
    $this.tab('show');
    return false;
});