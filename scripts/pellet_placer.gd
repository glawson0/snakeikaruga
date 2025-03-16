extends Node2D
class_name PelletPlacer

@export var PELLET_COLOR: Color

var max: int

func _ready() -> void:
		seed(5)

func init(tile_count: int):
	self.max = tile_count -1

func next_tile_index() -> int:
	return randi_range(0,max)

func get_color() -> Color:
	return PELLET_COLOR
