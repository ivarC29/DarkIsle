extends Node2D
class_name CheckPointTree

@export var spawnpoint = false

var activated = false

func _ready():
	if spawnpoint:
		activate()

func activate():
	GameManager.current_checkpoint = self
	activated = true
	$AnimationPlayer.play("Activated")

func _on_area_2d_area_entered(area):
	print("hola")
	if area.get_parent() is Player && !activated:
		activate()
