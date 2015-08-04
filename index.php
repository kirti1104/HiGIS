<html>
  <head>
    <title>HiGIS Project</title>
	<link rel="stylesheet" href="style/leaflet.css" />
	<link rel="stylesheet" href="style/main.css" />
	<link rel="stylesheet" href="style/timeline.css" />	
  </head>
  <body>
	<div style="text-align: center">
		<font size="15" color="green" face="Arial">HiGIS</font>
	</div>
  
	<div id="map"></div>
  
	<!-- TIMELINE -->
	<div id="timeline">
	  <div id="tlMain"></div>
	</div>
 

<!--
   
 <div id="zoomin">
   <input type="image" src="graphics/button_plus.png" style="position:absolute;left:130px;top:630px;" onclick="zoom(1.1)"/>
   </div>
   <div id="zoomout">
   <input type="image" src="graphics/button_minus.png" style="position:absolute;left:130px;top:680px;" onclick="zoom(0.9)"/>
   </div>
   -->
   <div>
   <input type="image" src="graphics/button_edit.png" style="position:absolute;left:10px;top:250px;" />
   <input type="image" src="graphics/button_setting.png" style="position:absolute;left:10px;top:300px;"  />
   <input type="image" src="graphics/button_help.png" style="position:absolute;left:10px;top:350px;" />
  </div>


	<script src="script/third-party/leaflet.js"></script>
	<script src="script/third-party/jquery-1.11.3.min.js"></script>	
	<script src="script/Model.js"></script>
	<script src="script/Timeline.js"></script>
	<script src="script/Controller.js"></script>	
	<script src="script/main.js"></script>
  </body>
</html>
