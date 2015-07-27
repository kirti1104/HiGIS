<?php
  echo "Horst <br/>";

  //Connection creds
  $servername = "localhost";
  $username   = "root";
  $password   = "";
  $dbname     = "newhigisdb";

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);

  // Check connection
  if ($conn->connect_error)
    die("Connection failed: " . $conn->connect_error);


  // get country geometry from URL
  $ctr = $_GET["ctr"];


  // GET GEOMETRY
  // =============

  // final geometry array!
  $area_geo = array();
  $polygons = array();
    // "p_id" => "pg",
    // "pl_id" => "pl",
    // "pt_id" => "pt",

    // );

  // query ids of polygons in polypolygon
  $polygon_query = "
    SELECT DISTINCT polygon.polygon_id
    FROM (polygon JOIN polygon_in_area JOIN area JOIN name)
    WHERE
    (
      name.name_id = area.name_id AND
      area.area_id = polygon_in_area.area_id AND
      polygon_in_area.polygon_id = polygon.polygon_id AND
      name.off_name_en = '$ctr'
    )";
  $polygon_result = $conn->query($polygon_query);

  // FOR EACH POLYGON IN POLYPOLYGON
  while($polygon_row = $polygon_result->fetch_assoc())
  {
    $polygon_geo = array();

    // test output
    echo $polygon_row["polygon_id"] . "<br/>";

    // query polylines in polygon
    $polyline_query = "
      SELECT DISTINCT polyline.polyline_id
      FROM (polyline JOIN polyline_on_polygon JOIN polygon)
      WHERE
      (
        polyline.polyline_id = polyline_on_polygon.polyline_id AND
        polyline_on_polygon.polygon_id = polygon.polygon_id AND
        polygon.polygon_id = ".$polygon_row["polygon_id"]."
      )
      ORDER BY polyline_on_polygon.polyline_index ASC";
    $polyline_result = $conn->query($polyline_query);

    array_push($polygons, $polygon_row["polygon_id"]);
  } // end while

    echo ("<pre>");
      print_r($polygons);
    echo ("</pre>");


    // FOR EACH POLYLINE IN POLYGON
    while($polyline_row = $polyline_result->fetch_assoc())
    {
      $polyline_geo = array();

      // test output
      echo "-> " . $polyline_row["polyline_id"] . "<br/>";

      // query points in polyline
      $point_query = "
        SELECT (point.point_id)
        FROM (point JOIN point_on_polyline JOIN polyline)
        WHERE
        (
          point.point_id = point_on_polyline.point_id AND
          point_on_polyline.polyline_id = polyline.polyline_id AND
          polyline.polyline_id = ".$polyline_row["polyline_id"]."
      )
      ORDER BY point_on_polyline.point_index ASC";
      $point_result = $conn->query($point_query);
    }

  //     // FOR EACH POINT IN POLYLINE
  //     while($point_row = $point_result->fetch_assoc())
  //     {
  //       $point_geo = array();

  //       // test output
  //       echo "->-> " . $point_row["point_id"] . "<br/>";

  //       // query coordinates in point
  //       $coords_query = "
  //         SELECT DISTINCT point.lat, point.lng
  //         FROM   point, point_on_polyline
  //         WHERE  point.point_id = ".$point_row["point_id"]."
  //       "; //
  //       $coords_result = $conn->query($coords_query);

  //       // FOR THIS VERY FREAKING ONLY ONE PAIR OF COORDINATES IN POINT :/
  //       while($coords_row = $coords_result->fetch_assoc())
  //       {
  //         echo "->->-> " . $coords_row["lat"] . " | " .$coords_row["lng"] . "<br/>";

  //         // add coordinates to its point
  //         $point_geo[0] = floatval($coords_row["lat"]);
  //         $point_geo[1] = floatval($coords_row["lng"]);
  //       }

  //       // add point to its polyline
  //       array_push($polyline_geo, $point_geo);
  //     }
  //     //$sorted_polyline_geo = asort($polyline_geo);
  //     // add polyline to its polygon
  //     array_push($polygon_geo, $polyline_geo);
  //   }
  //   // add polygon to its polypolygon
  //   array_push($area_geo, $polygon_geo);


  // // STICH POLYLINES TOGETHER -> Million $ question/requirement
  // // ???


  // GET NAME
  // ========
  $area_name = $_GET["ctr"]; // TODO: later, name of country does not come from the user

  $conn->close();


  // CREATE GEOJSON
  // ==============
  $areas = array();
  $areas['type'] = 'FeatureCollection';
  $areas['features'] = array();

  $area = array();
  $area['type'] = 'Feature';

  $area['properties'] = array();
  $area['properties']['name']       = $area_name;
  $area['geometry'] = array();
  $area['geometry']['type']         = 'MultiPolygon';
  $area['geometry']['coordinates']  = $area_geo;

  array_push($areas["features"], $area);

  echo json_encode($areas);

?>
