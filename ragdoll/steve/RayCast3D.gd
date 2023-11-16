extends RayCast3D



var distance = Vector3()
var angle_time = 0.0
var array = [100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0 ,0 ,0]
var axis = Vector3(1, 0, 0) # Or Vector3.RIGHT
var rotation_amount = 0.1

func _process(delta):
	
	
	self.basis = transform.basis.rotated(axis, .01)
	#var query = PhysicsRayQueryParameters3D.create(Vector3(0,0,0),Vector3(0,1,1))
	

	#print("distance is ", distance)
# Rotate the transform around the X axis by 0.1 radians.
	var test = self.get_rotation_degrees()
	test = roundi(test.x)
# shortened
	
	
	match test:
		10:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[1] = distance
		20:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[2] = distance
		30:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[3] = distance
		40:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[4] = distance
		50:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[5] = distance
		60:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[6] = distance
		70:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[7] = distance
		80:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[8] = distance
		90:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[9] = distance
		100:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[10] = distance
		110:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[11] = distance
		120:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[12] = distance
		130:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[13] = distance
		140:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[14] = distance
		150:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[15] = distance
		160:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[16] = distance
		170:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[17] = distance
		180:
			
			distance = self.transform.origin - self.get_collision_point()
			distance = distance.length()
			array[18] = distance
	
	if test == 1:
		
		var smallest = array[0]
		var index 
		for i in range(1, array.size()):
			if array[i] < smallest:
				smallest = array[i]
				index = i
		#print("distance ", smallest, "at angle", index)
		#print(array)

	

