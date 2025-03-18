extends LocationProvider
class_name ListLocationProvider

var locations: Array

func _init(loc: Array) -> void:
	self.locations = loc
	
func get_location() -> Vector2:
	return locations[randi_range(0,locations.size()-1)]
