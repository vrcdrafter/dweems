extends Area3D

@export var text_new = "This is just a dialoge test"
@export var target_node = "../text_cyld"  # just do a path as a string
@export var theme = "res://textures/speech_bubble_snake.png"
@onready var scene = preload("res://animations/text_bubble.tscn")
@onready var player = get_node("/root/Node3D/untitled")
@onready var player_handle
var text_next = 0
signal dialogue_done
var dialogue_counter = 0
var start_dialoge = false

func _ready():
	
	$Node2D/Label.hide()
	player_handle = get_node("/root/Node3D/untitled/untitled/Armature (Mecha g)")
	print("player handle ", player_handle)
	player_handle.open_interact.connect(begin_dialogue.bind())

func _process(delta):
	
	if text_next == 1:
		dialogue_counter += 1
		text_next = 0 
	
	
	if not self.overlaps_body(player):
		text_next = 0
		$Node2D/Label.hide()

	if self.overlaps_body(player):
		$Node2D/Label.show()
		#print(" back in area ")
		#self.quedue_free()
		#print("text next  ",text_next)
		if start_dialoge:
			
			var new_dialogue = scene.instantiate()
			new_dialogue.text_box_theme = theme
			if dialogue_counter == 1:
				new_dialogue.text = "text #1 "
			
			if dialogue_counter == 2:
				new_dialogue.text = "text # 2"
			
			get_node(target_node).add_child(new_dialogue)
			#await get_tree().create_timer(.01).timeout #100 ms time 
			start_dialoge = false
			
			
			


func begin_dialogue():
	
	text_next += 1
	print("bring me some dialogue ", text_next)
	start_dialoge = true
	await get_tree().create_timer(.3).timeout #100 ms time 
	emit_signal("dialogue_done")
