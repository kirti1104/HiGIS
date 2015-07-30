window.onload = function(){}

function zoom(zm) {
	img=document.getElementById("pic")
	wid=img.width
	ht=img.height
	img.style.width=(wid*zm)+"px"
	img.style.height=(ht*zm)+"px"
	img.style.marginLeft = -(img.width/2) + "px";
	img.style.marginTop = -(img.height/2) + "px";
}

// initialise model
Model = Model();
Model.initModel();


// init view

// init map
world_map = L.map('map').setView([50.979, 11.322], 13);
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'angella1011.a101a736',
    accessToken: 'pk.eyJ1IjoiYW5nZWxsYTEwMTEiLCJhIjoiYWVjN2YxNGI5ZjhlZWE1NmU3MjcxODY0Yjc0ODYwMTcifQ.cbFbZ_6Viv9gcslUkDudiw'
}).addTo(world_map);

// init timeline
Timeline = Timeline();
Timeline.initTimeline();

// init controller
Controller = Controller();
Controller.initController();