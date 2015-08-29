$(function() {
  $('#user_avatar').on('change', function(event) {
    var files = event.target.files;
    var image = files[0];
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image(100,100);
      img.src = file.target.result;
      $('#user_avatar_preview').html(img);
    };
    reader.readAsDataURL(image);
  });
});