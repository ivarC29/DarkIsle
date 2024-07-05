extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = -70.0
var current_speed = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false
var dead = false

var max_health = 3.0
var health

var hit = false
var can_attack = true

func _ready():
	health = max_health
	$AudioStreamPlayer.playing = true
	animation.play("Idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if $RayCast2D.is_colliding():
		flip()

	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	scale.x =abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_hit_box_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		attack(area)

func take_damage(damage):
	if !dead:
		animation.play("Hit")
		health -= damage
		get_node("HealthBar").update_healthbar(health, max_health)
		if health <= 0:
			die()
			
func attack(entity):
	can_attack = false
	entity.get_parent().take_damage(1)
	await get_tree().create_timer(0.4).timeout
	animation.play("Idle")
	can_attack = true
	

func get_damage():
	hit = !hit

	if hit:
		current_speed = speed
		speed = 0
		can_attack = false
	else:
		speed = current_speed
		can_attack = true
		animation.play("Idle")
		
func die():
	dead = true
	speed = 0
	animation.play("Desappear")
	await get_tree().create_timer(0.3).timeout
	queue_free()
