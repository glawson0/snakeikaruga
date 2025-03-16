extends Node2D

const SPAWN_OFFSET = Vector2(16,64)
var bullet_prefab = preload("res://prefabs/tank_bullet.tscn")
var is_idle = true
var locationProvider:LocationProvider
var color: Globals.Colors

func _ready() -> void:
	pass # Replace with function body.

func init(locationProvider: LocationProvider, color: Globals.Colors):
	self.locationProvider = locationProvider
	self.color=color
	set_color(Globals.COLOR_MAP[color])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_idle && locationProvider != null:
		move_to_and_shoot(locationProvider.get_location())
		is_idle = false

func shoot():
	var bullet = bullet_prefab.instantiate()
	bullet.init(Vector2(0,64), color)
	get_parent().add_child(bullet)
	bullet.position = position + SPAWN_OFFSET
	bullet.z_index = 1
	

func move_to_and_shoot(destination: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", destination, 2)
	tween.tween_interval(1)
	tween.tween_callback(shoot)
	tween.tween_interval(1)
	tween.tween_callback(func(): is_idle = true)

func set_color(color:Color):
	%BodyCenter.material.set_shader_parameter("ColorParameter",color)
	%CannonCenter.material.set_shader_parameter("ColorParameter",color)

func get_y_offset()-> float:
	return 64
