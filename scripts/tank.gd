extends Node2D

const SPAWN_OFFSET = Vector2(16,64)
const BULLET_SPEED = Vector2(0, 4*64)
const TANK_MOVE_SPEED = 128
var bullet_prefab = preload("res://prefabs/tank_bullet.tscn")
var shoot_sound = preload("res://resources/sfx/Boss hit 1.wav")
var is_idle = true
var lp:LocationProvider
var color: Globals.Colors

func init(locationProvider: LocationProvider, col_enum: Globals.Colors):
	lp = locationProvider
	color=col_enum
	set_color(Globals.COLOR_MAP[color])
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_idle && lp != null:
		move_to_and_shoot(lp.get_location())
		is_idle = false

func shoot():
	var bullet = bullet_prefab.instantiate()
	bullet.init(BULLET_SPEED.rotated(rotation), color)
	bullet.rotation = rotation
	get_parent().add_child(bullet)
	bullet.position = position + SPAWN_OFFSET.rotated(rotation)
	bullet.z_index = 1
	_play_sfx(shoot_sound, 0)
	

func move_to_and_shoot(destination: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", destination, position.distance_to(destination)/TANK_MOVE_SPEED)
	tween.tween_interval(1)
	tween.tween_callback(shoot)
	tween.tween_interval(1)
	tween.tween_callback(func(): is_idle = true)

func set_color(color_val:Color):
	%BodyCenter.material.set_shader_parameter("ColorParameter",color_val)
	%CannonCenter.material.set_shader_parameter("ColorParameter",color_val)

func get_y_offset()-> float:
	return 64

func _play_sfx(sfx: AudioStream, volume: float):
	var player = AudioStreamPlayer2D.new()
	player.stream = sfx
	player.volume_db = volume
	add_child(player)
	player.play()
	await player.finished
	player.queue_free()
