extends Node2D

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && area.get_parent().has_key:
		area.get_parent().has_key = false
		$AudioStreamPlayer.playing = true
		$AnimationPlayer.play("Unlocked")
		
func get_reward():
	GameManager.gain_coins(20)
