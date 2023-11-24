extends Area3D

var text_new = "Hello welcome to your dream \n will you help me find \n my HATS"
var target_node = "../Path3D/PathFollow3D18"  # just do a path as a string

func _on_body_entered(body):
	gimme_speech_bub(text_new)
	print(" in the body ")
	self.queue_free()

func gimme_speech_bub(text_to_say):
	var scene = preload("res://animations/text_bubble.tscn")
	
	var new_dialogue = scene.instantiate() #creates a new node
	new_dialogue.text = text_to_say
	
	get_node(target_node).add_child(new_dialogue) 
