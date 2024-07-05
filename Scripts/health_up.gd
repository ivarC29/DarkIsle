extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().max_health += 1
		area.get_parent().health += 1
		$AudioStreamPlayer.playing = true
		$AnimationPlayer.play("Get")
