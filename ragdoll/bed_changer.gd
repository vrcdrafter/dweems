extends Area3D

var text_new = "should I go sleep now ? "
var anim_flag_handle
var status_array
var one_shot = false
var in_bed_area = false

func _on_body_entered(body):

	in_bed_area = true
	print(" find ")

func _ready():
	one_shot = true


func _process(delta):
	anim_flag_handle = get_node("../untitled")
	status_array = anim_flag_handle.animation_flags
	
	
	
	if status_array[8] == 1 and in_bed_area:
		
		if one_shot:
			print(" can change scenes")
			LoadManager._load_scene("res://level/dream_1/level1.tscn")
			one_shot = false
		#get_tree().change_scene_to_file("res://level/dream_1/level1.tscn")

func _on_body_exited(body):
	in_bed_area = false
