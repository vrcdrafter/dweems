extends Area3D

@export var text_new = "This is just a dialoge test"
@export var target_node = "../text_cyld"  # just do a path as a string
@export var theme = "res://textures/speech_bubble_snake.png"
@onready var scene = preload("res://animations/text_bubble.tscn")

@onready var player_handle = get_node("/root/Node3D/untitled/untitled/Armature (Mecha g)")
var text_next = 0
var oneshot = false
var oneshot_2 = false
var counter = 0
func _ready():
	
	oneshot = true
	oneshot_2= true

	
	print("player handle ", player_handle)
	
	#print("player  Handle ",player_handle)
	#player_handle.connect("open_interact",self.open_door,1)
	player_handle.open_interact.connect(begin_dialogue.bind())
	

func _on_body_entered(body):
	#print(" in the body ")
	#self.queue_free()
	print("text next  ",text_next)
	if text_next == 1:
		var new_dialogue = scene.instantiate()
		new_dialogue.text_box_theme = theme
		new_dialogue.text = text_new
		
		get_node(target_node).add_child(new_dialogue)
		
		
		
		
	if text_next == 2:
		var new_dialogue = scene.instantiate()
		new_dialogue.text_box_theme = theme
		new_dialogue.text = "ha here is the next text"
		
		get_node(target_node).add_child(new_dialogue) 
		
		
	text_next = 0
	
	oneshot = true
	
	if counter == 2:
		counter = 0
	

func begin_dialogue():
	
	if oneshot:
		
		counter += 1
		text_next = counter
		print("bring me some dialogue", counter)
		oneshot = false
		
