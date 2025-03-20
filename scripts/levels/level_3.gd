extends BaseLevel

var goal = 15

func _ready():
	super._ready()
	board.init(goal)
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/level_4.tscn"))

func populate_tanks():
	var top_row: Array = board.map[0].map(map_row)
	var top_lp = ListLocationProvider.new(top_row)
	%Tank.init(top_lp, Globals.Colors.GREEN)
	
	var col: Array = board.map.map(map_col)
	var col_lp = ListLocationProvider.new(col)
	%Tank2.init(col_lp, Globals.Colors.RED)

func map_row(tile) -> Vector2:
	var pos = to_local(tile.global_position)
	pos.y = pos.y - %Tank.get_y_offset()
	return pos
	
func map_col(row) -> Vector2:
	var pos = to_local(row[0].global_position)
	pos.x = pos.x - %Tank.get_y_offset()
	return pos
