extends Area3D

@export var what_is_found:Node3D

func _on_body_entered(body):
	what_is_found = body
