extends AudioStreamPlayer

var armature_handle

var walking_status

@onready var stream1 = preload("res://sounds/walking.wav")
@onready var stream2 = preload("res://sounds/walking_forest.wav")

func _ready():
	if has_node("/root/Node3D/steve"):
		
		print(" play the forest walk")
		self.set_stream(stream2)
	else:
		self.set_stream(stream1)

func _process(delta):
	
	
	
	armature_handle = get_node("../untitled/Armature (Mecha g)")
	
	walking_status = armature_handle.walking_sound
	


	
	if not walking_status:
		self.play()
	
	
	
	
