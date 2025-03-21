extends Node2D

class_name SnakeManager

const FLASH_INTERVAL = .2
var hurt_sfx = preload("res://resources/sfx/Balloon start riding 2.wav")

@export var FLASH_COLOR: Color

var tiles: Array[BoardTile] = []
var invincible = false
var direction:= Globals.Direction.RIGHT
var flashing_timer: float
var is_flashing = false
var active_color: Color
var selected_color: Globals.Colors
var primary_color: Globals.Colors
var secondary_color: Globals.Colors
var is_primary_selected= true

func init() -> void:
	primary_color = Globals.Colors.GREEN
	%PrimaryIndicator.set_color(Globals.COLOR_MAP[primary_color])
	%PrimaryIndicator.set_selected(true)
	secondary_color = Globals.Colors.RED
	%SecondaryIndicator.set_color(Globals.COLOR_MAP[secondary_color])
	selected_color = primary_color
	active_color = Globals.COLOR_MAP[selected_color]

func _process(delta: float) -> void:
	if(invincible):
		flashing_timer += delta
		if(flashing_timer > FLASH_INTERVAL):
			flashing_timer = 0
			set_flash_state(!is_flashing)
			color_board_tiles()

func do_damage() -> bool:
	if invincible:
		return false
	enter_damaged_state()
	remove_tail()
	return true

func enter_damaged_state():
	invincible = true
	flashing_timer = 0
	var player = AudioStreamPlayer2D.new()
	player.stream = hurt_sfx
	player.volume_db = -3.0
	add_child(player)
	player.play()

	await get_tree().create_timer(3.0).timeout
	player.queue_free()
	set_flash_state(false)
	color_board_tiles()
	invincible = false

func set_flash_state(state:bool):
	is_flashing = state
	if is_flashing:
		active_color = FLASH_COLOR
	else:
		active_color = Globals.COLOR_MAP[selected_color]
	
func color_board_tiles():
	for bt in tiles:
		bt.update_color(active_color)

func swap_color():
	is_primary_selected = not is_primary_selected
	if is_primary_selected:
		selected_color = primary_color
		%PrimaryIndicator.set_selected(true)
		%SecondaryIndicator.set_selected(false)
	else:
		selected_color = secondary_color
		%PrimaryIndicator.set_selected(false)
		%SecondaryIndicator.set_selected(true)
	if not is_flashing:
		active_color = Globals.COLOR_MAP[selected_color]
		color_board_tiles()

func remove_tail():
	var back = tiles.pop_back()
	if(tiles.find(back) == -1):
		back.clear()
