$(document).ready(function() {
    $(".submit").on('click', function(e) {

    e.preventDefault();
    var picture_to_tag = $('form').find('input').val();
    $.ajax({
      url: "/image_tag",
      type: "GET",
      data: {image_url: picture_to_tag}
    }).done(function(data){
      console.log(data)
        $('#user_photo').css('background-image', 'url' + '(' + picture_to_tag + ')');
      $.each(data, function(index, value){
        console.log(value)
        $("#text").append('<span></span><br>')
        pMessage('#text span', value.join(' ').split(''))
      });
    });
  });
})


function pMessage(target,text){
  var jTarget = $(target).last();
  for (var i = 0; i < text.length; i++) {
      jTarget.append(text[i])
  }
}