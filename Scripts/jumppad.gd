extends Node2D

@export var force = -500

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		$Sprite2D.play("Active")
		area.get_parent().velocity.y = force
