window.onload = function(){}

// initialise model
Model = Model();
Model.initModel();


// init view

// init map
$(function(){
var map = L.map('map').setView([50.979, 11.322], 13);
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'angella1011.a101a736',
    accessToken: 'pk.eyJ1IjoiYW5nZWxsYTEwMTEiLCJhIjoiYWVjN2YxNGI5ZjhlZWE1NmU3MjcxODY0Yjc0ODYwMTcifQ.cbFbZ_6Viv9gcslUkDudiw'
}).addTo(map);

L.easyButton('fa-strikethrough', 
              function (){
                $('h1').css('text-decoration','line-through')
              },
             'Interact with the document'
            )
			
var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(map);
}

map.on('click', onMapClick);
});

// init timeline
Timeline = Timeline();
Timeline.initTimeline();

// init controller
Controller = Controller();
Controller.initController();
