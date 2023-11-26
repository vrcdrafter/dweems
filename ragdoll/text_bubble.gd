extends Node3D

var assembled_text = " "
var arr_new = ["null", 2]
var arr_size

var bib_high = load("res://sounds/bib_hight.wav")
var bib_low = load("res://sounds/bib_low.wav")
@export var text = "null"
@export var text_box_theme:String = "res://textures/speech_bubble.png"
var cont = false

func _ready():
	
	# options to set up sprite 
	var text_1 = load(text_box_theme)
	
	$wrapper/Sprite3D.texture = text_1
	
	
	var tween = get_tree().create_tween()
	
	tween.tween_property($wrapper, "scale", Vector3(.7,.7,.7),1.5).set_trans(Tween.TRANS_ELASTIC)
	#tween.tween_callback($Sprite.queue_free)
	await get_tree().create_timer(1).timeout
	arr_new = make_array(text)
	
	
	
	var i = 0
	while i < arr_new.size():
		assembled_text = assembled_text + arr_new[i]
		$wrapper/Sprite3D/Label3D.text = assembled_text
		
		var num = randf()
		if num < .5:
			$AudioStreamPlayer.set_stream(bib_low)
		else:
			$AudioStreamPlayer.set_stream(bib_high)
		$AudioStreamPlayer.play()
		await get_tree().create_timer(.1).timeout
		i = i + 1
	
	# closer timer
	await get_tree().create_timer(1).timeout
	var tween_close = get_tree().create_tween()
	tween_close.tween_property($wrapper, "scale", Vector3(.1,.1,.1),1.5).set_trans(Tween.TRANS_ELASTIC)
	tween_close.connect("finished",on_tween_finished)
	
	
func make_array(my_string):
	var character_array = []
	for i in range(my_string.length()):
		character_array.append(my_string[i])
	return character_array


func _on_audio_stream_player_finished():
	cont = true
	
func on_tween_finished():
	self.queue_free()
	

