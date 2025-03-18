extends Node2D
class_name ColorIndicator

var color: Color
var is_selected= false

func set_color(color_val: Color):
	color = color_val
	%Center.material.set_shader_parameter("ColorParameter",color)

func set_selected(selected: bool):
	self.is_selected = selected
	if is_selected:
		%SelectedOutline.visible= true
		%Outline.visible = false
	else: 
		%SelectedOutline.visible = false
		%Outline.visible = true
