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
    game = new Game
    view = new View
    game.bindevents(view)


})

function Game() {}

function View() {}

Game.prototype = {
    bindevents: function(view) {
        view.placeAircraftCarrier(this);
    },

    placecomp: function() {
        console.log('yo')
    }


}

// function addHor(res) {

// }

// function addVert(res) {

// }

View.prototype = {
    placeAircraftCarrier: function(game) {
        var game = game
        var that = this
        var shipInd = 0
        $("form").on('submit', function(e) {
            $('.shiploc').empty();
            e.preventDefault();
            var data = $(this).serialize() + '&ship=' + shipInd + '';
            $.ajax({
                type: 'GET',
                url: 'game/placeships',
                data: data,
                success: function(res) {
                    console.log(res);
                    if (typeof res === 'string') {
                        $('.shiploc').append(res)
                        $('form')[0].reset();
                    } else {
                        shipInd = res.slice(-1)[0] + 1;
                        if (res[3] == 'horizontal') {
                            that.addHor(res);
                            if (shipInd == 5) {
                                game.placecomp();
                            }
                        } else {
                            that.addVert(res);
                            if (shipInd == 5) {
                                game.placecomp();
                            }
                        }
                    }
                },
                error: function() {
                    console.log('no')
                }
            })
        })
    },

    addHor: function(res) {
        var j = res[1] + res[2];
        var i = res[1]
        for (i; i < j; i++) {
            $('tr:nth-child(' + (res[0] + 1) + ') td:nth-child(' + (i + 1) + ')').css('background-color', 'black')
        }
    },

    addVert: function(res) {
        var i = res[0];
        var j = res[0] + res[2];
        for (i; i < j; i++) {
            $('tr:nth-child(' + (res[0] + i) + ') td:nth-child(' + (res[1] + 1) + ')').css('background-color', 'black')
        }
    }
}