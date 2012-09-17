//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery((function($) {
    $('#slides').slides({
        preload: true,
        play: 5000,
        pause: 2500,
        hoverPause: true,
        generatePagination: false,
        animationStart: function(current){
            $('.caption').animate({
                bottom:-35
            },100);
        },
        animationComplete: function(current){
            $('.caption').animate({
                bottom:0
            },200);
        },
        slidesLoaded: function() {
            $('.caption').animate({
                bottom:0
            },200);
        }
    });

    var menu = $("#portfolio-menu");
    menu.menu();
    menu.attr("style", "display: none");
    $.each(menu.find("a"), function(index, element) {
        $(element).bind("click", function() {
            window.location = $(element).attr("href");
        });
    })
    var portfolioList = $("#portfolio-li");
    portfolioList.bind("mouseover", function() {
        menu.attr("style", "");

    });
    portfolioList.bind("mouseout", function() {
        menu.attr("style", "display: none");
    });

    var paging = $(".album-paging");
    var pageCount = 20;
    paging.attr("style", "width: " + pageCount * 28 + "px");
    if (paging.length > 0) {
        paging.paging(pageCount, {
            onFormat: function() {
                if (this.value != this.page) {
                    return "<a class='page-enable'></a>";
                }
                else {
                    return "<a class='page-disable'></a>";
                }
            },
            format: '*',
            perpage: 1,
            page:1
        });
    }

    if ($('#galleria').length > 0) {
        // Load the classic theme
        Galleria.loadTheme('/assets/galleria/galleria.classic.js');

        // Initialize Galleria
        Galleria.run('#galleria');
    }
})(jQuery));