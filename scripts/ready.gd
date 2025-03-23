extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%RichTextLabel.add_theme_color_override("default_color", Globals.COLOR_MAP[Globals.Colors.RED])
	%ColorRect2.color = Globals.COLOR_MAP[Globals.Colors.RED]
	%ColorRect3.color = Globals.COLOR_MAP[Globals.Colors.RED]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
