extends AudioStreamPlayer

var armature_handle

var walking_status


func _process(delta):
	
	
	
	armature_handle = get_node("../untitled/Armature (Mecha g)")
	
	walking_status = armature_handle.walking_sound
	
	
	if not walking_status:
		self.play()
	
	
	
	
