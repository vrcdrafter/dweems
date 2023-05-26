extends SpringArm3D

@export var mouse_sensativity := .05
@export var camera_rotation := 0
func _ready() -> void:
	set_as_top_level(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sensativity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		rotation_degrees.y -= event.relative.x * mouse_sensativity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
		#print(rotation_degrees.y)
		camera_rotation = rotation_degrees.y
