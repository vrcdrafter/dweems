extends BoneAttachment3D

var item_array = ["One", 2, 3, "Four"]

var item_handle
var hand_point_handle_1
var hand_point_handle_2
var hand_point_handle_3
var collission_shape_handle
var target_angle_z
var target_angle_x
var target_angle_y

var align_points_1
var align_points_2
var item_snapping = false

func zoom_point(object_handle, target_position):
	
	var target_dir = (target_position - object_handle.transform.origin)
	object_handle.linear_velocity = target_dir * 40
	#print(target_dir)

func calc_angular_velocity(rigid_body_handle, hand_point_handle_1) -> Vector3:
	var q1 = Quaternion(rigid_body_handle.basis) # need to update to latest quat style for 4.0 documentation e
	var q2 = Quaternion(hand_point_handle_1.global_transform.basis)

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

	return axis * angle * 22


func pickup_item(): 
	
	item_snapping = true

func _process(delta):
	if item_snapping:
		item_handle = get_node("../../../../../coffee")
		hand_point_handle_1 = get_node("./origin")
		collission_shape_handle = get_node("../../../Area3D")
		
		align_points_1 = hand_point_handle_1.global_transform.origin
		
		zoom_point(item_handle, align_points_1)
		
		var quat_align = calc_angular_velocity(item_handle,hand_point_handle_1)
		
		item_handle.angular_velocity = quat_align
		
		# get me a list of all bodies in collission shape
		#print(collission_shape_handle.get_overlapping_bodies())
	else:
		pass


	
