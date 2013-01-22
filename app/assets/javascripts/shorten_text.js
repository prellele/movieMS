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
});
