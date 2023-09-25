extends Area3D

var open_signal

var player_handle
var animation_handle
var viscinity = 0
var flip_flop_status = 1
var watchdog = 0 # watchdog is important for randome door_can_open_now becomming true

func _on_area_entered(area):
	
	if area.is_in_group("player"):
		
		viscinity = 1

var door_can_open_now = false 

func _ready():
	player_handle = get_node("../../untitled/untitled/Armature (Mecha g)")
	#print("player  Handle ",player_handle)
	#player_handle.connect("open_interact",self.open_door,1)
	player_handle.open_interact.connect(open_door.bind())
func _process(delta):
	animation_handle = get_node("../fridge_animated/AnimationPlayer")
	
	if viscinity == 1:
		print("open door now",door_can_open_now,watchdog)
		if door_can_open_now and flip_flop_status == 1 and watchdog == 1:
			
			animation_handle.play("House Props  Fridge001Action")
		
		if door_can_open_now and flip_flop_status == 2 and watchdog == 1:
			animation_handle.play_backwards("House Props  Fridge001Action")
	watchdog = 0
func open_door():
	print("manual connection called")
	door_can_open_now = true
	watchdog = 1
	
func _on_animation_player_animation_finished(anim_name):
	door_can_open_now = false
	if flip_flop_status == 1:
		flip_flop_status = 2
	else:
		flip_flop_status = 1

func _on_area_exited(area):
	if area.is_in_group("player"):
		door_can_open_now = false
		viscinity = 0
