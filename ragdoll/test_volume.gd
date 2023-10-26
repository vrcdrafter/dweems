extends Area3D

var text_new = "probably should \n turn off the TV"


func _on_body_entered(body):
	gimme_speech_bub(text_new)
	
	self.queue_free()

func gimme_speech_bub(text_to_say):
	var scene = preload("res://animations/text_bubble.tscn")
	
	var newCrop = scene.instantiate() #creates a new node
	newCrop.text = text_to_say
	
	get_node("../untitled/untitled/Armature (Mecha g)").add_child(newCrop) 
