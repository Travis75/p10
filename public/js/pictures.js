$(document).ready(function() {
    $(".submit").on('click', function(e) {

    e.preventDefault();
    var picture_to_tag = $('form').find('input').val();
    $.ajax({
      url: "/image_tag",
      type: "GET",
      data: {image_url: picture_to_tag}
    }).done(function(data){
      $("#text").empty()
        $('#user-photo').empty().append("<img src =" + picture_to_tag + ">")
      $.each(data, function(index, value){
        $("#text").append('<span></span><br>')
        addInHaikuText('#text span', value.join(' ').split(''))
      });
        $("#user-photo").animate({opacity: 1}, 3000)
        $("#text").animate({opacity: 1}, 3000)
    });
  });
})


function addInHaikuText(target,arrayOfWords){
  var mostRecentSpan = $(target).last();
  for (var i = 0; i < arrayOfWords.length; i++) {
      mostRecentSpan.append(arrayOfWords[i])
  }
}
