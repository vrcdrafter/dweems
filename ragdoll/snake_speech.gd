extends Area3D

@export var text_new = "This is just a dialoge test"
@export var target_node = "../text_cyld"  # just do a path as a string
@export var theme = "res://textures/speech_bubble_snake.png"
@onready var scene = preload("res://animations/text_bubble.tscn")
@onready var player = get_node("/root/Node3D/untitled")
@onready var player_handle
var text_next = 0
signal dialogue_done

func _ready():
	
	
	player_handle = get_node("/root/Node3D/untitled/untitled/Armature (Mecha g)")
	print("player handle ", player_handle)
	player_handle.open_interact.connect(begin_dialogue.bind())

func _process(delta):
	if not self.overlaps_body(player):
		text_next = 0

	if self.overlaps_body(player):
		#print(" back in area ")
		#self.quedue_free()
		#print("text next  ",text_next)
		if text_next == 1:
			text_next = 0
			var new_dialogue = scene.instantiate()
			new_dialogue.text_box_theme = theme
			new_dialogue.text = text_new
			
			get_node(target_node).add_child(new_dialogue)
			#await get_tree().create_timer(.01).timeout #100 ms time 
			
			
			
		if text_next == 2:
			text_next = 0
			var new_dialogue = scene.instantiate()
			new_dialogue.text_box_theme = theme
			new_dialogue.text = "ha here is the next text"
			
			get_node(target_node).add_child(new_dialogue) 
			#await get_tree().create_timer(.1).timeout #100 ms time 
			
			


func begin_dialogue():
	
	text_next += 1
	print("bring me some dialogue ", text_next)
	await get_tree().create_timer(.1).timeout #100 ms time 
	emit_signal("dialogue_done")
