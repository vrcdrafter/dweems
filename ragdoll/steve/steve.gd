extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
var angle_3d = Vector3(0,0,0)

var speed = 5
var old_velocty = Vector3(0,0,0)

@export var new_velocity = Vector3(0,0,0)
@export var real_time_velocity = Vector3(0,0,0)

func _process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	new_velocity = (next_location - current_location).normalized() * speed
	
	var gradual_rotation = Vector3(0,atan2(old_velocty.x,old_velocty.z),0).lerp(Vector3(0,atan2(new_velocity.x,new_velocity.z),0),1)
	#print(gradual_rotation)
	
	rotation = rotation.lerp(gradual_rotation,.01)
	old_velocty = new_velocity
	velocity = velocity.move_toward(new_velocity, .25)
	real_time_velocity = velocity.move_toward(new_velocity, .25)
	
	move_and_slide()
	
	# 
	
func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
	
