$(document).ready(function(){

	$('.movieplot').each(function() {
		if ($(this).text().length > 100) {
			var words = $(this).text().substring(0,100).split(" ");
			var shortText = words.slice(0, words.length - 1).join(" ") + " [mehr]";
			$(this).data('replacementText', $(this).text())
			.text(shortText)
			.css({ cursor: 'pointer' })
			.hover(function() { $(this).css({ textDecoration: 'none' }); }, function() { $(this).css({ textDecoration: 'none' }); })
			.click(function() { var tempText = $(this).text(); $(this).text($(this).data('replacementText')); $(this).data('replacementText', tempText); });
		}
	});


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
