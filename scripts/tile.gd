extends Node2D
class_name BoardTile

const CLEAR: Color = Color(1,1,1,0)

var x:int
var y:int
var is_snake = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_width() -> int:
	return %Outline.texture.get_width()

func get_height() -> int:
	return %Outline.texture.get_height()

func init(x:int, y:int):
	self.x = x
	self.y = y
	
	
## Sets tile as a Snake 
## return true if successful, false if cannot
func set_snake(color: Color) -> bool:
	if(is_snake):
		return false
	%Center.material.set_shader_parameter("ColorParameter",color)
	is_snake = true
	return true

func clear_snake():
	%Center.material.set_shader_parameter("ColorParameter",CLEAR)
	is_snake = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
