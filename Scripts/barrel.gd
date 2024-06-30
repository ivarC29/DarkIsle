extends Node2D

@export var max_durability = 3
@export var durability = 0

func _ready():
	durability = max_durability

func crack_object():
	durability -= 1
	$AnimationPlayer.play("Hit")
	if durability <= 0:
		destroyed()
	
func destroyed():
	$AnimationPlayer.play("Destroyed")
