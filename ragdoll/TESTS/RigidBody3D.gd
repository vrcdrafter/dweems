extends RigidBody3D



var rigid_body_handle
var hand_point_handle_1
var hand_point_handle_2
var hand_point_handle_3
var target_angle_z
var target_angle_x
var target_angle_y

var align_points_1
var align_points_2

func zoom_point(object_handle, target_position):
	
	var target_dir = (target_position - object_handle.transform.origin)
	object_handle.linear_velocity = target_dir * 1
	#print(target_dir)

func align_axis(object_handle, target_point1,  target_point2):
	

	# z comp angle
	var angle_ratio_z = (target_point1.y - target_point2.y) / (target_point1.x - target_point2.x)
	target_angle_z = atan(angle_ratio_z)
	target_angle_z = ((target_angle_z - 3.14/2 )- object_handle.rotation.z) * 9
	
	# x comp angle 
	var angle_ratio_x = (target_point1.y - target_point2.y) / (target_point1.z - target_point2.z)
	target_angle_x = atan(angle_ratio_x)
	target_angle_x = ((target_angle_x)- object_handle.rotation.x) * 9
	
	# y comp angle 
	var angle_ratio_y = (target_point1.z - target_point2.z) / (target_point1.x - target_point2.x)
	target_angle_y = atan(angle_ratio_y)
	target_angle_y = ((target_angle_y + 3.14/2)- object_handle.rotation.y) * 9
	
	print(target_angle_z , target_angle_x)
	object_handle.angular_velocity = Vector3(target_angle_x,target_angle_y,target_angle_z)
	#angular_velocity

func _process(delta):
	rigid_body_handle = get_node(".")
	hand_point_handle_1 = get_node("../../Node3D2/MeshInstance3D2")
	hand_point_handle_2 = get_node("../../Node3D2/MeshInstance3D3")
	zoom_point(rigid_body_handle, Vector3(.491,.174,1.013))
	
	align_points_1 = hand_point_handle_1.global_transform.origin
	align_points_2 = hand_point_handle_2.global_transform.origin
	align_axis(rigid_body_handle, align_points_1, align_points_2)
