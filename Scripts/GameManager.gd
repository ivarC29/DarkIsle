extends Node

signal gained_coins()

var coins : int

var current_checkpoint

var player : Player

func respawn_player():
	player.animation.play("Idle")
	player.hit = false
	player.is_live = true
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
		
func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins")
	
func change_level(level):
	get_tree().change_scene_to_packed(level)
	
