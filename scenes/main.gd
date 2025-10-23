class_name Main
extends Node


const OPENING_SCENE: String = "res://scenes/start_area.tscn"

var levels: Dictionary[String, Mission] = {
	"res://levels/plainsview_level.tscn": QuotaMission.new(180, 10000),
	"res://levels/hill_top_town_level.tscn": QuotaMission.new(120, 7000),
	"res://levels/sea_cliff_city_level.tscn": QuotaMission.new(250, 18000)
}

@onready var loading_screen: LoadingScreen = %LoadingScreen

var scene_path: String
var current_scene: Node


func _ready() -> void:
	DataAccess.load_user_data()
	
	_load_scene(OPENING_SCENE)


func _process(_delta) -> void:
	var progress = []
	ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	if progress[0] == 1:
		# set new scene
		var packed_scene: PackedScene = ResourceLoader.load_threaded_get(scene_path)
		current_scene = packed_scene.instantiate()
		add_child(current_scene)
		
		# connect the signals
		if current_scene is StartArea:
			(current_scene as StartArea).load_level.connect(_handle_load_level)
		elif current_scene is Level:
			var level = current_scene as Level
			
			level.setup(
				levels.get(scene_path), 
				_handle_replay_level, 
				_handle_next_level,
				_handle_exit_level
			)
			
			level.run()
		
		# no need for this >:)
		loading_screen.close()


func _handle_load_level(path: String) -> void:
	_load_scene(path)


func _handle_replay_level() -> void:
	_load_scene(scene_path)


func _handle_next_level() -> void:
	var next_level_index = levels.keys().rfind(scene_path) + 1
	if next_level_index == levels.size():
		# game over man
		_load_scene(OPENING_SCENE)
		next_level_index = 0
	else:
		var path = levels.keys()[next_level_index]
		_load_scene(path)


func _handle_exit_level() -> void:
	_load_scene(OPENING_SCENE)


func _load_scene(path: String) -> void:
	loading_screen.open()
	
	# remove old scene
	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
	
	# load in new scene
	scene_path = path
	ResourceLoader.load_threaded_request(scene_path)
