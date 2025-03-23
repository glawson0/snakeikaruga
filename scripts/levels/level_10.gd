extends BaseLevel

var goal = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	level = 10
	board.init(goal, Globals.guide_20x20_boss, Vector2i(4,15))
	await start
	board.start()
	%Boss.init()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/victory.tscn"))
