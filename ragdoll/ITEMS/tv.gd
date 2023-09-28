extends Area3D

var open_signal
var pciture_handle
var player_handle
var light_handle
var viscinity = 0
var flip_flop_status = 1
var watchdog = 0 # watchdog is important for randome door_can_open_now becomming true

func _on_area_entered(area):
	print("some area entered")
	if area.is_in_group("player"):
		
		viscinity = 1

var door_can_open_now = false 

func _ready():
	player_handle = get_node("../../untitled/untitled/Armature (Mecha g)")
	#print("player  Handle ",player_handle)
	#player_handle.connect("open_interact",self.open_door,1)
	player_handle.open_interact.connect(open_door.bind())
func _process(delta):
	light_handle = get_node("../SpotLight3D")
	pciture_handle = get_node("../AnimatedSprite3D")
	if viscinity == 1:
		
		if door_can_open_now and flip_flop_status == 1 and watchdog == 1:
			
			await get_tree().create_timer(1.0).timeout
			light_handle.hide()
			pciture_handle.hide()
			flip_flop_status = 2
			door_can_open_now = false
		if door_can_open_now and flip_flop_status == 2 and watchdog == 1:
			
			await get_tree().create_timer(1.0).timeout
			light_handle.show()
			pciture_handle.show()
			flip_flop_status = 1
	watchdog = 0
func open_door():
	print("manual connection called")
	door_can_open_now = true
	watchdog = 1

func _on_area_exited(area):
	print(" some area entered")
	if area.is_in_group("player"):
		door_can_open_now = false
		viscinity = 0
