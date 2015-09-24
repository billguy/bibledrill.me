//= require cocoon
//= require bootstrap/collapse
//= require bootstrap/tooltip
//= require bootstrap/modal
//= require bootstrap/tab
//= require summernote
//= require bible_search

$('#sections').on('cocoon:after-insert', function(event, field){
    if (!field.hasClass('panel')) { return; } // since our form is deeply nested we need to abort events that aren't for us
    var editor = field.find('[data-provider="summernote"]');
    Study.instantiateEditor(editor);
    // need to assign id to new section panel
    var collapse_id = new Date().getTime();
    $('#sections .collapse').collapse('hide');
    field.find('div.panel-heading').attr('id', 'panel-'+collapse_id);
    field.find('a[data-toggle=collapse]').attr('href', '#collapse-'+collapse_id).attr('aria-controls', 'collapse-'+collapse_id);
    var $section_panel = field.find('div.panel-collapse').attr('id', 'collapse-'+collapse_id).attr('aria-labelledby', 'panel-'+collapse_id);
    $section_panel.collapse('show');
});

$('body').on('cocoon:after-insert', '.section_verses', function(event, field){
    var verse_id = $('section.active a.add-verse').data('verse-id');
    var verse_title = $('section.active a.add-verse').data('verse-title');
    var verse_text = $('section.active a.add-verse').data('verse-text');
    var section_verse_ids = $("section.active").data('verse-ids') || [];
    section_verse_ids.push(verse_id);
    $("section.active").data('verse-ids', section_verse_ids);
    field.find('input.verse-id').val(verse_id);
    field.find('.verse-title').html(verse_title);
    field.find('.verse-text').html(verse_text);
    field.find('a.remove-verse').attr('data-verse-id', verse_id);
    $("#bible-modal .modal-body li.verse[data-verse-id="+verse_id+"]").add('selected'); // select the verse in the modal
});

$('body').on('cocoon:before-remove', '.section_verses', function(event, field){
    var verse_id = field.find('a.remove-verse').data('verse-id');
    var section_verse_ids = $("section.active").data('verse-ids') || [];
    var index = section_verse_ids.indexOf(parseInt(verse_id));
    if (index > -1)
        section_verse_ids.splice(index, 1);
    $("section.active").data('verse-ids', section_verse_ids);
    $("#bible-modal .modal-body li.verse[data-verse-id="+verse_id+"]").removeClass('selected'); // deselect the verse in the modal
});

var Study = {
    init: function(){
        $('[data-provider="summernote"]').each(function(){
          Study.instantiateEditor(this);
        });
        Study.parseVerseIds();
        $('#sections .collapse').first().collapse(); // open the first section
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
    },
    parseVerseIds: function(){
        // convert data-verse-ids attribute to jquery data object
        $('section').each(function(){
            var section_verse_ids = $.parseJSON( $(this).attr('data-verse-ids') );
            var verse_ids = [];
            $.each(section_verse_ids, function(index, verse_id){
                verse_ids.push(parseInt(verse_id));
            });
            $(this).data('verse-ids', verse_ids);
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
    } else {
        //load the selected verses from the active section into the modal
        var section_verse_ids = $("section.active").data('verse-ids') || [];
        $("#bible-modal .modal-body li.verse.selected").removeClass('selected');
        $.each(section_verse_ids, function(index, verse_id){
            $("#bible-modal .modal-body li.verse[data-verse-id="+verse_id+"]").addClass('selected');
        });
    }
    $("#bible-modal").modal('show');
});

$('body').on('click', 'ol.verses li.verse, a.verse', function(e){
    e.preventDefault(); // override the hyperlink if from a search
    var verse_id = $(this).data('verse-id');
    var verse_title = $(this).data('verse-title');
    var verse_text = $(this).data('verse-text') || $(this).html();
    var section_verse_ids = $("section.active").data('verse-ids');
    //don't add the verse if it's already present
    if ($.inArray(verse_id, section_verse_ids) !== -1) {
        $(this).removeClass('selected');
        $("section.active a.remove-verse[data-verse-id="+verse_id+"]").click();
    } else {
        $(this).addClass('selected');
        $('section.active a.add-verse')
            .data('verse-id', verse_id)
            .data('verse-title', verse_title)
            .data('verse-text', verse_text)
            .click();
    }
});