$(document).ready(function(){
    document.getElementById("movie_name").focus();
	$('#submit').click(function () {
		$(this).next().css("visibility", "visible");
	});
});
