extends CharacterBody2D

@onready var animate = $AnimatedSprite2D

@export var is_sleep = true

var max_health = 1.0
var health

var dead = false

func _ready():
	health = max_health
	if is_sleep:
		animate.play("Idle")

func _process(_delta):
	if !is_sleep && !dead:
		animate.play("Flying")

func _on_hit_area_area_entered(area):
	if area.get_parent() is Player && !dead:
		attack(area)
	
func wake_up():
	if !is_sleep:
		return
	$AudioStreamPlayer2D.playing = true
	animate.play("CellingOut")
	await get_tree().create_timer(0.3).timeout
	is_sleep = false

func take_damage(damage):
	if !dead:
		health -= damage
		get_node("HealthBar").update_healthbar(health, max_health)
		if health <= 0:
			die()

func attack(entity):
	entity.get_parent().take_damage(1)

func die():
	dead = true
	animate.play("Die")
	await get_tree().create_timer(0.4).timeout
	queue_free()


