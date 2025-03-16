extends Area2D
class_name BoardTile

const CLEAR: Color = Color(1,1,1,0)

var x:int
var y:int
var state: Contains = Contains.Empty

enum Contains {Empty, Snake, Pellet}

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
	if(state == Contains.Snake):
		return false
	%Center.material.set_shader_parameter("ColorParameter",color)
	state = Contains.Snake
	set_deferred("monitoring",true)
	return true

func clear():
	%Center.material.set_shader_parameter("ColorParameter",CLEAR)
	set_deferred("monitoring",false)
	state = Contains.Empty

func set_pellet(color:Color):
	state = Contains.Pellet
	%Center.material.set_shader_parameter("ColorParameter",color)

func is_pellet()-> bool:
	return state == Contains.Pellet

func is_empty()-> bool:
	return state == Contains.Empty

func update_color(color: Color):
	%Center.material.set_shader_parameter("ColorParameter",color)
