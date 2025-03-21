extends BaseLevel

var goal = 10

func _ready():
	super._ready()
	board.init(goal, Globals.guide_15x15)
	await start
	board.start()
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/level_3.tscn"))

func populate_tanks():
	var offset = %Tank.get_y_offset()
	var top_row: Array = board.map[0].map((func(row):
		return map_row(row, offset, 1)
	))
	var top_lp = ListLocationProvider.new(top_row)
	%Tank.init(top_lp, Globals.Colors.RED)
	
	var bot_row: Array = board.map[board.map.size()-1].map((func(row):
		return map_row(row, offset, -1)
	))
	var bot_lp = ListLocationProvider.new(bot_row)
	%Tank2.init(bot_lp, Globals.Colors.RED)
