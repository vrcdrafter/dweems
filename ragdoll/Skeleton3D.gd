extends Skeleton3D

var array = ["Spine.001","Spine.002","Spine003","Spine004"]
# Called when the node enters the scene tree for the first time.
func _ready():
	physical_bones_start_simulation(array)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
