'''
THIS FILE CONTAINS ALL THE FUNCTIONS THAT HELPS DOING THE THIRD TASK OF 
FINAL PROJECT 

Functions: 
    get_all_categories1():      get all items from a dictionary 
                                (dictionary: objects, colors)
    get_all_categories2():      get all items from a nested dictionary
                                (nested dictionary: places, semantic scenes)
    get_scene_list():           get a list of all scenes from reading csv file 
    get_full_scene_time():      get a list of all seconds in a scene 
    get_imgfeature_dictionary():get a shortened dictionary containing only  
                                necessary information 
    get_feature_single_scene1():tally the features' value of a single scene 
                                (dictionary: objects, colors)
    get_feature_single_scene2():tally the features' value of a single scene 
                                (nested dictionary: places, semantic scenes)
    get_feature_all_scenes1():  tally the features' value of all the scenes 
                                (dictionary: objects, colors)
    get_feature_all_scenes2():  tally the features' value of all the scenes 
                                (nested dictionary: places, semantic scenes)
    find_main_feature():        find three features (objects, colors, places, or 
                                semantic scenes) that appear the most in all scenes

Author: Pham Lan Phuong
Group: 2
Course: Spring'22 CS1 
Course instructor: Phan Thanh Trung 
'''
import csv
import json

def get_all_categories1(key):
    '''FOR OBJECTS AND COLORS (1 key required)
    Get items in categories that require one key, i.e. object classifications
    and colors. 

    Parameters: 
        key:    a string of keys to access the dictionary.
    
    Returns: 
        a list of all the items in the categories.
    '''
    all_stuffs = []
    with open("visual_LateNight_YSPqIq0uVUA.json", "r") as f: 
        json_data = [json.loads(line) for line in f]
        items = json_data[0]['imgfeatures'][key].keys()
        for item in items: 
            all_stuffs.append(item)
    return all_stuffs

def get_all_categories2(key1, key2):
    '''FOR SEMANTIC SCENES AND PLACES (2 keys required)
    Get items in categories that require one key, i.e. object classifications
    and colors. 

    Parameters: 
        key1:   a string of keys to access the outter dictionary.
        key2:   a string of keys to access the inner dictionary. 
    
    Returns: 
        a list of all the items in the categories.
    '''
    all_stuffs = []
    with open("visual_LateNight_YSPqIq0uVUA.json", "r") as f: 
        json_data = [json.loads(line) for line in f]
        items = json_data[0]['imgfeatures'][key1][key2].keys()
        for item in items: 
            all_stuffs.append(item)
    return all_stuffs

# video ID stored globally for later access 
WEEAT_ID = '_PtMqiCYJT4'
LATENIGHT_ID = 'YSPqIq0uVUA'
# list of all 1000 objects, 512 colors, 365 places, 150 semantic scenes
all_objects = get_all_categories1("classify")
all_colors =  get_all_categories1("true_color")
all_places = get_all_categories2("places", "categories")
all_semantic_scenes = get_all_categories2("scene", "scene")

# read file csv, get and return a list of scenes 
def get_scene_list(filename):
    '''Reads file CSV and gets a list of all scenes in the video. Note that each 
    scene is one line in the CSV file. 

    Parameter: 
        filename:   a string indicating the name of the csv file. 
    
    Returns: 
        a list of all scenes in one video, except for the first element being
        the title of the columns, not a scene. 
    '''
    scene_list = []
    with open(filename, "r", encoding="mbcs") as f: 
        csvfile = csv.reader(f)
        # append each line in csv file as a single scene in return list
        for item in csvfile: 
            scene_list.append(item)
    return scene_list

# read start & end time in csv file; scene_number == line in csv file 
def get_full_scene_time(scene_list, scene_number):
    '''Gets a list of all the seconds that a single visual scene lasts. For 
    example, if scene #4 lasts from second 53 to second 61, the output would be 
    [53, 54, 55, 56, 57, 58, 59, 60, 61]. 

    Parameter: 
        scene_list:     a list of all scenes in one video. 
        scene_number:   an integer indicating scene number.
    
    Returns: 
        a list of detailed time in one single scene. 
    '''
    start = eval(scene_list[scene_number][1])
    end = eval(scene_list[scene_number][2])
    detailed_scene_time = [i for i in range(start, end+1)]
    return detailed_scene_time 

def get_imgfeature_dictionary(filename):
    '''Creates a dictionary with key == scene name (or "picName" in visual file) 
    and the value == dictionary of 1000 objects ("imgfeatures" > "classify" in 
    visual file).

    Parameter: 
        filename:   a string indicating the name of the visual file. 
    
    Return: 
        a nested dictionary containing only the information about imgfeatures 
        in each second of the video. 
    '''
    shortened_dictionary = {}
    with open(filename, "r") as f: 
        json_data = [json.loads(line) for line in f]
        # create a dictionary with scene_number as key & 
        # dict of 1000 objects as value
        for i in range(len(json_data)): 
            key = json_data[i]["picName"]
            value = json_data[i]["imgfeatures"]
            shortened_dictionary[key] = value
    return shortened_dictionary

# scene_list
we_eat_scenes_list = get_scene_list("[output_t1]WeEat_annotation.csv")
late_night_scenes_list = get_scene_list("[output_t1]LateNight_annotation.csv")
# video_dictionary
we_eat_shortened_dictionary = get_imgfeature_dictionary("visual_WeEat__PtMqiCYJT4.json")
late_night_shortened_dictionary = get_imgfeature_dictionary("visual_LateNight_YSPqIq0uVUA.json")

def get_feature_single_scene1(scene_list, scene_number, video_id, video_dictionary, key, all_list):
    '''FOR OBJECTS AND COLORS (1 key required)
    Gets the value of object appearance for every object in one scene
    
    Parameter: 
        scene_list:         a list of all scenes in one video.
        scene_number:       an integer indicating scene number.
        video_id: the       ID of the video, stored as global var above.
        video_dictionary:   the shortened dictionary containing information 
                            about the 1000 objects.
    
    Returns: 
        a dictionary containing tally of appearance frequency of each object in
        a single scene. 
    '''
    single_scene_feature_tally = {}
    detailed_scene_time = get_full_scene_time(scene_list, scene_number)
    # initialized dictionary with key == objects and values == float value 0 
    for item in all_list: 
        single_scene_feature_tally[item] = 0.0
    # adding the value of the objects in shortened video_dictionary to the value
    # in the tally dictionary to get a total value of object appearance
    for item in all_list: 
        for sec in detailed_scene_time: 
            single_scene_feature_tally[item] += video_dictionary[f"{video_id}__video-frame{sec}.jpg"][key][item]
    return single_scene_feature_tally

def get_feature_single_scene2(scene_list, scene_number, video_id, video_dictionary, key1, key2, all_list):
    '''FOR SEMANTIC SCENES AND PLACES (2 keys required)
    Gets the value of object appearance for every object in one scene
    
    Parameter: 
        scene_list:         a list of all scenes in one video.
        scene_number:       an integer indicating scene number.
        video_id: the       ID of the video, stored as global var above.
        video_dictionary:   the shortened dictionary containing information 
                            about the 1000 objects.
    
    Returns: 
        a dictionary containing tally of appearance frequency of each object in
        a single scene. 
    '''
    single_scene_feature_tally = {}
    detailed_scene_time = get_full_scene_time(scene_list, scene_number)
    # initialized dictionary with key == objects and values == float value 0 
    for item in all_list: 
        single_scene_feature_tally[item] = 0.0
    # adding the value of the objects in shortened video_dictionary to the value
    # in the tally dictionary to get a total value of object appearance
    for item in all_list: 
        for sec in detailed_scene_time: 
            single_scene_feature_tally[item] += video_dictionary[f"{video_id}__video-frame{sec}.jpg"][key1][key2][item]
    return single_scene_feature_tally

# functions dealing with colors, semantic scenes, places could be duplicate of
# this function or share this function, in the latter case rename to be accurate
def get_feature_all_scenes1(scene_list, video_id, video_dictionary, key, all_list): 
    '''FOR OBJECTS AND COLORS (1 key required)
    Loop through all scences and use the get_feature_single_scene() 
    to analyze objects in the scene, then return a list of all tallied scenes.

    Parameters: 
        scene_list:         a list of all scenes in one video.
        video_id: the       ID of the video, stored as global var above.
        video_dictionary:   the shortened dictionary containing information 
                            about the 1000 objects.
    Returns: 
        a list of all tallied scenes of one video. 
    '''
    all_scenes_tally = []
    for scene_number in range(1, len(scene_list)):
        single_scene = get_feature_single_scene1(scene_list, scene_number, video_id, video_dictionary, key, all_list)
        all_scenes_tally.append(single_scene)
    return all_scenes_tally

def get_feature_all_scenes2(scene_list, video_id, video_dictionary, key1, key2, all_list): 
    '''FOR SEMANTIC SCENES AND PLACES (2 keys required)
    Loop through all scences and use the get_feature_single_scene() 
    to analyze objects in the scene, then return a list of all tallied scenes.

    Parameters: 
        scene_list:         a list of all scenes in one video.
        video_id: the       ID of the video, stored as global var above.
        video_dictionary:   the shortened dictionary containing information 
                            about the 1000 objects.
    Returns: 
        a list of all tallied scenes of one video. 
    '''
    all_scenes_tally = []
    for scene_number in range(1, len(scene_list)):
        single_scene = get_feature_single_scene2(scene_list, scene_number, video_id, video_dictionary, key1, key2, all_list)
        all_scenes_tally.append(single_scene)
    return all_scenes_tally

# getting the tally of the features 
late_night_semantic = get_feature_all_scenes2(late_night_scenes_list, LATENIGHT_ID, late_night_shortened_dictionary, "scene", "scene", all_semantic_scenes)
we_eat_objects = get_feature_all_scenes1(we_eat_scenes_list, WEEAT_ID, we_eat_shortened_dictionary, "classify", all_objects)
late_night_objects = get_feature_all_scenes1(late_night_scenes_list, LATENIGHT_ID, late_night_shortened_dictionary, "classify", all_objects)
we_eat_colors = get_feature_all_scenes1(we_eat_scenes_list, WEEAT_ID, we_eat_shortened_dictionary, "true_color", all_colors)
late_night_colors = get_feature_all_scenes1(late_night_scenes_list, LATENIGHT_ID, late_night_shortened_dictionary, "true_color", all_colors)
we_eat_places = get_feature_all_scenes2(we_eat_scenes_list, WEEAT_ID, we_eat_shortened_dictionary, "places", "categories", all_places)
late_night_places = get_feature_all_scenes2(late_night_scenes_list, LATENIGHT_ID, late_night_shortened_dictionary, "places", "categories", all_places)
we_eat_semantic = get_feature_all_scenes2(we_eat_scenes_list, WEEAT_ID, we_eat_shortened_dictionary, "scene", "scene", all_semantic_scenes)
late_night_semantic = get_feature_all_scenes2(late_night_scenes_list, LATENIGHT_ID, late_night_shortened_dictionary, "scene", "scene", all_semantic_scenes)

# sort the dictionary by values, in decreasing order 
# then we take 3 first items to get the 3 most appeared objects in the scene
def find_main_feature(tallied_feature_list):
    '''Sort the tally dictionary by value, in decreasing order, then get the 
    first 3 features because they are the 3 most likely to appear in the scene. 

    Parameter: 
        tallied_feature_list:   a list of dictionaries, where item index (+ 1) 
                                is the scene number and the 3 first items are 
                                the features most likely to appear in scene.
    
    Returns: 
        a dictionary containing the 3 most likely to appear features (or main
        features) of that scene. 
    '''
    main_feature_dictionary = {}
    for i in range(len(tallied_feature_list)): 
        sorted_list = sorted(tallied_feature_list[i].items(), key=lambda kv:(kv[1], kv[0]), reverse=True)
        main_feature_dictionary[f"scence_{i+1}"] = sorted_list[0:3]
    return main_feature_dictionary

# each of these is a dictionary of 3 most appeared feature of each scene in 
# one video 
main_objects_WEEAT = find_main_feature(we_eat_objects)
main_object_LATENIGHT = find_main_feature(late_night_objects)
main_colors_WEEAT = find_main_feature(we_eat_colors)
main_colors_LATENIGHT = find_main_feature(late_night_colors)
main_places_WEEAT = find_main_feature(we_eat_places)
main_places_LATENIGHT = find_main_feature(late_night_places)
main_semantic_WEEAT = find_main_feature(we_eat_semantic)
main_semantic_LATENIGHT = find_main_feature(late_night_semantic)

# final dictionary to store everything 
final_WEEAT_dictionary = {}
final_LATENIGHT_dictionary = {}
categories = ["objects", "colors", "places", "semantic scenes"]
weeat = [main_objects_WEEAT, main_colors_WEEAT, main_places_WEEAT, main_semantic_WEEAT]
latenight = [main_object_LATENIGHT, main_colors_LATENIGHT, main_places_LATENIGHT, main_semantic_LATENIGHT]
for i in range(4): 
    final_WEEAT_dictionary[categories[i]] = weeat[i]
    final_LATENIGHT_dictionary[categories[i]] = latenight[i]

# writing output to json file for easy access in later stages
with open("[output_t3]main_features_WeEat.json", "w", encoding='utf-8') as f: 
    json.dump(final_WEEAT_dictionary, f, ensure_ascii=False, indent=4)
with open("[output_t3]main_features_LateNight.json", "w") as f: 
    json.dump(final_LATENIGHT_dictionary, f, ensure_ascii=False, indent=4)