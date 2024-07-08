extends Control


var _main_screen = "res://Scenes/UI/main_screen.tscn"


func _ready():
	$CenterContainer/RichTextLabel.text = "[center][wave]You Win !! 
Coins: %s[/wave][/center]" % GameManager.coins
	GameManager.coins = 0
	GameManager.lives = 3

func _on_timer_timeout():
	get_tree().change_scene_to_file(_main_screen)
