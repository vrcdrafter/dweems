extends Node3D

@onready var player = $untitled
@onready var line = $Path3D
@onready var Snake_skeleton = get_node("steve2/Armature/Skeleton3D")
@onready var path_handle_1 = get_node("Path3D/" + "PathFollow3D")
@onready var path_handle_2 = get_node("Path3D/" + "PathFollow3D2")
@onready var path_handle_3 = get_node("Path3D/" + "PathFollow3D3")
@onready var path_handle_4 = get_node("Path3D/" + "PathFollow3D4")
@onready var path_handle_5 = get_node("Path3D/" + "PathFollow3D5")
@onready var path_handle_6 = get_node("Path3D/" + "PathFollow3D6")
@onready var path_handle_7 = get_node("Path3D/" + "PathFollow3D7")
@onready var path_handle_8 = get_node("Path3D/" + "PathFollow3D8")
@onready var path_handle_9 = get_node("Path3D/" + "PathFollow3D9")
@onready var path_handle_10 = get_node("Path3D/" + "PathFollow3D10")
@onready var path_handle_11 = get_node("Path3D/" + "PathFollow3D11")
@onready var path_handle_12 = get_node("Path3D/" + "PathFollow3D12")
@onready var path_handle_13 = get_node("Path3D/" + "PathFollow3D13")
@onready var path_handle_14 = get_node("Path3D/" + "PathFollow3D14")
@onready var path_handle_15 = get_node("Path3D/" + "PathFollow3D15")
@onready var path_handle_16 = get_node("Path3D/" + "PathFollow3D16")
@onready var path_handle_17 = get_node("Path3D/" + "PathFollow3D17")
@onready var path_handle_18 = get_node("Path3D/" + "PathFollow3D18")

@onready var path1 = $Path3D/PathFollow3D
var bone_speed = 3.0
var length = 0.0
@onready var heading_handle =$steve  # note steve needs to be close to the player immediatly . and have no clipping ------- >>>>>> ERROR OR IMPROVEMENT

var pos_1 
var pos_2
var pos_3
var summation_distance = 0.0
var point_incrementer = 0
var catch_up = 0
var catchup_needed = false
var governer = 1
var one_shot = false 

var train_delay = false

# path_list
var follow_path_name = "path_1"
var follow_path_name_2 = "path_2"


# matrix transformation for ensnarment 
var translation = Vector3(0,0,0)
var spin  = Vector3(0,0,0)
var Rx = Basis(Vector3(1, 0, 0), Vector3(0, cos(10), sin(10)), Vector3(0, -sin(10), cos(10)))
var Ry = Basis(Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1))
var Rz = Basis(Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1))
var new_point_rot 
var player_rotation_angle
# test triangle , can delete 
#var triangle = MeshInstance3D.new()

# ensnarement curve data 
var curve_array_point = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var curve_array_in = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var curve_array_out = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var ensnared = false

func _ready():
	var Snake_skeleton = get_node("steve2")
	one_shot = true 
	ensnared = false
	# create material 
	var missing_model_material := StandardMaterial3D.new()
	missing_model_material.flags_unshaded = true
	missing_model_material.albedo_color = Color(255, 0, 255)
	
	
	path_handle_1.progress = 2.0
	path_handle_2.progress = 2.5
	path_handle_3.progress = 3.0
	path_handle_4.progress = 3.5
	path_handle_5.progress = 4.0
	path_handle_6.progress = 4.5
	path_handle_7.progress = 5.0
	path_handle_8.progress = 5.6
	path_handle_9.progress = 6.5
	path_handle_10.progress = 7.0
	path_handle_11.progress = 7.5
	path_handle_12.progress = 8.0
	path_handle_13.progress = 8.5
	path_handle_14.progress = 9.0
	path_handle_15.progress = 9.5
	path_handle_16.progress = 10
	path_handle_17.progress = 10.5
	path_handle_18.progress = 11
	
	
	# give me a test triangle , you can delete 

	
	# get all ensnarement curve data 




func _physics_process(delta): 
	
	get_tree().call_group("enemies","update_target_location",player.global_transform.origin)
	

	# get inial point count 
	var num_of_points = line.curve.point_count

	# get new heading 
	
	# get fist position 
	pos_1 = heading_handle.global_position
	await get_tree().create_timer(.01).timeout #100 ms time 
	pos_2 = heading_handle.global_position
	await get_tree().create_timer(.01).timeout #100 ms time 
	pos_3 = heading_handle.global_position
	
	
	summation_distance += abs(pos_2.length() - pos_1.length())
	
	#print("total traveled distnace", summation_distance)
	
	if summation_distance > .1 and not ensnared:
		# need to add a new path3d and PathFollow 3d 
		line.curve.add_point(pos_2,(pos_2-pos_3)*2,(pos_1-pos_2)*2,num_of_points + 1) # successfully adds a point

		summation_distance = 0 
		#print("curve length ", length, "number of points ", line.curve.get_baked_points()) 
		

	

	
	# test for all other points 
	for x in range(0, curve_array_point.size()):
		curve_array_point[x] = $untitled/Path3D.curve.get_point_position(x)
	for x in range(0, curve_array_in.size()):
		curve_array_in[x] = $untitled/Path3D.curve.get_point_in(x)
	for x in range(0, curve_array_out.size()):
		curve_array_out[x] = $untitled/Path3D.curve.get_point_out(x)
	#print("array of points in curve ", curve_array_point)
	
	
	# rotate players Path3 to face snake  
	$untitled/Path3D.look_at($Path3D/PathFollow3D18/MeshInstance3D.global_position,Vector3(0,1,0)) # need to get the real position of the cube , 
	
	
	# stop routing
	if path_handle_18.get_progress() > line.curve.get_baked_length():
		print("stop please")
		path_handle_1.progress += 0
		path_handle_2.progress += 0
		path_handle_3.progress += 0
		path_handle_4.progress += 0
		path_handle_5.progress += 0
		path_handle_6.progress += 0
		path_handle_7.progress += 0
		path_handle_8.progress += 0
		path_handle_9.progress += 0
		path_handle_10.progress += 0
		path_handle_11.progress += 0
		path_handle_12.progress += 0
		path_handle_13.progress += 0
		path_handle_14.progress += 0
		path_handle_15.progress += 0
		path_handle_16.progress += 0
		path_handle_17.progress += 0
		path_handle_18.progress += 0
		
		# then populate new points coming from players curve 
		var i = 0
		while (i < 16) and not ensnared:
			var num_of_points_at_moment = line.curve.point_count
			var curve_point_pos = move_point(curve_array_point[i],$untitled/Path3D)
			var curve_point_in = move_point(curve_array_point[i],$untitled/Path3D)
			var curve_point_out = move_point(curve_array_point[i],$untitled/Path3D)
			line.curve.add_point(curve_point_pos,Vector3(0,0,0),Vector3(0,0,0),num_of_points_at_moment + 1)
			print("new first point",curve_point_pos)
			i += 1
			
		ensnared = true
			
	else:
		path_handle_1.progress += 3 * delta
		path_handle_2.progress += 3 * delta
		path_handle_3.progress += 3 * delta
		path_handle_4.progress += 3 * delta
		path_handle_5.progress += 3 * delta
		path_handle_6.progress += 3 * delta
		path_handle_7.progress += 3 * delta
		path_handle_8.progress += 3 * delta
		path_handle_9.progress += 3 * delta
		path_handle_10.progress += 3 * delta
		path_handle_11.progress += 3 * delta
		path_handle_12.progress += 3 * delta
		path_handle_13.progress += 3 * delta
		path_handle_14.progress += 3 * delta
		path_handle_15.progress += 3 * delta
		path_handle_16.progress += 3 * delta
		path_handle_17.progress += 3 * delta
		path_handle_18.progress += 3 * delta

# get the head to snake to handle 1 

	#Snake_skeleton.set_bone_pose_position(0,$Path3D/PathFollow3D7/MeshInstance3D.get_global_position()) # almost works
	#Snake_skeleton.set_bone_pose_position(1,$Path3D/PathFollow3D6/MeshInstance3D.get_global_position())
	#print("first bone position ", Snake_skeleton.get_bone_global_pose_override(0))
	#print("first bone position ", $Path3D/PathFollow3D18/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(0,$Path3D/PathFollow3D18/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(0,$Path3D/PathFollow3D18/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(1,$Path3D/PathFollow3D17/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(1,$Path3D/PathFollow3D17/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(2,$Path3D/PathFollow3D16/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(2,$Path3D/PathFollow3D16/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(3,$Path3D/PathFollow3D15/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(3,$Path3D/PathFollow3D15/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(4,$Path3D/PathFollow3D14/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(4,$Path3D/PathFollow3D14/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(5,$Path3D/PathFollow3D13/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(5,$Path3D/PathFollow3D13/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(6,$Path3D/PathFollow3D12/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(6,$Path3D/PathFollow3D12/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(7,$Path3D/PathFollow3D11/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(7,$Path3D/PathFollow3D11/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(8,$Path3D/PathFollow3D10/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(8,$Path3D/PathFollow3D10/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(9,$Path3D/PathFollow3D9/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(9,$Path3D/PathFollow3D9/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(10,$Path3D/PathFollow3D8/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(10,$Path3D/PathFollow3D8/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(11,$Path3D/PathFollow3D7/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(11,$Path3D/PathFollow3D7/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(12,$Path3D/PathFollow3D6/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(12,$Path3D/PathFollow3D6/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(13,$Path3D/PathFollow3D5/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(13,$Path3D/PathFollow3D5/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(14,$Path3D/PathFollow3D4/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(14,$Path3D/PathFollow3D4/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(15,$Path3D/PathFollow3D3/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(15,$Path3D/PathFollow3D3/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(16,$Path3D/PathFollow3D2/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(16,$Path3D/PathFollow3D2/MeshInstance3D.global_transform.basis.get_rotation_quaternion())
	Snake_skeleton.set_bone_global_pose_override(17,$Path3D/PathFollow3D/MeshInstance3D.get_global_transform(),1,true)
	Snake_skeleton.set_bone_pose_rotation(17,$Path3D/PathFollow3D/MeshInstance3D.global_transform.basis.get_rotation_quaternion())



func move_triangle(follow_path_name,real_time,offset):


	var path_handle = get_node("Path3D/" + follow_path_name)

	if one_shot:
		path_handle.progress = offset
		one_shot = false
	path_handle.progress += 3 * real_time
		# 

func move_point(point:Vector3,object:Node3D):

	#print("progress ",path_handle_18.get_progress(), " total len", line.curve.get_baked_length())
	var translation = object.global_position
	var player_rotation_angle = object.get_global_rotation()
	# updte rotation matricies
	var Rx = Basis(Vector3(1, 0, 0), Vector3(0, cos(player_rotation_angle.x), sin(player_rotation_angle.x)), Vector3(0, -sin(player_rotation_angle.x), cos(player_rotation_angle.x)))
	var Ry = Basis(Vector3(cos(player_rotation_angle.y), 0, -sin(player_rotation_angle.y)), Vector3(0, 1, 0), Vector3(sin(player_rotation_angle.y), 0, cos(player_rotation_angle.y)))
	var Rz = Basis(Vector3(cos(player_rotation_angle.z), sin(player_rotation_angle.z), 0), Vector3(-sin(player_rotation_angle.z), cos(player_rotation_angle.z), 0), Vector3(0, 0, 1))
	#print(player_rotation_angle)
	#print("first position on player , should change , ",$untitled/Path3D.curve.get_point_position(0) + translation)
	
	new_point_rot = Ry * point
	#print($untitled.basis)
	#print("rotatin Rx on array point  0 ", new_point_rot)
	new_point_rot = new_point_rot + translation
	#print("final rotation ", new_point_rot)
	
	
	return new_point_rot
