extends Node2D
class_name PelletPlacer

@export var PELLET_COLOR: Color

var pellet_max: int

func _ready() -> void:
		seed(5)

func init(tile_count: int):
	pellet_max = tile_count -1

func next_tile_index() -> int:
	return randi_range(0, pellet_max)

func get_color() -> Color:
	return PELLET_COLOR
