extends Area3D

@export var text_new = "This is just a dialoge test"
@export var target_node = "../text_cyld"  # just do a path as a string
@export var theme = "res://textures/speech_bubble_snake.png"
@onready var scene = preload("res://animations/text_bubble.tscn")
@onready var new_dialogue = scene.instantiate()
var player_handle
func _ready():
	
	new_dialogue.text_box_theme = theme
	new_dialogue.text = text_new
	
	player_handle = get_node("../untitled/untitled/Armature (Mecha g)")
	#print("player  Handle ",player_handle)
	#player_handle.connect("open_interact",self.open_door,1)
	player_handle.open_interact.connect(begin_dialogue.bind())
	

func _on_body_entered(body):
	#print(" in the body ")
	#self.queue_free()
	get_node(target_node).add_child(new_dialogue) 


func begin_dialogue():
	print("bring me some dialogue")
