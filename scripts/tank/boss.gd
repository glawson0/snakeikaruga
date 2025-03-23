extends TankBase

var left_cannons
var right_cannons
var left_tween
var right_tween

var shoot_time = 1.0
var started = false

func init():
	base_init(Globals.Colors.PURPLE)
	%LCannon.set_color(Color.GREEN)
	%LCannon2.set_color(Color.GREEN)
	%LCannon3.set_color(Color.GREEN)
	%PivotCannon.set_color(Color.GREEN)
	%Cannon.set_color(Color.GREEN)
	%Cannon2.set_color(Color.RED)
	%Cannon3.set_color(Color.GREEN)
	%Cannon4.set_color(Color.RED)
	%Cannon5.set_color(Color.GREEN)
	%Cannon6.set_color(Color.RED)
	%PivotCannon2.set_color(Color.RED)
	%RCannon.set_color(Color.RED)
	%RCannon2.set_color(Color.RED)
	%RCannon3.set_color(Color.RED)

	left_cannons=[%LCannon,%LCannon2,%LCannon3]
	right_cannons=[%RCannon,%RCannon2,%RCannon3]
	
	left_tween = create_tween()
	left_tween.tween_property(%PivotCannon,"rotation",-PI/3,2)
	left_tween.tween_property(%PivotCannon,"rotation",0,2)
	left_tween.set_loops()
	
	right_tween = create_tween()
	right_tween.tween_property(%PivotCannon2,"rotation",PI/3,2)
	right_tween.tween_property(%PivotCannon2,"rotation",0,2)
	right_tween.set_loops()
	
	is_idle = true
	started = true


func _process(delta: float) -> void:
	if is_idle:
		if randf() > .5:
			wing_shoot()
		else:
			v_shoot()
	if started:
		shoot_time -= delta
	if shoot_time < 0:
		shoot_pivots()
		shoot_time = randf_range(1.0, 4.0)

func shoot_pivots():
	shoot(%PivotCannon,Globals.Colors.GREEN)
	shoot(%PivotCannon2,Globals.Colors.RED)

func v_shoot():
	is_idle = false
	var timer_tween = create_tween()
	timer_tween.tween_callback(shoot_outside_v)
	timer_tween.tween_interval(.3)
	timer_tween.tween_callback(shoot_inside_v)
	timer_tween.tween_interval(.3)
	timer_tween.tween_callback(shoot_outside_v)
	timer_tween.tween_interval(1.2)
	await timer_tween.finished
	is_idle = true


func shoot_outside_v():
	shoot(%Cannon,Globals.Colors.GREEN)
	shoot(%Cannon2,Globals.Colors.RED)
	shoot(%Cannon5,Globals.Colors.GREEN)
	shoot(%Cannon6,Globals.Colors.RED)

func shoot_inside_v():
	shoot(%Cannon3,Globals.Colors.GREEN)
	shoot(%Cannon4,Globals.Colors.RED)


func wing_shoot():
	is_idle = false
	await wing_shoot_series(left_cannons, Globals.Colors.GREEN)
	await wing_shoot_series(right_cannons, Globals.Colors.RED)
	await wing_shoot_series(left_cannons, Globals.Colors.GREEN)
	await wing_shoot_series(right_cannons, Globals.Colors.RED)
	await create_tween().tween_interval(1.2).finished
	is_idle = true
	
func wing_shoot_series(cannons: Array, b_color: Globals.Colors):
	var tween = create_tween()
	for cannon in cannons:
		tween.tween_callback(func(): shoot(cannon,b_color)).set_delay(.1)
	await tween.finished
	
