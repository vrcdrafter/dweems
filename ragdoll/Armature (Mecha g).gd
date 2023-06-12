extends Node3D

var animation_handle
var animation_track_handle

var anim_flag_handle
var flag
var landed 

var is_jumping = false

func _ready():
	pass

func _process(delta):
	anim_flag_handle = get_node("../..")
	flag = anim_flag_handle.animation_flags
	landed = anim_flag_handle.land_flag
	animation_handle = get_node("../AnimationPlayer")
	
	animation_track_handle = animation_handle.get_animation("idle")
	
	
	print(landed)
	
	if flag[4] == 1 or is_jumping:
		animation_handle.play("jump")
		is_jumping = true
	elif flag[3] == 1 and !is_jumping:
		animation_handle.play("straft_l") 
	elif flag[2] == 1 and !is_jumping:
		animation_handle.play("straft_r")
	elif flag[1] == 1 and !is_jumping:
		animation_handle.play("backwards")
	elif flag[0] == 1 and !is_jumping:
		animation_handle.play("walk")
	elif landed:
		print("should be landing")
		#animation_handle.stop()
		animation_handle.play("land")
		is_jumping = false
		
	else:
		animation_handle.play("idle")
		





