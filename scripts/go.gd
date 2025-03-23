extends Control

func _ready() -> void:
	%RichTextLabel.add_theme_color_override("default_color", Globals.COLOR_MAP[Globals.Colors.GREEN])
