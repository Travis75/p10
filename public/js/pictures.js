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
        $('#user_photo').css('background-image', 'url' + '(' + picture_to_tag + ')')
        .animate({'margin-top': '0%'}, 1000);
      $.each(data, function(index, value){
        $("#text").append('<span>' + value.join(' ') + '</span><br>')
      });
    });
  });
})

var showText = function (target, message, index, interval) {
  if (index < message.length) {
    $(target).append(message[index++]);
    setTimeout(function () { showText(target, message, index, interval); }, interval);
  }
}

$(function () {

  showText("#msg", "Hello, World!", 0, 500);

});

