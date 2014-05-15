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
        $.ajax({
            type: 'GET',
            url: 'game/placecomp',
            success: function(res) {
                view.placeAttackBox(res);
            },
            error: function() {
                console.log('no')
            }
        })
    },

    attack: function(view) {
        var view = view
        var that = this
        $('form').on('submit', function(e) {
            e.preventDefault();
            var data = $(this).serialize();
            $.ajax({
                type: 'GET',
                url: 'game/attack',
                data: data,
                success: function(res) {
                    console.log(res)
                    if (res[0] == "HIT") {
                        view.hit(res[1], res[2], 'computer')
                        setTimeout(that.compattack, 2000)
                    } else if (res[0] == "MISS") {
                        view.miss(res[1], res[2], 'computer')
                        setTimeout(that.compattack, 2000)
                    } else {
                        view.displayError(res[0]);
                    }
                    if (res.slice(-1)[0] == true) {
                        alert('winner')
                    }
                },
                error: function() {
                    console.log('here i am')
                }
            })

        })
    },

    compattack: function() {
        $.ajax({
            type: 'GET',
            url: 'game/compattack',
            success: function(res) {
                console.log(res)
                if (res[0] == "HIT") {
                    view.hit(res[1], res[2], 'player')
                } else if (res[0] == "MISS") {
                    view.miss(res[1], res[2], 'player')
                } else {
                    view.displayError(res[0]);
                }
                if (res.slice(-1)[0] == true) {
                    alert('loser')
                }
            }
        })
    }


}


View.prototype = {
    placeAircraftCarrier: function(game) {
        var game = game
        var that = this
        var shipInd = 0
        var shipNames = {
            0: "AirCraft Carrier",
            1: "Battleship",
            2: "Submarine",
            3: "Cruiser",
            4: "Destroyer"
        }
        $("form").on('submit', function(e) {
            $('.shiploc').empty();
            e.preventDefault();
            var data = $(this).serialize() + '&ship=' + shipInd + '';
            $.ajax({
                type: 'GET',
                url: 'game/placeships',
                data: data,
                success: function(res) {
                    if (typeof res === 'string') {
                        $('.shiploc').append(res)
                        $('form')[0].reset();
                    } else {
                        shipInd = res.slice(-1)[0] + 1;
                        $('.coord span').html('' + shipNames[shipInd] + '')
                        if (res[1].direction == 'horizontal') {
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
        var j = parseInt(res[1].col) + parseInt(res[1].length);
        var i = parseInt(res[1].col)
        for (i; i < j; i++) {
            $('#player tr:nth-child(' + (res[0] + 1) + ') td:nth-child(' + (i + 1) + ')').css('background-color', 'black')
        }
    },

    addVert: function(res) {
        console.log(res)
        var i = res[0] + 1;
        var j = res[0] + 1 + parseInt(res[1].length);
        for (i; i < j; i++) {
            console.log(i)
            $('#player tr:nth-child(' + (i) + ') td:nth-child(' + (parseInt(res[1].col) + 1) + ')').css('background-color', 'black')
        }
    },

    placeAttackBox: function(res) {
        $('.coord').empty()
        $(".coord").append(res)
        game.attack(this);
    },

    hit: function(row, col, table) {
        console.log('that was a hit')
        console.log(col)
        console.log(row)
        $('.error').empty();
        $('#' + table + ' tr:nth-child(' + (row + 1) + ') td:nth-child(' + (col + 1) + ')').css('background-color', 'red')
    },

    miss: function(row, col, table) {
        console.log('that was a miss')
        console.log(col)
        console.log(row)
        $('.error').empty();
        $('#' + table + ' tr:nth-child(' + (row + 1) + ') td:nth-child(' + (col + 1) + ')').css('background-color', 'blue')

    },

    displayError: function(res) {
        $('.error').empty();
        $('.error').append(res);
    }
}