extends BaseLevel

var goal = 20

func _ready():
	super._ready()
	board.init(goal, 15,15)
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/MainMenu.tscn"))

func populate_tanks():
	var top_row: Array = board.map[0].map((func(row):
		return map_row(row, 1)
	))
	var top_lp = ListLocationProvider.new(top_row)
	%Tank.init(top_lp, Globals.Colors.GREEN)
	
	var bot_row: Array = board.map[board.map.size()-1].map(func(row):
		return map_row(row, -1)
	)
	var bot_lp = ListLocationProvider.new(bot_row)
	%Tank4.init(bot_lp, Globals.Colors.RED)
	
	var left_col: Array = board.map.map(func(row):
		return map_col(0,row, -1)
	)
	var left_lp = ListLocationProvider.new(left_col)
	%Tank2.init(left_lp, Globals.Colors.RED)
	
	var right_col: Array = board.map.map(func(row):
		return map_col(board.map.size() -1, row, 1.5)
	)
	var right_lp = ListLocationProvider.new(right_col)
	%Tank3.init(right_lp, Globals.Colors.GREEN)

func map_row(tile, offset_scale) -> Vector2:
	var pos = to_local(tile.global_position)
	pos.y = pos.y - (%Tank.get_y_offset() * offset_scale)
	return pos
	
func map_col(col,row, offset_scale) -> Vector2:
	var pos = to_local(row[col].global_position)
	pos.x = pos.x + (%Tank.get_y_offset() * offset_scale)
	return pos
