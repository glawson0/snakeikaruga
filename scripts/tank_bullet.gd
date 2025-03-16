extends Area2D
class_name TankBullet

var velocity: Vector2
var color: Globals.Colors

func _ready() -> void:
	get_tree().create_timer(20).timeout.connect(queue_free)

func init(velocity: Vector2, color: Globals.Colors):
	self.velocity = velocity
	self.color = color
	set_color(Globals.COLOR_MAP[color])

func _process(delta: float) -> void:
	if (velocity != null):
		var move = velocity * delta
		position += move

func set_color(color: Color):
	%BulletCenter.material.set_shader_parameter("ColorParameter",color)
