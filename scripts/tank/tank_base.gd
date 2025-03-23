extends Node2D
class_name TankBase

const BULLET_SPEED = Vector2(0, 4*64)
const SPAWN_OFFSET = Vector2(0,32)


var bullet_prefab = preload("res://prefabs/Tanks/tank_bullet.tscn")
var shoot_sound = preload("res://resources/sfx/Boss hit 1.wav")
var is_idle = false
var color: Globals.Colors

func base_init(col_enum: Globals.Colors):
	color=col_enum
	set_color(Globals.COLOR_MAP[color])
	is_idle = true

func set_color(color_val:Color):
	%BodyCenter.material.set_shader_parameter("ColorParameter",color_val)
	%Cannon.set_color(color_val)

func get_y_offset()-> float:
	return 64 + 16

func _play_sfx(sfx: AudioStream, volume: float):
	var player = AudioStreamPlayer2D.new()
	player.stream = sfx
	player.volume_db = volume
	add_child(player)
	player.play()
	await player.finished
	player.queue_free()

func shoot(cannon: Node2D, b_color: Globals.Colors):
	var bullet = bullet_prefab.instantiate()
	var cannon_rotation = cannon.global_transform.get_rotation()
	bullet.init(BULLET_SPEED.rotated(cannon_rotation), b_color)
	bullet.rotation = cannon_rotation
	get_parent().add_child(bullet)
	bullet.position = get_parent().to_local(cannon.global_position) + SPAWN_OFFSET.rotated(cannon_rotation)
	_play_sfx(shoot_sound, 0)
