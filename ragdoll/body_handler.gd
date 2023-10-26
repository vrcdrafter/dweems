extends Node3D

var rotation_handle

var model_rotate_command := 0
var axis = Vector3(0, 1, 0)
var current_rotation = Vector3(0, 0, 0)
var spin_velocity 

@export var anim_ready_jump := false

func _process(delta):
	rotation_handle = get_node("../SpringArm3D")
	
	model_rotate_command = rotation_handle.camera_rotation
	#print("imported_rotation",model_rotate_command)
	
	#model_rotate_command = deg_to_rad(model_rotate_command)
	
	current_rotation = self.get_rotation_degrees()
	#print("current rotation unsnapped", current_rotation)
	model_rotate_command = snapped(model_rotate_command,0.01)
	
	current_rotation = snapped(current_rotation.y,0.01)
	spin_velocity = model_rotate_command - current_rotation - 180 # subtracted 90 to get rot right 
	

	spin_velocity = deg_to_rad(spin_velocity)
	transform.basis = Basis(axis, spin_velocity) * transform.basis

	# at end of process force animation_ready_jump = false 
	

func jump_sig_custom():
	print("custom jump _signal")
	anim_ready_jump = true
	await get_tree().create_timer(.1).timeout 
	anim_ready_jump = false



