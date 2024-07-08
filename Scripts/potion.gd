extends Node2D



func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().max_health += 1
		area.get_parent().health = area.get_parent().max_health
		area.get_parent().get_node("HealthBar").update_healthbar(area.get_parent().health, area.get_parent().max_health)
		$AnimationPlayer.play("Get")
