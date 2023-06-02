extends Node3D

var animation_handle
var animation_track_handle

var anim_flag_handle
var flag 

func _ready():
	pass

func _process(delta):
	anim_flag_handle = get_node("../..")
	flag = anim_flag_handle.animation_flags
	
	animation_handle = get_node("../AnimationPlayer")
	
	animation_track_handle = animation_handle.get_animation("idle")
	
	
	
	
	if flag[4] == 1:
		animation_handle.play("jump")
