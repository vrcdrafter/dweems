
extends Node3D

var animation_handle
var animation_track_handle
var whats_in_hand_haldle 
var item_in_hand 
var anim_flag_handle
var flag
var landed
@export var interacting  = false
var is_in_air
var is_jumping = false
var no_movement = false
var is_upper_handle
var snake_handle
var dialogue_handle
signal open_interact
@export var one_shot_sig = true
var tv_handl

@export var pickup_thro_flip_flop = 1

@export var walking_sound = true

func _ready():
	snake_handle = get_node("/root/Node3D")
	if has_node("/root/Node3D/steve"):
		snake_handle.ensnared_status.connect(hold_all_motion.bind())
		snake_handle.free_to_go.connect(resume_all_motion.bind())
		
	dialogue_handle = get_node("/root/Node3D/Path3D/PathFollow3D18/MeshInstance3D/dialoge_system")
	if has_node("/root/Node3D/Path3D/PathFollow3D18/MeshInstance3D/dialoge_system"):
		print("signals connected")
		dialogue_handle.dialogue_done.connect(can_talk_again.bind())
		dialogue_handle.dont_move_chat.connect(hold_all_motion.bind())
		dialogue_handle.resume_move.connect(resume_all_motion.bind())

	# declaration of items 
	one_shot_sig = true # temp set , may delete. 


	if has_node("../../../tv/Area3D"):
		tv_handl = get_node("../../../tv/Area3D")
		print("tv", tv_handl.viscinity)
	#bindings for conversation


func _process(delta):
	anim_flag_handle = get_node("../..")
	flag = anim_flag_handle.animation_flags
	landed = anim_flag_handle.land_flag
	is_in_air = anim_flag_handle.on_floor
	animation_handle = get_node("../AnimationPlayer")
	whats_in_hand_haldle = get_node("./Skeleton3D/BoneAttachment3D")
	is_upper_handle = get_node("../upper_pickup_box")
	animation_track_handle = animation_handle.get_animation("idle")
	
	# check is steve is present and hold all motion if ensnared 

	
	
	
	item_in_hand = whats_in_hand_haldle.current_hand_item
	
	

	if flag[3] == 1 and not is_jumping and not landed and not interacting and not no_movement:
		animation_handle.speed_scale = 1
		animation_handle.play("straft_l") 
		walking_sound = true
	elif flag[2] == 1 and not is_jumping and not landed  and not interacting and not no_movement:
		animation_handle.speed_scale = 1
		animation_handle.play("straft_r")
		walking_sound = true
	elif flag[1] == 1 and not is_jumping and not landed and not interacting and not no_movement:
		animation_handle.speed_scale = 1
		animation_handle.play("backwards")
		walking_sound = true
	elif flag[0] == 1 and not is_jumping and not landed and not interacting and not no_movement: # something is wrong with this code becasuse you can run when interacting 
		
		if (Input.is_action_just_pressed("jump") or is_jumping) and not landed and not interacting: # this is a problem 
			print("jump triggered ")
			animation_handle.speed_scale = 1
			animation_handle.play("jump")
			is_jumping = true
			walking_sound = false
		else:
			animation_handle.speed_scale = 1
			animation_handle.play("running_2")
			walking_sound = true
	elif not is_jumping and not landed and not interacting:
		animation_handle.speed_scale = 1
		animation_handle.play("idle")
		is_jumping = false
		walking_sound = false
		
	if (flag[4] == 1 or is_jumping) and not landed and not interacting and not no_movement: # this is a problem 
		
		animation_handle.speed_scale = 1
		animation_handle.play("jump")
		
		is_jumping = true
		walking_sound = false
	elif landed: # might be triggering before floor
		
		animation_handle.speed_scale = 1
		animation_handle.play("land")
		is_jumping = false
		walking_sound = false

# begin routine for aux animations 
	if flag[6] == 1 and not is_jumping and not landed:
		walking_sound = false
		if pickup_thro_flip_flop == 1:
			# decide whether its a upper object or lower object
			if is_upper_handle.has_overlapping_bodies():
				animation_handle.play("press")
				walking_sound = false
			else:
				animation_handle.speed_scale = 2
				animation_handle.play("pickup")
				print("pickup")
				walking_sound = false
			interacting = true
		if pickup_thro_flip_flop == 2:
			# 
			print(is_instance_valid(whats_in_hand_haldle.current_hand_item))
			if whats_in_hand_haldle.current_hand_item.is_in_group("food"): # need to check if item exists , Never fixed this . 
				interacting = true
				animation_handle.speed_scale = 2
				animation_handle.play("drink")
				walking_sound = false
			else :
				interacting = true
				animation_handle.speed_scale = 2
				animation_handle.play("throw")
				walking_sound = false
				
	if flag[8] == 1 and not is_jumping and not landed:
		
		if one_shot_sig: # get handle for node
			print("trying to talk")
			emit_signal("open_interact")
			interacting = true
			walking_sound = false
			one_shot_sig = false
		elif tv_handl != null :
			if tv_handl.viscinity:
				emit_signal("open_interact")
				interacting = true
				walking_sound = false
				animation_handle.play("press_2")
		else:
			walking_sound = false
			interacting = true
			if not no_movement:
				animation_handle.play("press_2")
				# may need to emit signal here to lock out all motion
		
	
func _on_animation_player_animation_finished(anim_name): # action , need to have cup leave hand on throw, might need to be groups
	if anim_name == "jump" and landed:
		animation_handle.stop()
		is_jumping = false
		print("null")
	if anim_name == "pickup":
		pickup_thro_flip_flop = 2
		interacting = false
		print("finished picking up ")
	
	if anim_name == "throw":
		pickup_thro_flip_flop = 1
		print("finished throw")
		interacting = false
	if anim_name == "drink":
		pickup_thro_flip_flop = 1
		
		interacting = false
	if anim_name == "press":
		pickup_thro_flip_flop = 2
		
		interacting = false
		
	if anim_name == "press_2":
		pickup_thro_flip_flop = 2
		
		interacting = false



func gimme_speech_bub(text_to_say):
	var scene = preload("res://animations/text_bubble.tscn")
	
	var newCrop = scene.instantiate() #creates a new node
	newCrop.text = "hello this is cool \n no like really cool "
	get_parent().add_child(newCrop) #this adds the new crop as a child of the current node
	
	
	print("child found ", find_child("*"))
	get_instance_id()
	
func hold_all_motion():
	
	no_movement = true

func resume_all_motion():
	print("resume motion  ")
	no_movement = false
	
	
func can_talk_again():
	one_shot_sig = true
	print("sending signal for talk again ")
	

	
