extends Node3D

var rotation_handle

var model_rotate_command := 0
var axis = Vector3(0, 1, 0)
var current_rotation = Vector3(0, 0, 0)
var spin_velocity 

func _process(delta):
	rotation_handle = get_node("../SpringArm3D")
	
	model_rotate_command = rotation_handle.camera_rotation
	#print("imported_rotation",model_rotate_command)
	
	#model_rotate_command = deg_to_rad(model_rotate_command)
	
	current_rotation = self.get_rotation_degrees()
	#print("current rotation unsnapped", current_rotation)
	model_rotate_command = snapped(model_rotate_command,0.01)
	
	current_rotation = snapped(current_rotation.y,0.01)
	spin_velocity = model_rotate_command - current_rotation
	
	#print("model_rot ",model_rotate_command," current rotate ",current_rotation)
	print("clamped, velocity ",spin_velocity)
	spin_velocity = deg_to_rad(spin_velocity)
	transform.basis = Basis(axis, spin_velocity) * transform.basis
