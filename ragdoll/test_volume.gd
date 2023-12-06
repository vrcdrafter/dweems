extends Area3D

var text_new = "probably should \n turn off the TV"
var target_node = "../untitled"  # just do a path as a string
var oneshot = true


func _ready():
	oneshot = true


func _on_body_entered(body):
	if oneshot:
		gimme_speech_bub(text_new) # run once plese 
		oneshot = false
	
	

func gimme_speech_bub(text_to_say):
	var scene = preload("res://animations/text_bubble.tscn")
	
	var new_dialogue = scene.instantiate() #creates a new node
	new_dialogue.text = text_to_say
	
	get_node(target_node).add_child(new_dialogue) 
	
	var id = new_dialogue.get_instance_id()
	
	await get_tree().create_timer(7).timeout
	print(" remove area")
	instance_from_id(id).queue_free()
