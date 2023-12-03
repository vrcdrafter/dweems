extends Area3D

@export var text_new = "This is just a dialoge test"
@export var target_node = ".."  # just do a path as a string
@export var theme = "res://textures/speech_bubble_snake.png"
@onready var scene = preload("res://animations/text_bubble.tscn")
@onready var player = get_node("/root/Node3D/untitled")
@onready var player_handle
var text_next = 0
signal dialogue_done
var dialogue_counter = 0
var start_dialoge = false
signal dont_move_chat
signal resume_move

var id
var max_dialogue = 3

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
		dialogue_counter = 0

	if self.overlaps_body(player):
		
		$Node2D/Label.show()
		
		#print(" back in area ")
		#self.quedue_free()
		#print("text next  ",text_next)
		if start_dialoge:
			emit_signal("dont_move_chat")
			var new_dialogue = scene.instantiate()
			new_dialogue.text_box_theme = theme
			
			
			if not id == null:
				if is_instance_id_valid(id):
					print("found by ID")
					
					instance_from_id(id).queue_free()
					
				
			
			if dialogue_counter == 1:
				new_dialogue.text = "text #1 "
			
			elif  dialogue_counter == 2:
				new_dialogue.text = "text # 2"
			
			else:
				
				new_dialogue.text = "text # 3"
			if not dialogue_counter > max_dialogue:
				get_node(target_node).add_child(new_dialogue)
				id = new_dialogue.get_instance_id()
			else:
				emit_signal("resume_move")
			#await get_tree().create_timer(.01).timeout #100 ms time 
			
			start_dialoge = false
		
		

func begin_dialogue():
	
	text_next += 1
	print("bring me some dialogue ", text_next)
	start_dialoge = true
	await get_tree().create_timer(1).timeout #100 ms time 
	emit_signal("dialogue_done")
