extends BaseLevel

var goal = 20

func _ready():
	super._ready()
	level = 6
	board.init(goal, Globals.guide_16x20_V)
	await start
	board.start()
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/level_7.tscn"))

func populate_tanks():
	%PivotTank.init(Globals.Colors.GREEN)
	%PivotTank2.init(Globals.Colors.RED)
	%PivotTank3.init(Globals.Colors.RED)
	%PivotTank4.init(Globals.Colors.RED)
	%PivotTank5.init(Globals.Colors.GREEN)
	%PivotTank6.init(Globals.Colors.GREEN)
