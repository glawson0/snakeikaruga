extends Node2D

const inputActions = ["up", "down", "left", "right"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for direction in Globals.Direction:
		if Input.is_action_just_pressed(direction.to_lower()):
			%SnakeBoard.sm.direction = Globals.Direction.get(direction)
	
