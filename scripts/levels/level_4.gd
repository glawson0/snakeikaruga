extends BaseLevel

var goal = 20

func _ready():
	super._ready()
	level = 4
	board.init(goal, Globals.guide_15x15)
	await start
	board.start()
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/level_5.tscn"))

func populate_tanks():
	var offset = %Tank.get_y_offset()
	
	var top_row: Array = board.map[0].map((func(row):
		return map_row(row, offset, 1)
	))
	var top_lp = ListLocationProvider.new(top_row)
	%Tank.init(top_lp, Globals.Colors.GREEN)
	
	var bot_row: Array = board.map[board.map.size()-1].map(func(row):
		return map_row(row, offset, -1)
	)
	var bot_lp = ListLocationProvider.new(bot_row)
	%Tank4.init(bot_lp, Globals.Colors.RED)
	
	var left_col: Array = board.map.map(func(row):
		return map_col(0,row, offset, -1)
	)
	var left_lp = ListLocationProvider.new(left_col)
	%Tank2.init(left_lp, Globals.Colors.RED)
	
	var right_col: Array = board.map.map(func(row):
		return map_col(row.size() -1, row, offset, 1)
	)
	var right_lp = ListLocationProvider.new(right_col)
	%Tank3.init(right_lp, Globals.Colors.GREEN)
