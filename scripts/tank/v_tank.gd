extends TankBase

const TANK_MOVE_SPEED = 128
var lp:LocationProvider
var c1: Globals.Colors
var c2: Globals.Colors


func init(locationProvider: LocationProvider, color1: Globals.Colors, color2: Globals.Colors):
	base_init(Globals.Colors.PURPLE)
	lp = locationProvider
	c1 = color1
	c2 = color2
	%Cannon.set_color(Globals.COLOR_MAP[c1])
	%Cannon2.set_color(Globals.COLOR_MAP[c2])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_idle && lp != null:
		move_to_and_shoot(lp.get_location())
		is_idle = false

func move_to_and_shoot(destination: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", destination, position.distance_to(destination)/TANK_MOVE_SPEED)
	tween.tween_interval(1)
	tween.tween_callback(func(): shoot(%Cannon, c1))
	tween.tween_callback(func(): shoot(%Cannon2, c2))
	tween.tween_interval(1)
	tween.tween_callback(func(): is_idle = true)
