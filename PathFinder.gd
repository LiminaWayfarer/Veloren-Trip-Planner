extends VBoxContainer

var selected_origin : Control
var selected_target : Control

var path_tool : AStar2D
#var current_path : PackedInt64Array
var current_path : PackedVector2Array

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_a_star()

func setup_a_star():
	path_tool = AStar2D.new()
	var id := 0
	var cities = %Cities.get_children()
	for city in cities :
		path_tool.add_point(id, city.global_position + Vector2(7.5, 7.5))
		city.a_star_id = id
		id += 1
	for city in cities :
		for link in city.Links :
			path_tool.connect_points(city.a_star_id, link.a_star_id, true)

func find_path():
	setup_a_star()
	%PathDisplay.clear_points()
	#current_path = path_tool.get_id_path(selected_origin.a_star_id, selected_target.a_star_id)
	current_path = path_tool.get_point_path(selected_origin.a_star_id, selected_target.a_star_id)
	var idx := 0
	for point in current_path :
		%PathDisplay.add_point(point, idx)
		idx += 1
	var distance : Vector2 = selected_origin.position - selected_target.position
	%CityDistance.text = str(distance.length())


func set_origin_city(city : Node) :
	selected_origin = city
	%OriginCity.text = city.name
	if selected_target :
		find_path()

func set_target_city(city : Node) :
	selected_target = city
	%TargetCity.text = city.name
	if selected_origin :
		find_path()


func _on_reset_path_button_pressed():
	%TargetCity.text = "None selected!"
	%OriginCity.text = "None selected!"
	%CityDistance.text = "None"
	current_path.clear()
	%PathDisplay.clear_points()


func _on_show_cities_toggled(toggled_on: bool) -> void:
	for city in %Cities.get_children() :
		city.show_city_name(toggled_on)
