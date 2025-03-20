extends Control


const OFF_SCREEN = Vector2(1100,0)
const ON_SCREEN = Vector2(0,0)

func _ready() -> void:
	position = OFF_SCREEN

func _on_back_button_pressed() -> void:
	position = OFF_SCREEN


func _on_options_button_pressed() -> void:
	position = ON_SCREEN
