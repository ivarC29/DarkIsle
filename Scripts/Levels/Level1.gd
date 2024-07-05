extends Node2D

var level_2 = load("res://Scenes/level_2.tscn")
var next_level = false

func _process(_delta):
	if next_level:
		GameManager.change_level(level_2)

func _on_transition_tree_area_entered(area):
	if area.get_parent() is Player:
		next_level = true
		
