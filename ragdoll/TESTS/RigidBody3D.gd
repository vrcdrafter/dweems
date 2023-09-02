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
	
	#print(target_angle_z , target_angle_x)
	object_handle.angular_velocity = Vector3(target_angle_x,target_angle_y,target_angle_z)
	#angular_velocity
	
	
func calc_angular_velocity(rigid_body_handle, hand_point_handle_1) -> Vector3:
	var q1 = Quaternion(rigid_body_handle.basis) # need to update to latest quat style for 4.0 documentation e
	var q2 = Quaternion(hand_point_handle_1.basis)

# Quaternion that transforms q1 into q2
	var qt = q2 * q1.inverse()

# Angle from quaternion
	var angle = 2 * acos(qt.w)

# There are two distinct quaternions for any orientation.
# Ensure we use the representation with the smallest angle.
	if angle > PI:
		qt = -qt
		angle = TAU - angle

	# Prevent divide by zero
	if angle < 0.0001:
		return Vector3.ZERO

# Axis from quaternion
	var axis = Vector3(qt.x, qt.y, qt.z) / sqrt(1-qt.w*qt.w)

	return axis * angle
	
func _process(delta):
	rigid_body_handle = get_node(".")
	hand_point_handle_1 = get_node("../Node3D2/MeshInstance3D2")
	hand_point_handle_2 = get_node("../Node3D2/MeshInstance3D3")
	zoom_point(rigid_body_handle, Vector3(.491,.174,1.013))
	
	align_points_1 = hand_point_handle_1.global_transform.origin
	align_points_2 = hand_point_handle_2.global_transform.origin
	#align_axis(rigid_body_handle, align_points_1, align_points_2)
	var quat_align = calc_angular_velocity(rigid_body_handle,hand_point_handle_1)
	
	
	rigid_body_handle.angular_velocity = quat_align
	
	
