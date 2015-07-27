# IMPORTANT:
# use Python version >= 3.0 in order to use encoding="utf-8"

# IMPORTS #
import aux

import csv
import json
from shapely.geometry import *
from shapely.ops import *
from string import *

# INPUT AND CONSTANTS #
IN_PATH             = "input/"
IN_AREAS            = "areas.csv"
IN_LABELS           = "labels.csv"
IN_CHANGES          = "changes.csv"

OUT_PATH            = "/home/marcus/HistoGlobe/HistoGlobeAtSchool/config/school/data/"
OUT_AREAS           = "countryAreas.geojson"
OUT_LABELS          = "countryLabels.geojson"
OUT_CHANGES         = "countryChanges.json"
OUT_TRANSITIONS     = "countryTransitions.geojson"

TRANS_PREFIX        = "trans_"

NUM_HEADER_LINES    = 3
NUM_DECIMALS        = 3

# =================================================================
#                             MAIN
# =================================================================

## load data
areas_data   = aux.load_areas(IN_PATH + IN_AREAS, NUM_HEADER_LINES, NUM_DECIMALS)
labels_data  = aux.load_labels(IN_PATH + IN_LABELS, NUM_HEADER_LINES)
changes_data = aux.load_changes(IN_PATH + IN_CHANGES, NUM_HEADER_LINES)

# # check and preprocess data
changes_data = aux.sort_array_with_objects_by_key(changes_data, 'date')
aux.check_changes(areas_data, labels_data, changes_data)

# create transition areas
transitions_data = aux.create_transitions(changes_data, areas_data, TRANS_PREFIX)
transitions_data = aux.clean_transitions(transitions_data)

# prepare data for writing
areas_json        = aux.prepare_areas(areas_data)
labels_json       = aux.prepare_labels(labels_data)
changes_json      = aux.prepare_changes(changes_data)
transitions_json  = aux.prepare_transitions(transitions_data)

# write data
aux.save_file(OUT_PATH+OUT_AREAS, areas_json, False)
aux.save_file(OUT_PATH+OUT_LABELS, labels_json, False)
aux.save_file(OUT_PATH+OUT_CHANGES, changes_json, True)
aux.save_file(OUT_PATH+OUT_TRANSITIONS, transitions_json, False)
