extends Node3D

var animation_handle
var animation_track_handle

func _ready():
	animation_handle = get_node("../AnimationPlayer")
	
	animation_track_handle = animation_handle.get_animation("idle")
	
	
	animation_handle.play("idle")
