extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/MainMenu.tscn"))

func _ready():
	for i in range(1,11):
		if Globals.stats.has(i):
			(%BackTracks.get_node("BackTrackLabel%d" % i) as Label).text = "%d" % Globals.stats.get(i)[0]
			(%Hits.get_node("HitLabel%d" % i) as Label).text = "%d" % Globals.stats.get(i)[1]
		else:
			(%BackTracks.get_node("BackTrackLabel%d" % i) as Label).text = "%d" % 0
			(%Hits.get_node("HitLabel%d" % i) as Label).text = "%d" % 0
