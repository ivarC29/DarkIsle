extends Node2D

@onready var hud = get_tree().get_nodes_in_group("HUD")[0]

func _ready():
	
	var live_bar = hud.get_node("LiveBar")
	$UIManager.update_coin_display()
	var lives = live_bar.get_children()
	for i in range(3):
		lives[i].visible = false
	for live in GameManager.lives:
		lives[live].visible = true



