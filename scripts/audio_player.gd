extends AudioStreamPlayer2D

const level_music = preload("res://resources/music/gamejam_vrsn2_cleanloop.wav")
const menu_music = preload("res://resources/music/gamejam_bighouse.wav")

var volume = 0.0

func _play_music(music: AudioStream):
	if stream == music:
		return
	if playing:
		stop()
	volume_db = -20
	stream = music
	play()
	var vol_tween = get_tree().create_tween()
	vol_tween.tween_property(self,"volume_db", volume, 2)
	
func play_menu_music():
	_play_music(menu_music)

func play_level_music():
	_play_music(level_music)
