$('.movierow .selectable').click(function () {
    var movieid = $(this).parent().data("id");
    $.post('/movies/' + movieid + '/favorite', {"create": ($(this).parent().hasClass("selected") ? false : true )});
    $(this).parent().find(".selectable").toggleClass('selected');
});
