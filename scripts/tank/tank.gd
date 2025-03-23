extends TankBase

const TANK_MOVE_SPEED = 128
var lp:LocationProvider

func init(locationProvider: LocationProvider, col_enum: Globals.Colors):
	base_init(col_enum)
	lp = locationProvider

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_idle && lp != null:
		move_to_and_shoot(lp.get_location())
		is_idle = false

func move_to_and_shoot(destination: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", destination, position.distance_to(destination)/TANK_MOVE_SPEED)
	tween.tween_interval(1)
	tween.tween_callback(func(): shoot(%Cannon, color))
	tween.tween_interval(1)
	tween.tween_callback(func(): is_idle = true)
