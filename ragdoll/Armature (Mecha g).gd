extends Node3D

var animation_handle
var animation_track_handle

var anim_flag_handle
var flag
var landed 
var is_in_air
var is_jumping = false

func _ready():
	pass

func _process(delta):
	anim_flag_handle = get_node("../..")
	flag = anim_flag_handle.animation_flags
	landed = anim_flag_handle.land_flag
	is_in_air = anim_flag_handle.on_floor
	animation_handle = get_node("../AnimationPlayer")
	
	animation_track_handle = animation_handle.get_animation("idle")
	
	#print(flag)
	#print(landed)
	
	if flag[3] == 1 and not is_jumping and not landed:
		animation_handle.play("straft_l") 
	elif flag[2] == 1 and not is_jumping and not landed :
		animation_handle.play("straft_r")
	elif flag[1] == 1 and not is_jumping and not landed:
		animation_handle.play("backwards")
	elif flag[0] == 1 and not is_jumping and not landed :
		print(flag[4])
		if (Input.is_action_just_pressed("jump") or is_jumping) and not landed: # this is a problem 
			print("jump triggered ")
			animation_handle.play("jump")
			is_jumping = true
		else:
			animation_handle.play("walk")
	elif not is_jumping and not landed:
		animation_handle.play("idle")
		is_jumping = false
		#print("playing idle")
	if (flag[4] == 1 or is_jumping) and not landed: # this is a problem 
		print("jump triggered ")
		animation_handle.play("jump")
		is_jumping = true
	elif landed: # might be triggering before floor
		print("should be landing")

		animation_handle.play("land")
		is_jumping = false





func _on_animation_player_animation_finished(anim_name):
	if anim_name == "jump" and landed:
		animation_handle.stop()
		is_jumping = false
		print("null")
