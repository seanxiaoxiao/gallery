//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require galleria/galleria-1.2.8.js
//= require galleria/galleria.history.js
//= require uploader/tmpl.js
//= require uploader/load-image.min.js
//= require uploader/jquery.iframe-transport.js
//= require uploader/jquery.fileupload.js
//= require uploader/jquery.fileupload-fp.js
//= require uploader/jquery.fileupload-ui.js
//= require uploader/locale.js

var NANC = NANC || {};

(function($) {

    NANC.Galleria = function() {

        Galleria.run('#galleria', {
            thumbQuality: true,
            maxScaleRatio: 1,
            minScaleRatio: 1,
            height: 800,
            showInfo: false,
            history: true,
            width: 980
        });
    }

    NANC.Slide = function() {

        Galleria.run('#slides', {
            autoplay: 7000,
            maxScaleRatio: 1,
            minScaleRatio: 1,
            height: 620,
            showInfo: false,
            history: true,
            width: 980,
            carousel: false,
            showCounter: false,
            thumbnails: false
        });
    }

    NANC.SlideUpload = function() {
        'use strict';

        // Initialize the jQuery File Upload widget:
        $('#fileupload').fileupload();

        // Enable iframe cross-domain access via redirect option:
        $('#fileupload').fileupload(
            'option',
            'redirect',
            window.location.href.replace(
                /\/[^\/]*$/,
                '/cors/result.html?%s'
            )
        );

        var me = this;
        me.uploadButton = $("#slide-upload .fileinput-button");

        $('#fileupload').bind('fileuploaddestroy', me.enableUpload());
        $('#fileupload').bind('fileuploadfailed', me.enableUpload());
        $('#fileupload').bind('fileuploadstopped', me.enableUpload());

        // Load existing files:
        $('#fileupload').each(function () {
            var that = this;
            $.getJSON(this.action, function (result) {
                if (result && result.length) {
                    $(that).fileupload('option', 'done').call(that, null, {result: result});
                    if ($(that).find("tr").length > 0) {
                        me.disableUpload()();
                    }
                }
            });
        });
        $('#fileupload').bind('fileuploadadd', me.disableUpload());
    };

    NANC.SlideUpload.prototype = {

        disableUpload: function(e) {
            var me = this;
            return function() {
                me.uploadButton.addClass('hidden');
            };
        },

        enableUpload: function(e) {
            var me = this;
            return function() {
                me.uploadButton.removeClass('hidden');
            }
        }
    };

    NANC.AlbumUpload = function() {
        'use strict';

        // Initialize the jQuery File Upload widget:
        $('#fileupload').fileupload();

        // Enable iframe cross-domain access via redirect option:
        $('#fileupload').fileupload(
            'option',
            'redirect',
            window.location.href.replace(
                /\/[^\/]*$/,
                '/cors/result.html?%s'
            )
        );

        var me = this;
        me.uploadButton = $("#slide-upload .fileinput-button");

        // Load existing files:
        $('#fileupload').each(function () {
            var that = this;
            $.getJSON(this.action, function (result) {
                if (result && result.length) {
                    $(that).fileupload('option', 'done').call(that, null, {result: result});
                }
            });
        });
    };

    NANC.PortfolioPage = function() {
        var me = this;
        me.currentPage = NANC.currentPage;
        me.paging = $(".album-paging");
        me.paging.attr("style", "width: " + (NANC.pageCount) * 28 + "px");

        if (me.paging.length > 0) {
            me.paging.paging(NANC.pageCount, {
                onFormat: function() {
                    if (this.value != this.page) {
                        return "<a class='page-enable'></a>";
                    }
                    else {
                        return "<a class='page-disable'></a>";
                    }
                },
                onSelect: function(page) {
                    if (me.currentPage != page) {
                        $.ajax({
                            type: "GET",
                            url: "/portfolio/" + NANC.currentPortfolioId + "/albums/" + page,
                            success: function(data) {
                                me.currentPage = page;
                                me.removePage(data);
                            }
                        });
                    }
                },
                format: '*',
                perpage: 1,
                page: 1
            });
        }
    };

    NANC.PortfolioPage.prototype = {

        removePage: function(data) {
            var me = this;
            $(".album-records").fadeOut(500, function() {
                me.showPage(data);
            });
        },

        showPage: function(data) {
            $(".album-records .album-record").remove();
            for (var i in data) {
                var div = $("<div>").addClass("album-record");
                var a = $("<a>").attr("href", "/album/" + data[i]["id"] + ".html");
                var img = $("<img>").attr("src", data[i]["cover_url"]);
                $(div).append(a);
                $(a).append(img);
                $(".album-records").append(div);
            }
            $(".album-records").fadeIn(500);

        }
    };

    NANC.PortfolioMenu = function() {
        var menu = $("#portfolio-menu");
        menu.attr("style", "display: none");
        menu.removeClass("hidden");
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
    };


}(jQuery));


jQuery((function($) {

    Galleria.loadTheme('/assets/galleria/galleria.classic.js');

    new NANC.PortfolioMenu();

    if ($('#slides').length == 1) {
        new NANC.Slide();
    }

    if ($('#slide-upload').length == 1) {
        NANC.SlideUploadObj = new NANC.SlideUpload();
    }

    if ($('#album-upload').length == 1) {
        NANC.AlubmUploadObj = new NANC.AlbumUpload();
    }

    if ($('.album-paging').length == 1) {
        NANC.pagingObj = new NANC.PortfolioPage();
    }

    if ($('#galleria').length == 1) {
        new NANC.Galleria();
    }

})(jQuery));

