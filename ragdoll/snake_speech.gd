extends Area3D

@export var text_new:Array = ["nil"]
@export var target_node = ".."  # just do a path as a string
@export var theme = "res://textures/speech_bubble_snake.png"
@export var run_dialogue = true
@onready var scene = preload("res://animations/text_bubble.tscn")
@onready var player = get_node("/root/Node3D/untitled")
@onready var player_handle
var text_next = 0
signal dialogue_done
var start_dialoge = false
var dialogue_counter = 0
signal dont_move_chat
signal resume_move

@export var resume_move_snake = false

var id
var max_dialogue = 0

func _ready():
	
	$Node2D/Label.hide()
	player_handle = get_node("/root/Node3D/untitled/untitled/Armature (Mecha g)")
	print("player handle ", player_handle)
	player_handle.open_interact.connect(begin_dialogue.bind())
	

func _process(delta):
	max_dialogue = text_new.size()
	if is_instance_valid(get_node("/root/Node3D/untitled")):
		player = get_node("/root/Node3D/untitled")
		player_handle = get_node("/root/Node3D/untitled/untitled/Armature (Mecha g)")
		if not player_handle.open_interact.is_connected(begin_dialogue):
			player_handle.open_interact.connect(begin_dialogue.bind())

	resume_move_snake = false
	
	if run_dialogue:
		if text_next == 1:
			dialogue_counter += 1
			text_next = 0 
		
		if is_instance_valid(player):
			if not self.overlaps_body(player):
				text_next = 0
				$Node2D/Label.hide()
				dialogue_counter = 0
		if is_instance_valid(player):
			if self.overlaps_body(player):
				
				$Node2D/Label.show()
				# get lenght of text 
				

				if start_dialoge:
					emit_signal("dont_move_chat")
					var new_dialogue = scene.instantiate()
					new_dialogue.text_box_theme = theme
					
					
					if not id == null:
						if is_instance_id_valid(id):
							print("found by ID")
							
							instance_from_id(id).queue_free()
							
						# sets the text
					if not (dialogue_counter -1) > (text_new.size()-1):
						print("current dialogue counter ",dialogue_counter-1)
						new_dialogue.text = text_new[dialogue_counter-1]
			
						
						
						# done setting text
					if not dialogue_counter > max_dialogue:
						get_node(target_node).add_child(new_dialogue)
						id = new_dialogue.get_instance_id()
						resume_move_snake = false
					else:
						emit_signal("resume_move")
						
						resume_move_snake = true
						print("resume move snake", resume_move_snake)
					#await get_tree().create_timer(.01).timeout #100 ms time 
					
					start_dialoge = false
		
		

func begin_dialogue():
	
	text_next += 1
	print("begin dialogue function called")
	start_dialoge = true
	await get_tree().create_timer(1).timeout #100 ms time 
	emit_signal("dialogue_done")
