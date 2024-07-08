extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var hud = get_tree().get_nodes_in_group("HUD")[0]

@export var speed = 200.0
@export var jump_velocity = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var attacking = false

var player_damage
var max_health = 3
var health = 0
var can_take_damage = true
@export var hit = false
@export var is_live = true
@export var  has_key = false

func _ready():
	player_damage = 1.0
	health = max_health
	GameManager.player = self
	
func _process(_delta):
	if Input.is_action_just_pressed("attack") && !hit:
		attack()

func _physics_process(delta):
	if !is_live:
		return
	
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		$AttackArea.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
		$AttackArea.scale.x = abs(sprite.scale.x)

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_animation()
	move_and_slide()
	
	if position.y >= 600:
		die()

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(player_damage)
		if area.get_parent().is_in_group("Objects"):
			area.get_parent().crack_object()
		
	attacking = true
	animation.play("Attack")

func update_animation():
	if !attacking && !hit:
		if velocity.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
			
		if velocity.y < 0:
			animation.play("Jump")
		if velocity.y > 0:
			animation.play("Fall")

func take_damage(damage:int):
	if can_take_damage:
		iframes()
		hit = true
		attacking = false
		animation.play("Damage")
		health -= damage
		get_node("HealthBar").update_healthbar(health, max_health)
		if health <= 0:
			is_live = false
			animation.play("Die")
			await get_tree().create_timer(1).timeout
			die()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true
		
func die():
	GameManager.remove_live()
	var live_bar = hud.get_node("LiveBar")
	var lives = live_bar.get_children()
	lives[GameManager.lives].visible = false
	GameManager.respawn_player()
