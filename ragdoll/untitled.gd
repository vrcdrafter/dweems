extends CharacterBody3D

@export var speed := 7.0
@export var jump_strength := 17.0
@export var gravity := 50.0
@export var animation_flags = [0,0,0,0,0,0,0,0,0] # forward back left right jump [6] pickup , [7] press  interact , [8] throw
@export var land_flag = false
var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN
var jump_flipflop :bool = false
@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var _model: Node3D  = $fox_body
@onready var on_floor = false
var handle_anim_ready_to_jump
var anim_ready_to_jump:bool = false
var collission_shape_handle
var collission_shape_handle_upper
var interact_script_handle 
var snake_handle
@export var no_movement = false
var interacting = false
var dialogue_handle

func _ready():
	var timer = get_node("untitled/AnimationPlayer")
	timer.animation_finished.connect(_on_animation_player_animation_finished)
	
	snake_handle = get_node("..")
	if has_node("../steve"):
		snake_handle.ensnared_status.connect(hold_all_motion.bind())
		snake_handle.free_to_go.connect(resume_all_motion.bind())
	dialogue_handle = get_node("/root/Node3D/Path3D/PathFollow3D18/MeshInstance3D/dialoge_system")
	if has_node("/root/Node3D/Path3D/PathFollow3D18/MeshInstance3D/dialoge_system"):

		dialogue_handle.dont_move_chat.connect(hold_all_motion.bind())
		dialogue_handle.resume_move.connect(resume_all_motion.bind())	
func _physics_process(delta: float) -> void:
	
	# if you have any interaciton movement is locked out 
	interacting = get_node("untitled/Armature (Mecha g)").interacting #this counters ensnarment
	
	
	# check for closing the program 
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
	
	
	# pull the ineract handle 
	interact_script_handle = get_node("./untitled/Armature (Mecha g)")
	
	# pul in collission data lower
	collission_shape_handle = get_node("./untitled/Area3D")
	
	# pull collission data upper
	collission_shape_handle_upper = get_node("./untitled/upper_pickup_box")
	
	# pull in jump data
	handle_anim_ready_to_jump = get_node("untitled")
	anim_ready_to_jump = handle_anim_ready_to_jump.anim_ready_jump
	# end pull in jump data 
	if not interacting and not no_movement:
	
		var move_direction := Vector3.ZERO
		move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
		move_direction = move_direction.rotated(Vector3.UP,_spring_arm.rotation.y).normalized()
		velocity.x = move_direction.x * speed
		velocity.z = move_direction.z * speed
		velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO 
	# starts the jump animation 
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	if is_jumping: # probably dont need this condition anymore
		jump_flipflop = true
		print("condition satisfied to jump")

	if is_on_floor() and anim_ready_to_jump:
		print("made to right before y up") # might never make it to here . 
		velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	
	elif just_landed:
		land_flag = true
		print("just_landed")
		jump_flipflop = false
		_snap_vector = Vector3.DOWN
	
	# begin routine for pickup and throw 

	
	if Input.get_action_strength("interact") > 0 and is_on_floor() and (collission_shape_handle.has_overlapping_bodies() or collission_shape_handle_upper.has_overlapping_bodies() or (interact_script_handle.pickup_thro_flip_flop == 2)): 
		
		animation_flags[6] = 1
		print("trying to pickup")
		
	else:
		animation_flags[6] = 0
	

	if Input.get_action_strength("throw") > 0 and is_on_floor(): # note this is not used 
	
		animation_flags[7] = 1
		
	else:
		animation_flags[7] = 0
		
	if Input.get_action_strength("push") > 0 and is_on_floor():
		animation_flags[8] = 1
	else:
		animation_flags[8] = 0
	
	# end routine for pickup and throw

	# begin flag setting for export animaiton 
	# only do movement if your not interacting 
	
	if not interacting and not no_movement: # to make sure the character does not move  
		if Input.get_action_strength("right") > 0 and is_on_floor():
			
			animation_flags[0] = 0
			animation_flags[1] = 0
			animation_flags[2] = 0
			animation_flags[3] = 1
			animation_flags[4] = 0
			animation_flags[5] = 0
		elif Input.get_action_strength("left") > 0 and is_on_floor():
			
			animation_flags[0] = 0
			animation_flags[1] = 0
			animation_flags[2] = 1
			animation_flags[3] = 0
			animation_flags[4] = 0
			animation_flags[5] = 0
		elif Input.get_action_strength("forward") > 0 and is_on_floor():

			animation_flags[0] = 1
			animation_flags[1] = 0
			animation_flags[2] = 0
			animation_flags[3] = 0
			animation_flags[4] = 0
			animation_flags[5] = 0
		elif Input.get_action_strength("back") > 0 and is_on_floor():
			
			animation_flags[0] = 0
			animation_flags[1] = 1
			animation_flags[2] = 0
			animation_flags[3] = 0
			animation_flags[4] = 0
			animation_flags[5] = 0
		elif  is_on_floor() and Input.is_action_just_pressed("jump"):
			
			animation_flags[0] = 0
			animation_flags[1] = 0
			animation_flags[2] = 0
			animation_flags[3] = 0
			animation_flags[4] = 1
			animation_flags[5] = 0
		else:
			animation_flags[0] = 0
			animation_flags[1] = 0
			animation_flags[2] = 0
			animation_flags[3] = 0
			animation_flags[4] = 0
			animation_flags[5] = 0
	if no_movement: # for wierd edge case when snake finds you d
		velocity.x = 0
		velocity.z = 0
	# end flag setting for export animation . 
	#reset jump anim var so its ready for next jump 
	anim_ready_to_jump = false
	on_floor = is_on_floor()
	move_and_slide()
func _process( delta: float) -> void:
	_spring_arm.position = position
	
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "land":
		land_flag = false
		
	if anim_name == "pickup":
		
		interacting = false
		
	if anim_name == "throw":
		
		
		interacting = false
	if anim_name == "press":
		
		
		interacting = false



func _on_animation_player_animation_started(anim_name):
	if anim_name == "pickup":
		
		interacting = true
		
	if anim_name == "throw":
		
		
		interacting = true
		
	if anim_name == "press":
		
		interacting = true

func hold_all_motion():
	print("dont move , least try not to move ")
	no_movement = true
func resume_all_motion():
	print("resume motion  ")
	no_movement = false
