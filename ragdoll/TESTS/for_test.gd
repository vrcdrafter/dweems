extends Node3D



func _ready():
	var array_to_manage = [1, 2, 3, "empty"]
	var item = "test"
	var iterator = 0
	for x in array_to_manage:
		print(iterator)
	
		if x is String:
			print("found a string")
			if x == "empty":
				print("found a emtpy")
				array_to_manage[iterator] = item# thing will become the incoming object
				print(x)
		iterator += 1
	print(array_to_manage)
	# add anoher empty to the array 
	
	# make another routine where you remove the item right out of the array
