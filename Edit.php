<html>
  <head>
   <!-- <title>HiGIS Project</title> --->
	<link rel="stylesheet" href="style/leaflet.css" />
	<link rel="stylesheet" href="style/main.css" />
	<link rel="stylesheet" href="style/timeline.css" />	
	<link rel="stylesheet" href="style/Edit.css" />	
  </head>
  <body>
<!--	<div style="text-align: center">
		<font size="15" color="green" face="Arial">HiGIS</font>
	</div>
 -->
  
	<div id="map"></div>
  
	<!-- TIMELINE -->
	<div id="timeline">
	  <div id="tlMain"></div>
	</div>
	
	<div>
   <input type="image" src="graphics/button_home.png" style="position:absolute;left:10px;top:250px;"  onclick="window.location.href='index.php'"/>
   <input type="image" src="graphics/button_setting.png" style="position:absolute;left:10px;top:300px;"  />
   <input type="image" src="graphics/button_help.png" style="position:absolute;left:10px;top:350px;" />
   </div>
   
 <fieldset>
  <legend>Event Creation</legend>
  <br>
  <!--
      <label for="name">Name of Event<em>*</em></label>
	  <input id="name" type ="text"/><br>
    
  
      <label for="date">Date of Event<em>*</em></label>
      <input type="date" /><br>
	  
	  <legend> Changes under the event</legend>
	  <br>
  -->
</fieldset>

	<script src="script/third-party/leaflet.js"></script>
	<script src="script/third-party/jquery-1.11.3.min.js"></script>	
	<script src="script/Model.js"></script>
	<script src="script/Timeline.js"></script>
	<script src="script/Controller.js"></script>	
	<script src="script/main.js"></script>
	<script src="script/Edit.php"></script>
  </body>
</html>