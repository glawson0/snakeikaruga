extends Control


func _ready():
	AudioPlayer.play_menu_music()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level_1.tscn"))
