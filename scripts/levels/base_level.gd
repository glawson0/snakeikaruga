extends Node2D
class_name BaseLevel

var ready_slide = preload("res://prefabs/ready.tscn")
var go_slide = preload("res://prefabs/go.tscn")
var clear_slide = preload("res://prefabs/clear.tscn")


signal start
const slide_y = 200
const inputActions = ["up", "down", "left", "right"]
var board:SnakeBoard

func _ready() -> void:
	board = %SnakeBoard
	board.game_won.connect(win_announce)
	board.game_lost.connect(game_lost)
	AudioPlayer.play_level_music()
	
	var ready_instance = ready_slide.instantiate()
	add_child(ready_instance)
	ready_instance.position = Vector2(1000, slide_y)
	ready_instance.z_index=3
	var ready_tween = get_tree().create_tween()
	ready_tween.set_ease(Tween.EASE_OUT_IN)
	ready_tween.tween_property(ready_instance, "position", Vector2(100,slide_y),.3)
	ready_tween.tween_property(ready_instance, "position", Vector2(-100,slide_y),1)
	ready_tween.tween_property(ready_instance, "position", Vector2(-1000,slide_y),.3)
	await ready_tween.finished


	var go_instance = go_slide.instantiate()
	add_child(go_instance)
	go_instance.position = Vector2(1000, slide_y)
	go_instance.z_index=3
	var go_tween = get_tree().create_tween()
	go_tween.set_ease(Tween.EASE_OUT_IN)
	go_tween.tween_property(go_instance, "position", Vector2(100,slide_y),.2)
	go_tween.tween_property(go_instance, "position", Vector2(-100,slide_y),.5)
	go_tween.tween_property(go_instance, "position", Vector2(-1000,slide_y),.2)
	await go_tween.finished
	start.emit()

func _process(_delta: float) -> void:
	
	for direction in Globals.Direction:
		if Input.is_action_just_pressed(direction.to_lower()):
			%SnakeBoard.sm.direction = Globals.Direction.get(direction)
	
	if Input.is_action_just_pressed("color_swap"):
		%SnakeBoard.sm.swap_color()

func game_lost():
	get_tree().change_scene_to_packed(load("res://scenes/MainMenu.tscn"))

func win_announce():
	board.sm.invincible = true
	board.started=false
	var clear_instance = clear_slide.instantiate()
	add_child(clear_instance)
	clear_instance.position = Vector2(1000, slide_y)
	clear_instance.z_index=3
	var ready_tween = get_tree().create_tween()
	ready_tween.set_ease(Tween.EASE_OUT_IN)
	ready_tween.tween_property(clear_instance, "position", Vector2(100,slide_y),.3)
	ready_tween.tween_property(clear_instance, "position", Vector2(-100,slide_y),1)
	ready_tween.tween_property(clear_instance, "position", Vector2(-1000,slide_y),.3)
	await ready_tween.finished
	game_won()

func game_won():
	pass
	
func map_row(tile, offset, offset_scale) -> Vector2:
	var pos = to_local(tile.global_position)
	pos.y = pos.y - (offset * offset_scale)
	return pos
	
func map_col(col,row, offset, offset_scale) -> Vector2:
	var pos = to_local(row[col].global_position)
	pos.x = pos.x + (offset * offset_scale)
	return pos
