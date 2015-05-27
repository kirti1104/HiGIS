# IMPORTANT:
# use Python version >= 3.0 in order to use encoding="utf-8"

# IMPORTS #

import json
from shapely.geometry import *


# INPUT AND CONSTANTS #
IN                = "countries.geojson"
PATH              = "/home/marcus/HistoGlobe/HistoGlobeAtSchool/config/school/data/"


# load input json
with open(PATH+IN) as input_file:
  geojson_data = json.load(input_file)

  for feature in geojson_data['features']:
    name = feature['properties']['id']
    geo = shape(feature['geometry'])

    if geo.is_valid == False:
      print(name)
