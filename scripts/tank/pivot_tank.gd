extends TankBase

const TANK_ROTATE_SPEED = PI
const ROTATION_CLAMP = PI/3

func init( col_enum: Globals.Colors):
	base_init(col_enum)

func _process(_delta: float) -> void:
	if is_idle:
		var new_rotation = randf_range(-ROTATION_CLAMP, ROTATION_CLAMP)
		turn_to_and_shoot(new_rotation)
		is_idle = false

func turn_to_and_shoot(new_rotation: float):
	var tween = get_tree().create_tween()
	tween.tween_property(%Cannon, "rotation", new_rotation, abs(maxf(rotation, new_rotation) - minf(rotation, new_rotation))/TANK_ROTATE_SPEED)
	tween.tween_interval(1)
	tween.tween_callback(shoot)
	tween.tween_interval(1)
	tween.tween_callback(func(): is_idle = true)
