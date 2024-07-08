extends Control

var _leve1_scene = "res://Scenes/Level1.tscn"

func _on_button_pressed():
	get_tree().change_scene_to_file(_leve1_scene)
