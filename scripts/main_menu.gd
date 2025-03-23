extends Control


func _ready():
	AudioPlayer.play_menu_music()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level_1.tscn"))


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.COLOR_MAP[Globals.Colors.GREEN] = Color.BLUE
		Globals.COLOR_MAP[Globals.Colors.RED] = Color.YELLOW
	else:
		Globals.COLOR_MAP[Globals.Colors.GREEN] = Color.GREEN
		Globals.COLOR_MAP[Globals.Colors.RED] = Color.RED
