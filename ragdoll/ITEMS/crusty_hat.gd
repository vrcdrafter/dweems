extends Node3D

var hat_name: String = "null"


func _on_node_3d_remove_hat(current_held_hat):
	if is_instance_valid(current_held_hat):
		print(current_held_hat.name)
		if current_held_hat.name == hat_name:
			self.visible = true

func _ready():
	hat_name = self.name
	print("hat_name", hat_name)
