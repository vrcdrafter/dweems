extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var animaitonPlayer: AnimationPlayer = $AnimationPlayer
@onready var progressbar: ProgressBar = $Panel/ProgressBar
@onready var load_manager_handle
var progresss

func _update_progress_bar(new_value: float) -> void:
	print("new value ", new_value)
	progressbar.value += new_value * 100
	if new_value == 1:
		self.queue_free()
	
func start_outro_animation() -> void:
	await Signal(animaitonPlayer, "animation_finished")
	animaitonPlayer.play("end_load")
	print(" trying to close load")
	await Signal(animaitonPlayer, "animation_finished")
	self.queue_free()


func _ready():
	
	$Panel.size = Vector2(1152,648) # force the size dammit
