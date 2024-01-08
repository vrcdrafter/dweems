extends BoneAttachment3D

var item_array = ["One", 2, 3, "Four"]

var item_handle
var item_handle_group
var item_handle_group_high
@export var current_hand_item = RigidBody3D.new() # this is bas because 
# Pacing When I want to access the node and get teh is_in_group it fails because its references a generic null 
var hand_point_handle_1
var hand_point_handle_2
var hand_point_handle_3
var collission_shape_handle
var collission_shape_handle_high
var target_angle_z
var target_angle_x
var target_angle_y

var align_points_1
var align_points_2
var item_snapping = false
var item_one_shot = false


var destroy_item_bool = false
# export the found item so the other nodes can make decisions on the items . 


func zoom_point(object_handle, target_position):
	
	var target_dir = (target_position - object_handle.transform.origin)
	object_handle.linear_velocity = target_dir * 40


func calc_angular_velocity(rigid_body_handle, hand_point_handle_1) -> Vector3:
	var q1 = Quaternion(rigid_body_handle.basis) # need to update to latest quat style for 4.0 documentation e
	var q2 = Quaternion(hand_point_handle_1.global_transform.basis) # 
	
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


func pickup_item(): # called during the pickup animaton 
	
	item_snapping = true
	destroy_item_bool = false
	item_one_shot = true
func pickup_throw():  # called during the throw animation 
	
	
	item_one_shot = false
func destroy_item():
	destroy_item_bool = true
	item_one_shot = false
	
	

func _ready():
	
	current_hand_item.add_to_group("group_name")



func _process(delta):
	
	
	# 
	# needs to reset item snapping when ready . 
	if item_snapping and ((item_handle_group.size() != 0) or (item_handle_group_high.size() != 0)):
		if item_one_shot:
			if collission_shape_handle_high.has_overlapping_bodies():
				current_hand_item = item_handle_group_high[0] # this fails if it finds nothing 
				
			elif collission_shape_handle.has_overlapping_bodies():
				
				current_hand_item = item_handle_group[0] # this fails if it finds nothing
			item_one_shot = false
		
		
		hand_point_handle_1 = get_node("./origin")
		
		
		align_points_1 = hand_point_handle_1.global_transform.origin
		if is_instance_valid(current_hand_item):  # checks if its valis because the maser script too has a function to remove the item. 
			zoom_point(current_hand_item, align_points_1)
		
			var quat_align = calc_angular_velocity(current_hand_item,hand_point_handle_1)
			
			current_hand_item.angular_velocity = quat_align
			
			# get me a list of all bodies in collission shape
			if destroy_item_bool:
				current_hand_item.queue_free()
				item_snapping = false

	else:
		collission_shape_handle = get_node("../../../Area3D")
		item_handle_group = collission_shape_handle.get_overlapping_bodies()
		
		collission_shape_handle_high = get_node("../../../upper_pickup_box")
		item_handle_group_high = collission_shape_handle_high.get_overlapping_bodies()
		current_hand_item = null
		#print("overlapping bodies top ", collission_shape_handle_high.has_overlapping_bodies())
		# 
	
	
	
		

	





func _on_node_3d_remove_hat(current_held_hat):
	destroy_item()
