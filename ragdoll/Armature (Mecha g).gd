
extends Node3D

var animation_handle
var animation_track_handle
var whats_in_hand_haldle 
var item_in_hand 
var anim_flag_handle
var flag
var landed
var interacting  = false
var is_in_air
var is_jumping = false
var no_movement = false
var is_upper_handle
var snake_handle
var dialogue_handle
signal open_interact
var one_shot_sig = true

@export var pickup_thro_flip_flop = 1

@export var walking_sound = true

func _ready():
	snake_handle = get_node("/root/Node3D")
	if has_node("/root/Node3D/steve"):
		snake_handle.ensnared_status.connect(hold_all_motion.bind())
		snake_handle.free_to_go.connect(resume_all_motion.bind())
		
	dialogue_handle = get_node("/root/Node3D/dialoge_system")
	if has_node("/root/Node3D/dialoge_system"):
		dialogue_handle.dialogue_done.connect(can_talk_again.bind())


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
	
	walking_sound = true
	if not no_movement:
		if flag[3] == 1 and not is_jumping and not landed and not interacting:
			animation_handle.speed_scale = 1
			animation_handle.play("straft_l") 
		elif flag[2] == 1 and not is_jumping and not landed  and not interacting:
			animation_handle.speed_scale = 1
			animation_handle.play("straft_r")
		elif flag[1] == 1 and not is_jumping and not landed and not interacting:
			animation_handle.speed_scale = 1
			animation_handle.play("backwards")
		elif flag[0] == 1 and not is_jumping and not landed and not interacting: # something is wrong with this code becasuse you can run when interacting 
			
			if (Input.is_action_just_pressed("jump") or is_jumping) and not landed and not interacting: # this is a problem 
				print("jump triggered ")
				animation_handle.speed_scale = 1
				animation_handle.play("jump")
				is_jumping = true
				walking_sound = false
			else:
				animation_handle.speed_scale = 1
				animation_handle.play("walk")
		elif not is_jumping and not landed and not interacting:
			animation_handle.speed_scale = 1
			animation_handle.play("idle")
			is_jumping = false
			walking_sound = false
			
		if (flag[4] == 1 or is_jumping) and not landed and not interacting: # this is a problem 
			
			animation_handle.speed_scale = 1
			animation_handle.play("jump")
			
			is_jumping = true
			walking_sound = false
		elif landed: # might be triggering before floor
			print("should be landing")
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
					
				else:
					animation_handle.speed_scale = 2
					animation_handle.play("pickup")
					print("pickup")
				interacting = true
			if pickup_thro_flip_flop == 2:
				
				print(is_instance_valid(whats_in_hand_haldle.current_hand_item))
				if whats_in_hand_haldle.current_hand_item.is_in_group("food"): # need to check if item exists , Never fixed this . 
					interacting = true
					animation_handle.speed_scale = 2
					animation_handle.play("drink")
				else :
					interacting = true
					animation_handle.speed_scale = 2
					animation_handle.play("throw")
					
		if flag[8] == 1 and not is_jumping and not landed:
			walking_sound = false
			animation_handle.play("press_2")
			interacting = true
			
			if one_shot_sig:
				print("signale emitting from armature ")
				emit_signal("open_interact")
				one_shot_sig = false
		
	
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
	print("dont move , least try not to move ")
	no_movement = true

func resume_all_motion():
	print("resume motion  ")
	no_movement = false
	
	
func can_talk_again():
	one_shot_sig = true
	
