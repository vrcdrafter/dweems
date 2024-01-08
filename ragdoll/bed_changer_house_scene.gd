extends Area3D

var text_new = "should I go sleep now ? "
var anim_flag_handle
var status_array

var in_bed_area = false




func _process(delta):
	if is_instance_valid(get_node("../untitled")):
		anim_flag_handle = get_node("../untitled")
		status_array = anim_flag_handle.animation_flags
	
	if status_array[8] == 1 and in_bed_area:
		print(" can change scenes")
		get_tree().change_scene_to_file("res://house_scene.tscn")



func _on_body_entered(body):
	in_bed_area = true
	print(" near the bed level forest")



func _on_body_exited(body):
	in_bed_area = false



