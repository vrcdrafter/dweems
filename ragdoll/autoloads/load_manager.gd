extends Node

signal progress_changed(progress)
signal load_done

var load_screen_path:String = "res://loading_screen/loading_screen.tscn"
var loading_screen = load(load_screen_path)
var loaded_resource: PackedScene
var _scene_path: String
var _progress: Array = []
var use_sub_threads: bool = false

func _load_scene(scene_path: String) -> void:
	_scene_path = scene_path
	
	var new_loading_screen = loading_screen.instantiate()
	get_tree().get_root().add_child(new_loading_screen)
	
	self.progress_changed.connect(new_loading_screen._update_progress_bar)
	self.load_done.connect(new_loading_screen.start_outro_animation)
	
	await Signal(new_loading_screen, "loading_screen_has_full_coverage")
	
	start_load()
	
func start_load() -> void:
	print("scene path requested ", _scene_path)
	var state = ResourceLoader.load_threaded_request(_scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)
	print(state)
func _process(_delta):
	var load_status = ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	match load_status:
		0, 2: # load failed
			print("load failed")
			set_process(false)
			return
		1: # load in progress
			emit_signal("progress_changed", .01)
			print("load in progress")
		3: # finished loading 
			loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			emit_signal("progress_changed", 1.0)
			emit_signal("load_done")
			get_tree().change_scene_to_packed(loaded_resource)
			print("finished loading")
		
