
//= require JQuery-File-Upload/jquery.ui.widget.js
//= require JQuery-File-Upload/tmpl.min.js
//= require JQuery-File-Upload/load-image.min.js
//= require JQuery-File-Upload/canvas-to-blob.min.js
//= require JQuery-File-Upload/jquery.iframe-transport.js
//= require JQuery-File-Upload/jquery.fileupload.js
//= require JQuery-File-Upload/jquery.fileupload-fp.js
//= require JQuery-File-Upload/jquery.fileupload-ui.js
//= require JQuery-File-Upload/locale.js

$(function () {
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

    $('#fileupload').fileupload('option', {
        maxFileSize:10000000,
        acceptFileTypes:/(\.|\/)(gif|jpe?g|png)$/i,
        sequentialUploads:true,
        process:[
            {
                action:'load',
                fileTypes:/^image\/(gif|jpeg|png)$/,
                maxFileSize:20000000 // 20MB
            },
            {
                action:'resize',
                maxWidth:2048,
                maxHeight:2048
            },
            {
                action:'save'
            }
        ]
    });

    if ($.support.cors) {
        $.ajax({
            url:'//jquery-file-upload.appspot.com/',
            type:'HEAD'
        }).fail(function () {
                $('<span class="alert alert-error"/>')
                    .text('Upload server currently unavailable - ' +
                    new Date())
                    .appendTo('#fileupload');
            });
    }


    // Load existing files:
    $('#fileupload').each(function () {
        var that = this;
        $.getJSON(this.action, function (result) {
            if (result && result.length) {
                $(that).fileupload('option', 'done')
                    .call(that, null, {result:result});
            }
        });
    });


});
