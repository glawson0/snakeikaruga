extends Area2D
class_name BoardTile

const CLEAR: Color = Color(1,1,1,0)

var x:int
var y:int
var state: Contains = Contains.Empty

enum Contains {Empty, Snake, Pellet, Invalid}
var is_pellet_eligible = true

func get_width() -> int:
	return %Outline.texture.get_width()

func get_height() -> int:
	return %Outline.texture.get_height()

func init(co_x:int, co_y:int, is_valid: bool, pellet_eligible = true):
	x = co_x
	y = co_y
	if not is_valid:
		state = Contains.Invalid
		visible = false
	is_pellet_eligible = pellet_eligible
	
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

func can_be_pellet()-> bool:
	return state == Contains.Empty and is_pellet_eligible

func is_invalid() -> bool:
	return state != Contains.Invalid

func update_color(color: Color):
	%Center.material.set_shader_parameter("ColorParameter",color)
