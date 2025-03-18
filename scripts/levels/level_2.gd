extends BaseLevel

var goal = 10

func _ready():
	super._ready()
	board.init(goal)
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/level_3.tscn"))

func populate_tanks():
	var locations: Array = board.map[0].map(map_positions)
	var lp = ListLocationProvider.new(locations)
	%Tank.init(lp, Globals.Colors.GREEN)

func map_positions(tile) -> Vector2:
	var pos = to_local(tile.global_position)
	pos.y = pos.y - %Tank.get_y_offset()
	return pos
