$(".submit").on('click', function(e) {

  e.preventDefault();
  var picture_to_poetify = $('form').find('input').val();
  $.ajax({
    url: "https://sender.blockspring.com/api_v1/blocks/1751dda528c435200664e90be095bd04?api_key=13c886b0f3230d42fc7998a125f3dcc4",
    type: "POST",
    data: {image_url: picture_to_poetify},
    crossDomain: true
  }).done(function(response){
    var word_ary = response.results
    console.log(word_ary)
    $.ajax({
      url: '/haiku',
      type: "GET",
      data: {words: word_ary}
    }).done(function(data){
      console.log(data)
    });
  });

});


