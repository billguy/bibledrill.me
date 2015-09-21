//= require cocoon
//= require bootstrap-wysiwyg
//= require bootstrap/collapse

$(document).on('cocoon:after-insert', '#sections', function(event, field){
    var editor = field.find('.notes').first().attr('id');
    var editor_id = '#' + editor + '_editor';
    var toolbar = editor + '_toolbar';
    field.find('.editor').first().attr('id', editor_id);
    field.find('.btn-toolbar').first().attr('data-target', editor_id).attr('data-role', toolbar);
    $(editor_id).wysiwyg({toolbarSelector: '[data-role='+toolbar+']'});
});