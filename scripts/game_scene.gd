extends BaseLevel

var goal = 10

func _ready():
	board = %SnakeBoard
	board.init(goal, Globals.guide_15x15)
	board.game_won.connect(game_won)
	populate_tanks()

func _process(delta: float) -> void:
	super._process(delta)

func game_won():
	get_tree().change_scene_to_packed(load("res://scenes/MainMenu.tscn"))

func populate_tanks():
	var locations: Array = board.map[0].map(map_positions)
	var lp = ListLocationProvider.new(locations)
	%Tank.init(lp, Globals.Colors.GREEN)

func map_positions(tile) -> Vector2:
	var pos = to_local(tile.global_position)
	pos.y = pos.y - %Tank.get_y_offset()
	return pos
