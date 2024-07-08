extends Control

var _main_screen = "res://Scenes/UI/main_screen.tscn"


func _ready():
	$CenterContainer/Label.text = "[center][wave]GAME OVER 
COINS: %s[/wave][/center]" % GameManager.coins
	GameManager.coins = 0
	GameManager.lives = 3

func _on_timer_timeout():
	get_tree().change_scene_to_file(_main_screen)
