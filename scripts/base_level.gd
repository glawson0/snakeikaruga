extends Node2D
class_name BaseLevel

func _process(delta: float) -> void:
	
	for direction in Globals.Direction:
		if Input.is_action_just_pressed(direction.to_lower()):
			%SnakeBoard.sm.direction = Globals.Direction.get(direction)
	
	if Input.is_action_just_pressed("color_swap"):
		%SnakeBoard.sm.swap_color()
