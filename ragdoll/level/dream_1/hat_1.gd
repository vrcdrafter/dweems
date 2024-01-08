extends RigidBody3D





func _on_node_3d_remove_hat(current_held_hat):
	print(current_held_hat)
	if is_instance_valid(current_held_hat):
		current_held_hat.queue_free()
# 
