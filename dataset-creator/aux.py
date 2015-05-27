# IMPORTS

import csv
import json
import math
from shapely.geometry import *
from shapely.ops import *
from string import *



# =================================================================
# LOADING
# =================================================================

# =================================================================
def load_areas (path, num_header_lines, num_decimals) :
  out_areas = []
  with open(path, 'r') as csv_file:                       # python 2
  # with open(path, 'r', encoding="utf-8") as csv_file:   # python 3
    csv_reader = csv.reader(csv_file, delimiter=',', quotechar='"')
    i = 0

    for line in csv_reader:
      # error handling: ignore lines with file or id missing and ignore table heading
      # id 3: San Marino (1 Polygon)
      # id 267: Denmark+FRO+ICE (4 MultiPolygons)

      if line[0] and line[1] and i>num_header_lines-1:   # ignores first header line
        area = {}

        area['id'] = line[0]

        is_todo = False
        if line[2] is not '':
          is_todo = True

        # get geometry if already done
        if not is_todo:
          geo_file_path = "../"+line[1]+"/"+line[0]+".geojson"  # file
          with open(geo_file_path) as geo_file:
            geo_data = json.load(geo_file)
            geo_coordinates = []
            # get shape from each feature
            for feature in geo_data['features']:
              if(feature['geometry']):
                has_geo = True
                # difference between type 'Polygon' (3x []) and 'MultiPolygon' (4x [])
                # -> make each Polygon a MultiPolygon
                if(feature['geometry']['type'] == 'Polygon'):
                  feature['geometry']['coordinates'] = [feature['geometry']['coordinates']]
                geo_coordinates.append(feature['geometry']['coordinates'])

            area['geo'] = geo_coordinates
            # area['geo'] = min_geo(geo_coordinates, num_decimals)
            # problem: 5 brackets instead of 4?

        else:
          area['geo'] = [[]]
          print("error in area '" + area['id'] + "': area does not exist")

        out_areas.append(area)
      i+=1

    return out_areas
  print("error: area file not found")


# =================================================================
def load_labels (path, num_header_lines) :
  out_labels = []
  with open(path, 'r') as csv_file:                          # python 2
  # with open(path, 'r', encoding="utf-8") as csv_file:      # python 3
    csv_reader = csv.reader(csv_file, delimiter=',', quotechar='"')
    i = 0

    for line in csv_reader:
      # ignore lines with missing id and table heading
      if line[0] and i>num_header_lines-1:
        label = {}
        # get meta information (id, dates)
        label['id'] = line[0]
        label['name'] = line[1]
        label['prio'] = line[2]
        if line[2]:
          label['lat'] = float(line[3])
          label['lng'] = float(line[4])
        else:
          label['lat'] = None
          label['lng'] = None

        out_labels.append(label)
      i+=1

    return out_labels
  print("error: label file not found")


# =================================================================
def load_changes (path, num_header_lines) :
  out_changes = []
  with open(path, 'r') as csv_file:                          # python 2
  # with open(path, 'r', encoding="utf-8") as csv_file:      # python 3
    csv_reader = csv.reader(csv_file, delimiter=',', quotechar='"')
    i = 0

    for line in csv_reader:
      # ignore lines with missing id and table heading
      if line[0] and i>num_header_lines-1:
        change = {}
        # get meta information (id, dates)
        change['id']            = line[0]
        change['date']          = int(line[1])
        change['old_areas']     = csv_cell_to_array(line[2].split())
        change['new_areas']     = csv_cell_to_array(line[3].split())
        change['old_labels']    = csv_cell_to_array(line[4].split())
        change['new_labels']    = csv_cell_to_array(line[5].split())
        change['trans_border']  = None
        change['trans_area']    = None

        out_changes.append(change)
      i+=1

    return out_changes
  print("error: changes file not found")


# =================================================================
# CHECKING
# =================================================================

# =================================================================
# makes sure that a valid change file is created, that is:
# 1) each area and label id is existent
# 2) each old area/label has be also a new label at some point before
def check_changes (in_areas, in_labels, in_changes) :

  # 1) check for id's
  for change in in_changes:

    for old_area in change['old_areas']:
      num = num_elements_in_array(in_areas, old_area)
      if num == 0:
        print("error in change '" + change['id'] + "': old area '" + old_area + "' does not exist")
      elif num > 1:
        print("warning in change '" + change['id'] + "': old area '" + old_area + "' exists " + str(num) + " times in areas data")

    for new_area in change['new_areas']:
      num = num_elements_in_array(in_areas, new_area)
      if num == 0:
        print("error in change '" + change['id'] + "': new area '" + new_area + "' does not exist")
      elif num > 1:
        print("warning in change '" + change['id'] + "': new area '" + new_area + "' exists " + str(num) + " times in areas data")

    for old_label in change['old_labels']:
      num = num_elements_in_array(in_labels, old_label)
      if num == 0:
        print("error in change '" + change['id'] + "': old label '" + old_label + "' does not exist")
      elif num > 1:
        print("warning in change '" + change['id'] + "': old label '" + old_label + "' exists " + str(num) + " times in labels data")

    for new_label in change['new_labels']:
      num = num_elements_in_array(in_labels, new_label)
      if num == 0:
        print("error in change '" + change['id'] + "': new label '" + new_label + "' does not exist")
      elif num > 1:
        print("warning in change '" + change['id'] + "': new label '" + new_label + "' exists " + str(num) + " times in labels data")


  # 2) check if each old label/area used to be a new label/area
  for old_change in in_changes:
    for old_area in old_change['old_areas']:

      old_area_found = False
      for new_change in in_changes:
        for new_area in new_change['new_areas']:

          # check if corresponding area exists
          if old_area == new_area:
            # check temporal conditions
            if old_change['date'] < new_change['date']:
              print("error in change '" + old_change['id'] + "': old area '" + old_area + "' is before new area '" + new_area)

        # state that old area was found -> stop looking for it and proceed to next old area
            old_area_found = True
            break
        if old_area_found is True:
          break

      # state that old area does not have a corresponding new area => error
      if old_area_found is False:
        print("error in change '" + old_change['id'] + "': old area '" + old_area + "' does not have a corresponding new area that is created before")

  for old_change in in_changes:
    for old_label in old_change['old_labels']:

      old_label_found = False
      for new_change in in_changes:
        for new_label in new_change['new_labels']:

          # check if corresponding area exists
          if old_label == new_label:
            # check temporal conditions
            if old_change['date'] < new_change['date']:
              print("error in change '" + old_change['id'] + "': old label '" + old_label + "' is before new label '" + new_label)

        # state that old label was found -> stop looking for it and proceed to next old label
            old_label_found = True
            break
        if old_label_found is True:
          break

      # state that old label does not have a corresponding new label => error
      if old_label_found is False:
        print("error in change '" + old_change['id'] + "': old label '" + old_label + "' does not have a corresponding new label that is created before")


# =================================================================
# PREPARATION
# =================================================================

# =================================================================
def create_transitions (in_changes, in_areas, trans_prefix) :

  out_transitions = []
  trans_counter = 0

  for change in in_changes:

    transition_border = None
    transition_area = None

    old_areas = []
    for old_area in change['old_areas']:
      geo = get_geo(old_area, in_areas)
      old_areas.append(array_to_shape(geo))
    new_areas = []
    for new_area in change['new_areas']:
      geo = get_geo(new_area, in_areas)
      new_areas.append(array_to_shape(geo))

    # decision tree
    # do the areas actually change?
    if len(old_areas) > 0 or len(new_areas) > 0:

      # is the total area of the old and new countries the same?
      unionOld = cascaded_union(old_areas)
      unionNew = cascaded_union(new_areas)
      diff = unionOld.symmetric_difference(unionNew)
      changePortion = 1.0
      if unionNew.area > 0:
        changePortion = diff.area / unionNew.area

      if changePortion < 0.05 and diff.area < 2 : # ?

        # are there two old and two new countries?
        # -> border change => emphasize transition area
        if len(old_areas) is 2 and len(new_areas) is 2:
          A = old_areas[0]
          B = old_areas[1]
          An = new_areas[0]
          Bn = new_areas[1]
          transition_area = (A.intersection(Bn)).union(B.intersection(An))

        else:
          # is there one old and many new countries or the other way?
          # => split / union => emphasize split border
          if  len(old_areas) is 1 and len(new_areas) > 1 or \
              len(old_areas) > 1 and len(new_areas) is 1:

            # get boundary lines of polygon
            lines_old = []
            lines_new = []
            for old_area in old_areas:
              lines_old.append(old_area.boundary)
            for new_area in new_areas:
              lines_new.append(new_area.boundary)
            line_old = cascaded_union(lines_old)
            line_new = cascaded_union(lines_new)

            border = line_old.symmetric_difference(line_new)
            if border.length > 0:
              transition_border = linemerge(border)

          else:
            # print("shit case 2", diff.area, change['id'])
            pass  #  shit case 2 ignored

      # the total area of old and new countries has changed or no old/new countries
      else:

        # is there one old and one new country?
        if len(old_areas) is 1 and len(new_areas) is 1:
          A = old_areas[0]
          An = new_areas[0]
          transition_area = A.symmetric_difference(An)

        else:
          # is there either no old or no new country?
          if len(old_areas) is 0 or len(new_areas) is 0:
            pass # new/old areas ignored

          else:
            pass # shit case 1 ignored

    # append and assign transitions
    if transition_border != None:
      my_id = str(trans_prefix) + str(trans_counter)

      change['trans_border'] = my_id

      trans = {}
      trans['id']     = my_id
      trans['type']   = "transBorder"
      trans['geo']    = shape_to_array(transition_border)

      out_transitions.append(trans)
      trans_counter += 1

    if transition_area != None:
      my_id = str(trans_prefix) + str(trans_counter)

      change['trans_area'] = my_id

      trans = {}
      trans['id']     = my_id
      trans['type']   = "transArea"
      trans['geo']    = shape_to_array(transition_area)

      out_transitions.append(trans)
      trans_counter += 1

  return out_transitions


# =================================================================
def clean_transitions (in_transitions) :
  return in_transitions

# =================================================================
def prepare_areas (in_areas) :
  out_areas = {}
  out_areas['type'] = 'FeatureCollection'
  # load areas
  out_areas['content'] = 'areas'
  out_areas['features'] = []

  for area in in_areas:
    out_area = {}
    out_area['type'] = 'Feature'
    # meta features (properties)
    out_area['properties'] = {}
    out_area['properties']['id']         = area['id']
    # actual geometry
    out_area['geometry'] = {}
    out_area['geometry']['type']         = 'MultiPolygon'
    out_area['geometry']['coordinates']  = area['geo'][0]  # if num of [brackets] is too much, make string to area[9][0]

    # write to final array
    out_areas['features'].append(out_area)

  return out_areas


# =================================================================
def prepare_labels (in_labels) :
  out_labels = {}
  out_labels['type'] = 'FeatureCollection'
  # load areas
  out_labels['content'] = 'labels'
  out_labels['features'] = []

  for label in in_labels:
    out_label = {}
    out_label['type'] = 'Feature'
    # meta features (properties)
    out_label['properties'] = {}
    out_label['properties']['id']            = label['id']
    out_label['properties']['name']          = label['name']
    out_label['properties']['prio']          = label['prio']
    out_label['properties']['bounding_box']  = None
    # actual geometry
    out_label['geometry'] = {}
    out_label['geometry']['type'] = 'Point'
    out_label['geometry']['coordinates']  = [label['lat'], label['lng']]

    # write to final array
    out_labels['features'].append(out_label)

  return out_labels


# =================================================================
def prepare_changes (in_changes) :
  out_changes = {}
  out_changes['type'] = 'FeatureCollection'
  # load areas
  out_changes['content'] = 'changes'
  out_changes['features'] = []

  for change in in_changes:
    out_change = {}
    # meta features (properties)
    out_change['id']            = change['id']
    out_change['date']          = change['date']
    out_change['old_areas']     = change['old_areas']
    out_change['new_areas']     = change['new_areas']
    out_change['old_labels']    = change['old_labels']
    out_change['new_labels']    = change['new_labels']
    out_change['trans_area']    = change['trans_area']
    out_change['trans_border']  = change['trans_border']

    # write to final array
    out_changes['features'].append(out_change)

  return out_changes

# =================================================================
def prepare_transitions (in_transitions) :
  out_transitions = {}
  out_transitions['type'] = 'FeatureCollection'

  # load transition areas
  out_transitions['content'] = 'transitions'
  out_transitions['features'] = []

  for trans in in_transitions:
    out_trans = {}
    out_trans['type'] = 'Feature'

    # meta features (properties)
    out_trans['properties'] = {}
    out_trans['properties']['id']   = trans['id']
    out_trans['properties']['type'] = trans['type']

    # actual geometry
    out_trans['geometry']           = trans['geo']

    # write to final array
    out_transitions['features'].append(out_trans)

  return out_transitions


# =================================================================
# WRITING / SAVING
# =================================================================

# =================================================================
def save_file (out_path, out_file, readable) :
  if readable == True:
    open(out_path, "wb").write(json.dumps(out_file, sort_keys=True, indent=2).encode('utf-8'))
  else:
    open(out_path, "wb").write(json.dumps(out_file).encode('utf-8'))


# =================================================================
# HELPER FUNCTIONS
# =================================================================


# =================================================================
# checks the number of occurences of an element in an array
def num_elements_in_array (array, key) :
  out_num = 0
  for elem in array:
    if elem['id'] == key:
      out_num += 1
  return out_num

# =================================================================
def sort_array_with_objects_by_key (array, sort_key) :
  return sorted(array, key=lambda k: k[sort_key])

# =================================================================
# array of coordinates to shapely shape
def array_to_shape (array) :
  return shape(json.loads('{"type": "MultiPolygon", "coordinates": ' + str(array[0]) + '}'))

# =================================================================
def shape_to_array (shape) :
  return (mapping(shape))

# =================================================================
# get the elements from a cell in a csv file, (comma-separated elements)
# and put them into an own array
def csv_cell_to_array (content) :
  content_array = []
  for elem in content:
    elem = str(elem)    # makes sure it is a string
    elem = elem.strip(',')  # strips comma from the end
    content_array.append(elem)
  return content_array

# =================================================================
def get_geo (country_id, areas) :
  for area in areas:
    if area['id'] == country_id:
      return area['geo']

# =================================================================
def min_geo (in_geo, num_decimals) :
  coord_struc = "{:3."+str(num_decimals)+"f}"
  for polypolygon in in_geo:
    for polygon in polypolygon:
      for line in polygon:
        for point in line:
          # now the magic starts... it took an hour any many nerves to figure that out !!!
          for i, val in enumerate(point):
            if i == 0: continue
            point[i] = float(coord_struc.format(val))
  return in_geo

# =================================================================
# def min_geo (in_geo, num_decimals) :
#   coord_struc = "{:3."+str(num_decimals)+"f}"
#   out_coordinates = []
#   for polypolygon in in_geo:
#     out_polypolygon = []
#     for polygon in polypolygon:
#       out_polygon = []
#       for line in polygon:
#         out_line = []
#         for point in line:
#           out_point = []
#           for coordinate in point:
#             out_point.append(float(coord_struc.format(coordinate)))
#           out_line.append(out_point)
#         out_polygon.append(out_line)
#       out_polypolygon.append(out_polygon)
#     out_coordinates.append(out_polypolygon)
#   return out_coordinates
