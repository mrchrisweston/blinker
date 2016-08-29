$('a').click(function(){
    $('html, body').animate({
        scrollTop: $( $(this).attr('href') ).offset().top
    }, 500);
    return false;
});

setTimeout(function (){

	$(function(){
	    $(document.body).addClass('loaded');
	})
      //something you want delayed

  }, 1000); // how long do you want the delay to be?

$(document).ready(function () {
	$.jribbble.getShotsByPlayerId('designmodo', function (playerShots) {
	    var html = [];

	    $.each(playerShots.shots, function (i, shot) {
	        html.push('<li><a href="' + shot.url + '">');
	        html.push('<img src="' + shot.image_teaser_url + '" ');
	        html.push('alt="' + shot.title + '"></a></li>');
	    });

	    $('#dribble-wrap').html(html.join(''));
	}, {page: 1, per_page: 10});
});

/*
$(document).ready(function(){

	$("div").css("border", "3px solid red");

});
*/

