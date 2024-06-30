extends StaticBody2D

var wood_spike = load("res://Scenes/Interactable/wood_spike.tscn")
var debris = load("res://Scenes/Interactable/totem_debris.tscn")

@export var shooting : bool
var firerate = 2

@onready var animation_player = $AnimationPlayer
@onready var firepoint = $FirePoint

var max_health = 3
var health

func _ready():
	health = max_health
	shooting = true
	shoot()
	
func shoot():
	while shooting:
		animation_player.play("Fire")
		await get_tree().create_timer(firerate).timeout
		
func fire():
	var spawned_woodspike = wood_spike.instantiate()
	spawned_woodspike.direction = firepoint.scale.x
	spawned_woodspike.global_position = firepoint.position
	add_child(spawned_woodspike)
	
func take_damage(damage):
	health -= damage
	get_node("HealthBar").update_healthbar(health, max_health)
	animation_player.play("Hit")
	
	if health <= 0:
		destroyed()
		
func destroyed():
	var spawned_debris = debris.instantiate()
	spawned_debris.global_position = position
	spawned_debris.get_child(1).play("Crumble")
	get_tree().get_root().get_child(1).add_child(spawned_debris)
	queue_free()
	
