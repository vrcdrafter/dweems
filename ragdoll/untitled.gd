extends CharacterBody3D

@export var speed := 7.0
@export var jump_strength := 20.0
@export var gravity := 50.0


var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var _model: Node3D  = $fox_body

func _physics_process(delta: float) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP,_spring_arm.rotation.y).normalized()
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	velocity.y -= gravity * delta
	print("speed",speed)
	print("Move_direction",move_direction)
	print("body is trying to move",velocity)
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	if is_jumping:
		velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	
	move_and_slide()
func _process( delta: float) -> void:
	_spring_arm.position = position
