extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().has_key = true
		$AudioStreamPlayer.playing = true
		$AnimationPlayer.play("Get")
