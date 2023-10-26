extends Node3D

var assembled_text = " "
var arr_new = ["null", 2]
var arr_size

var bib_high = load("res://sounds/bib_hight.wav")
var bib_low = load("res://sounds/bib_low.wav")
@export var text = "null"

var cont = false

func _ready():
	
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
		
	
	
	
func make_array(my_string):
	var character_array = []
	for i in range(my_string.length()):
		character_array.append(my_string[i])
	return character_array


func _on_audio_stream_player_finished():
	cont = true
