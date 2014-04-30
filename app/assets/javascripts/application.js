// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).on('ready', function() {
    a = new Game
    a.bindevents()


})

function Game() {}

Game.prototype.bindevents = function() {
    $("form").on('submit', function(e) {
        e.preventDefault();
        data = $(this).serialize()
        $.ajax({
            type: 'GET',
            url: 'game/placeships',
            data: data,
            success: function(res) {
                console.log(res);

                if (typeof res === 'string') {
                    $('.shiploc').append(res)
                } else {
                    if (res[3] == 'horizontal') {
                        addHor(res);
                    } else {
                        addVert(res);
                    }
                }
            },
            error: function() {
                console.log('no')
            }
        })
    })
}

function addHor(res) {
    var j = res[1] + res[2];
    var i = res[1]
    for (i; i < j; i++) {
        $('tr:nth-child(' + (res[0] + 1) + ') td:nth-child(' + (i + 1) + ')').css('background-color', 'black')
    }
}

function addVert(res) {
    var i = res[1];
    var j = res[1] + res[2];
    for (i; i < j; i++) {
        $('tr:nth-child(' + (res[0] + i) + ') td:nth-child(' + (res[1] + 1) + ')').css('background-color', 'black')
    }
}