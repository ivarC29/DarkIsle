extends Node2D

@export var max_durability = 3
@export var durability = 0

@onready var spawn_pos = global_position
var reward = preload("res://Scenes/Interactable/coin.tscn")

func _ready():
	durability = max_durability

func crack_object():
	durability -= 1
	$AnimationPlayer.play("Hit")
	if durability <= 0:
		destroyed()
	
func destroyed():
	$AnimationPlayer.play("Destroyed")
	await get_tree().create_timer(0.4).timeout
	var spawned_reward = reward.instantiate()
	spawned_reward.global_position = position
	get_tree().get_root().get_child(1).add_child(spawned_reward)
	queue_free()
