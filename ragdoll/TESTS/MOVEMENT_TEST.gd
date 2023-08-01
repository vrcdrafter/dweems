extends Node3D


var rigid_body_handle

func look_follow(state, current_transform, target_position):
	var up_dir = Vector3(0, 1, 0)
	var cur_dir = current_transform.basis * Vector3(0, 0, 1)
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)

	state.angular_velocity = up_dir * (rotation_angle / 1)

func _integrate_forces(state):
	var target_position = Vector3(1,1,1)
	look_follow(state, global_transform, target_position)

func _process(delta):
	rigid_body_handle = get_node("Node3D/RigidBody3D")
	_integrate_forces(rigid_body_handle)

	
