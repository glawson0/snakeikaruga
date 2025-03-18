extends Node2D
class_name BaseLevel

const inputActions = ["up", "down", "left", "right"]
var board:SnakeBoard

func _ready() -> void:
	board = %SnakeBoard
	board.game_won.connect(game_won)
	board.game_lost.connect(game_lost)
	AudioPlayer.play_level_music()

func _process(_delta: float) -> void:
	
	for direction in Globals.Direction:
		if Input.is_action_just_pressed(direction.to_lower()):
			%SnakeBoard.sm.direction = Globals.Direction.get(direction)
	
	if Input.is_action_just_pressed("color_swap"):
		%SnakeBoard.sm.swap_color()

func game_lost():
	get_tree().change_scene_to_packed(load("res://scenes/MainMenu.tscn"))
	
func game_won():
	pass
