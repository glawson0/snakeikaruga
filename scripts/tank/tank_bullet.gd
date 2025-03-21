extends Area2D
class_name TankBullet

var vel: Vector2
var color: Globals.Colors

func init(b_vel: Vector2, b_color: Globals.Colors):
	vel = b_vel
	color = b_color
	set_color(Globals.COLOR_MAP[color])

func _process(delta: float) -> void:
	if (vel != null):
		var move = vel * delta
		position += move

func set_color(color_val: Color):
	%BulletCenter.material.set_shader_parameter("ColorParameter",color_val)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
