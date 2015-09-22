//= require cocoon
//= require bootstrap/collapse
//= require bootstrap/tooltip
//= require bootstrap/modal
//= require bootstrap/tab
//= require summernote

$(document).on('cocoon:after-insert', '#sections', function(event, field){
    var editor = field.find('[data-provider="summernote"]');
    Study.instantiateEditor(editor);
});

$(document).on('cocoon:after-insert', '.section_verses', function(event, field){
    var verse_id = $('section.active a.add-verse').data('verse-id');
    var verse_title = $('section.active a.add-verse').data('verse-title');
    var verse_text = $('section.active a.add-verse').data('verse-text');
    field.find('input.verse-id').val(verse_id);
    field.find('.verse-title').html(verse_title);
    field.find('.verse-text').html(verse_text);
    field.find('a.remove-verse').data('verse-id', verse_id);
});

var Study = {
    init: function(){
        $('[data-provider="summernote"]').each(function(){
          Study.instantiateEditor(this);
        })
    },
    instantiateEditor: function(instance){
        $(instance).summernote({
            maximumImageFileSize: 524288, //512 KB max
            toolbar: [
                ['color', ['color']],
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['link', 'picture']]
            ]
        });
    }
};

Study.init();

$('body').on('click', 'a.load-bible', function(e){
    e.preventDefault();
    $('#sections section').removeClass('active');
    $(this).closest('section').addClass('active');
    var path = $(this).attr('href');
    var $modal_body = $("#bible-modal .modal-body");
    if ($modal_body.data('loaded') != true){
        $.getScript(path);
    }
    $("#bible-modal").modal('show');
});

$('body').on('click', 'ol.verses span.verse', function(){
    var verse_id = $(this).data('verse-id');
    var verse_title = $(this).data('verse-title');
    var verse_text = $(this).html();
    if ($("section.active .section_verses input[value='"+verse_id+"']").length == 0) { //don't add the verse if it's already present
        $(this).addClass('selected');
        $('section.active a.add-verse')
            .data('verse-id', verse_id)
            .data('verse-title', verse_title)
            .data('verse-text', verse_text)
            .click();
    } else {
        $(this).removeClass('selected');
        $("section.active .section_verses a.remove-verse[data-verse-id="+verse_id+"]").click();
    }
});