$(document).ready(function(){
	$('.selectable').click(function () {
		var movieid = $(this).data("id");
		var image = $(this).find(".movieheader").find(".star");
		$.post('/movies/' + movieid + '/favorite', {"create": (image.attr("src").indexOf("star_color") !== -1 ? false : true )});
		if (image.attr("src").indexOf("star_color") !== -1)
		{
			$(this).parent().find(".star").attr("src", "/assets/star_bw.png");
		}
		else if (image.attr("src").indexOf("star_bw") !== -1)
		{
			$(this).parent().find(".star").attr("src", "/assets/star_color.png");
		}
	});
});
