class_name SnakeManager

var tiles: Array[BoardTile] = []
var invincible = false
var direction:= Globals.Direction.RIGHT
var color


func _init(color: Color) -> void:
	self.color = color
