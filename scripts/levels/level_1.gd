extends BaseLevel

var goal = 10

func _ready():
	super._ready()
	board.init(goal)

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/level_2.tscn"))
