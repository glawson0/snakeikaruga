extends BaseLevel

const inputActions = ["up", "down", "left", "right"]

var board:SnakeBoard
var goal = 10

func _ready():
	board = %SnakeBoard
	board.init(goal)
	board.game_won.connect(game_won)

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/MainMenu.tscn"))
