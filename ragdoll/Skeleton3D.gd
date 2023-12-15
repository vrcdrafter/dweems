extends Skeleton3D

var array = ["Spine001","Spine002","Spine003","Spine004"]

@export var pause_simulation = false
# Called when the node enters the scene tree for the first time.
func _ready():
	physical_bones_start_simulation(array)
	
	if pause_simulation:
		print("went there")
		physical_bones_stop_simulation()
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
