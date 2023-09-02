extends MeshInstance3D



var vertex_point = Vector3()
var mdt = MeshDataTool.new()

func _process(delta):
	var mesh_handle  = get_node(".")
	
	vertex_point = mesh_handle.global_transform.origin

	






