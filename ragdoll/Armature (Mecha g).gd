extends Node3D

var animation_handle
var animation_track_handle

var anim_flag_handle
var flag
var landed 

func _ready():
	pass

func _process(delta):
	anim_flag_handle = get_node("../..")
	flag = anim_flag_handle.animation_flags
	landed = anim_flag_handle.land_flag
	animation_handle = get_node("../AnimationPlayer")
	
	animation_track_handle = animation_handle.get_animation("idle")
	
	
	
	
	if flag[4] == 1:
		animation_handle.play("jump")
	if landed:
		print("should be landing")
		#animation_handle.stop()
		animation_handle.play("land")


