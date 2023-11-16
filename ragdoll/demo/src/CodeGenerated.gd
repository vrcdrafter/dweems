extends Node


func _ready():
	$UI.player = $Player
		
	if has_node("RunThisSceneLabel3D"):
		$RunThisSceneLabel3D.queue_free()
	
	if has_node("Player"):
		$Player.gravity_enabled = false

	# Create a terrain
	var terrain := Terrain3D.new()
	terrain.set_collision_enabled(false)
	terrain.storage = Terrain3DStorage.new()
	terrain.name = "Terrain3D"
	add_child(terrain, true)
	terrain.storage.noise_enabled = true
	
	# Create blank regions
	terrain.storage.add_region(Vector3(0, 0, 0))
	terrain.storage.add_region(Vector3(1024, 0, 1024))
	terrain.storage.add_region(Vector3(1024, 0, -1024))
	terrain.storage.add_region(Vector3(-2048, 0, -2048))
	
	# Generate 8-bit noise (looks terrible) and import it with scale
	var noise := FastNoiseLite.new()
	noise.frequency = 0.001
	var img: Image = noise.get_image(1024, 3072)
	terrain.storage.import_images([img, null, null], Vector3(2048, 0, -1024), 0.0, 300.0)

	# Enable collision. Enable the first if you wish to see it with Debug/Visible Collision Shapes
#	terrain.set_show_debug_collision(true)
	terrain.set_collision_enabled(true)
	
	# Retreive 512x512 region blur map showing where the regions are
	var rbmap_rid: RID = terrain.storage.get_region_blend_map()
	img = RenderingServer.texture_2d_get(rbmap_rid)
	$UI/TextureRect.texture = ImageTexture.create_from_image(img)

		

